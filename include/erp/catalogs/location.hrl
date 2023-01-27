-ifndef(LOCATION_HRL).
-define(LOCATION_HRL, true).

-include_lib("schema/include/erp/catalogs/dict.hrl").

-record('Loc',   { id          = [] :: [] | binary(),
                   code        = [] :: [] | binary(),
                   country     = [] :: [] | binary(), 
                   city        = [] :: [] | binary(),
                   address     = [] :: [] | binary(),
                   type        = [] :: [] | #dict{}}).

-endif.
