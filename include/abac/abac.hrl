-ifndef(ABAC_HRL).
-define(ABAC_HRL, true).

% API endpoints:
%
% BLOCK    : block user
% SEARCH   : Search documents and fields
% VIEW     : Tabs; menu; assistant, search buttons; chat; hidden form fields
%
% CREATE   : New document combo box; add document, add resolution, register buttons; notifications user filters
% EDIT     : Edit form, button, attachments (add, delete, onlyoffice edit; certification, main, sign marks)
% DELETE   : Delete process button
%
% NEXT     : Task buttons (+ agreement delegated, convert to pdf)
% REJECT   : Reject buttons (to stage, parent reject)
% SIGN     : Signing, agreement, certification, notify buttons; multiple signing checkbox
% REGISTER : Document registration button
% CANCEL   : Cancel execution, status, reject sev/email buttons
% SEND     : Send button (sev, email, sendOrder)
% RECEIVE  : Receive button (sev, email docs); sevListener, pop3Listener
% STATUS   : Execution, to attention, assistant processed buttons


% PRINT    : Print buttons

-record(rule, {
              id = [] :: binary(),
              creator = [] :: atom(),
              api_endpoint = [] :: atom(),
              description = <<>> :: binary(),
              type = permit :: permit | deny,
              subject_condition = [] :: [] | list(),
              object_condition = [] :: [] | list(),
              resource_match = any :: any | all,
              subject = [] :: [],
              object = [] :: [],
              values = [] :: []
}).

-record(policy, {
              id = [] :: binary(),
              creator = [] :: atom(),
              api_endpoint = [] :: atom(),
              description = <<>> :: binary(),
              combining = all :: all | any,
              object = [] :: [] | tuple(),
              rules = [] :: [] | list()
}).

-record(rule_ref, {
  id = [] :: [] | list() | binary(),
  resource_match = any :: any | all
}).

-endif.