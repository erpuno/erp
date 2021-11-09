-ifndef(ORG_DOC_HRL).
-define(ORG_DOC_HRL, true).

-include("dict/person.hrl").

-record(orgDoc,  { id= [] :: binary(),
                   guid= [] :: list(),
                   urgent=[] :: [] | boolean(),
                   date = [] :: [] | calendar:datetime(),
                   xml = [] :: [] | binary(),
                   hash = [] :: binary() | list(),
                   signature = [] :: binary() | list(),
                   document_type = <<"Огранізаційно-розпорядчий документ"/utf8>> :: term(),
                   nomenclature=[] :: term(),
                   branch=[] :: [] | list(),
                   head=[] :: [] | #'Person'{},
                   executor=[] :: [] | #'Person'{},
                   content=[] :: [] | list(),
                   approvers = [] :: list(#'Person'{}),
                   signatory = [] :: [] | list(#'Person'{}),
                   control=[] :: [] | boolean(),
                   control_by=[] :: [] | #'Person'{},
                   notify = [] :: [] | list(#'Person'{}),
                   dueDate = [] :: [] | calendar:datetime(),
                   assigned = [] :: [] | #'Person'{},
                   target = [] :: [] | list(#'Person'{}),
                   canceled = [] :: [] | boolean(),
                   cancelDate = [] :: [] | calendar:datetime(),
                   registered_by=[] :: [] | #'Person'{},
                   editDate = [] :: [] | calendar:datetime(),
                   note = [] :: list(),
                   attachments = [] :: list(term()),
                   project = [] :: term(),
                   proc_id = [] :: list(),
                   created_by = [] :: term(),
                   created = [] :: term(),
                   modified_by = [] :: term(),
                   modified = [] :: term(),
                   template = [] :: term()

}).

-endif.
