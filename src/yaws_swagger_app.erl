%%%-------------------------------------------------------------------
%% @doc yaws_swagger public API
%% @end
%%%-------------------------------------------------------------------

-module(yaws_swagger_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1,add_trails/1,add_trail/1,delete_trail/1,get_trails/0,get_trail/1]).

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
add_trails(Trail_list_modules) ->
	yaws_swagger_ets_server:start_trail(Trail_list_modules).


%%for adding trails
add_trail(Module_name)->
	yaws_swagger_ets_server:add(Module_name).


%%for deleting trails
delete_trail(Module_name)->
	yaws_swagger_ets_server:delete({trail,Module_name}).


%%for getting all trails in the system
get_trails()->
	ets:match_object(yaws_swagger_ets_server,{{trail,'_'},{'_','_','_'}}).
	

%%for getting trails for a particular module
get_trail(ModuleName)->
	ets:lookup(yaws_swagger_ets_server,{trail,ModuleName}).
%%====================================================================
%% Internal functions
%%====================================================================
