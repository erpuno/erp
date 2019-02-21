-ifndef(CONTRACT_HRL).
-define(CONTRACT_HRL, true).

-include("organization.hrl").

-record('Contract',    { id          = [] :: [] | binary(),
                         prev        = [] :: [] | binary(),
                         next        = [] :: [] | binary(),
                         nane        = [] :: [] | binary(),
                         parties     = [] :: [] | list(#'Organization'{}),
                         rules       = [] :: term() }).

-endif.
