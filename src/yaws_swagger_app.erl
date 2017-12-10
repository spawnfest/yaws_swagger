%%%-------------------------------------------------------------------
%% @doc yaws_swagger public API
%% @end
%%%-------------------------------------------------------------------

-module(yaws_swagger_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1,start_trail/1,add_trail/1,delete_trail/1,get_trails/0]).

%%====================================================================
%% API
%%====================================================================

%%for starting application
start(_StartType, _StartArgs) ->
    yaws_swagger_sup:start_link().


%%for stopping application
%%--------------------------------------------------------------------
stop(_State) ->
    ok.


%%for starting trails
start_trail(Trail_list_modules) ->
	yaws_swagger_sup:start_trail(Trail_list_modules).


%%for adding trails
add_trail(Module_name)->
	yaws_swagger_ets_server:add(Module_name).


%%for deleting trails
delete_trail(Module_name)->
	yaws_swagger_ets_server:delete(Module_name).


%%for getting all trails in the system
get_trails()->
	ets:lookup(yaws_swagger_ets_server,trails).
%%====================================================================
%% Internal functions
%%====================================================================
