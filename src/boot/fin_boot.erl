-module(fin_boot).
-compile(export_all).
-include("person.hrl").
-include("acc.hrl").
-include("product.hrl").
-include("payment.hrl").
-include("investment.hrl").
-include_lib("kvs/include/kvs.hrl").
-include_lib("kvs/include/cursors.hrl").

boot() ->
   accounts(),
   inv_boot().

acc("NYNJA" = X) ->
   [ #'Acc'{id = X ++ "/insurance", rate = {dec,2,70}},
     #'Acc'{id = X ++ "/options", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/reserved", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/R&D", rate = {dec,2,10}}
   ];

acc("CATALX" = X ) ->
   [ #'Acc'{id = X ++ "/insurance", rate = {dec,2,50}},
     #'Acc'{id = X ++ "/options", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/reserved", rate = {dec,2,15}},
     #'Acc'{id = X ++ "/R&D", rate = {dec,2,15}}
   ];

acc("FinaTech-Evoli" = X ) ->
   [ #'Acc'{id = X ++ "/insurance", rate = {dec,2,50}},
     #'Acc'{id = X ++ "/options", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/reserved", rate = {dec,2,15}},
     #'Acc'{id = X ++ "/R&D", rate = {dec,2,15}}
   ];

acc("FinaTech-Stamps" = X ) ->
   [ #'Acc'{id = X ++ "/insurance", rate = {dec,2,50}},
     #'Acc'{id = X ++ "/options", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/reserved", rate = {dec,2,15}},
     #'Acc'{id = X ++ "/R&D", rate = {dec,2,15}}
   ];

acc("FinaTech-Bynk" = X ) ->
   [ #'Acc'{id = X ++ "/insurance", rate = {dec,2,50}},
     #'Acc'{id = X ++ "/options", rate = {dec,2,10}},
     #'Acc'{id = X ++ "/reserved", rate = {dec,2,15}},
     #'Acc'{id = X ++ "/R&D", rate = {dec,2,15}}
   ];

% for future FIN releases and multibank accounts

acc(X) ->
   [
     #'Acc'{id = X ++ "/local", rate = {dec,0,0}},
     #'Acc'{id = X ++ "/bpe", rate = {dec,0,0}}
   ].

profit(C) ->
  lists:map(fun({#'Payment'{volume=Vo1,price=Pr1} = P1,
                 #'Payment'{volume=Vo2,price=Pr2} = P2}) ->
               P1#'Payment'{volume={dec,0,1},price=dec:sub(dec:mul(Vo1,Pr1),dec:mul(Vo2,Pr2))}
        end, lists:zip(kvs:all("/plm/"++C++"/income"),
                       kvs:all("/plm/"++C++"/outcome"))).

rate(#'Payment'{price=P, volume=V}=Pay,#'Acc'{id=Id, rate=R}=Acc,C) ->
  Pay#'Payment'{invoice= kvs:seq([],[]), volume={dec,0,1}, price=dec:mul(R,dec:mul(P,V))}.

accounts() ->
  lists:map(fun(#'Product'{code=C}) ->
    lists:map(fun(#'Acc'{id=Id}=SubAcc) ->
      Address = lists:concat(["/fin/acc/",C]),
      kvs:append(SubAcc,Address),
      Feed = lists:concat(["/fin/tx/",Id]),
      case kvs:get(writer, Feed) of
           {error,_} -> lists:map(fun(#'Payment'{}=Pay) ->
                        Payment = rate(Pay,SubAcc,C),
                        [Account,SubAccount] = string:tokens(Id,"/"),
                        kvs:append(Payment#'Payment'{account=Account,subaccount=SubAccount}, Feed) end, profit(C));
             {ok,_} -> skip
      end
    end, acc(C))
  end, plm_boot:products()).

inv_boot() ->
   lists:map(fun(#'Product'{code=C}) ->
      Staff = kvs:all("/plm/"++C++"/staff"),
      {ok, #'Acc'{rate= Rate}=Acc} = kvs:get("/fin/acc/" ++ C, C ++ "/options"),
      Hours = lists:foldl(fun (#'Person'{hours=A},Acc) -> Acc + A end,0,Staff),
      lists:map(fun(#'Person'{cn=Person,hours=X}) ->
         Feed = "/fin/tx/" ++ Person ++ "/local",
         case kvs:get(writer,Feed) of
              {error,_} ->
                  lists:map(fun(#'Payment'{}=Pay) ->
                     Div = dec:'div'({dec,0,X},{dec,0,Hours}),
                     NewPay = rate(Pay,Acc#'Acc'{rate = dec:mul(Rate,Div)},C),
                     kvs:append(NewPay#'Payment'{account=Person,subaccount="local"},Feed) end,
                     kvs:all("/fin/tx/"++C++"/options"));
              {ok,_} -> skip
         end end, Staff)
   end, plm_boot:products()).
