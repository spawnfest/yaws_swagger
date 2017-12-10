%%%-------------------------------------------------------------------
%% @doc ets server for storing routes.
%% @end
%%%-------------------------------------------------------------------

-module(yaws_swagger_ets_server).
-behaviour(gen_server).


%% API exports
-export([start_link/1, stop/0, add/1,delete/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).
         

%%for starting the ets server 
start_link([Trail_list_modules]) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [Trail_list_modules], []).


%%for stopping the ets server
stop() ->
    gen_server:call(?MODULE, stop).



%% Create a new Category with metainfo
add(Name) ->
    gen_server:call(?MODULE, {create,Name}).


%% Deletes a Category with all the trails under it 
delete(Name) ->
    gen_server:call(?MODULE, {delete,Name}).




%%====================================================================
%% Internal functions
%%====================================================================
%%====================================================================
%% Gen Server Callbacks
%%====================================================================

init(Trail_list_modules) ->
	io:format("~ntrail list is ~p ",[Trail_list_modules]),
	?MODULE = ets:new(?MODULE, [bag, named_table, protected]),
	F = 
	fun(Module)->
		{Appmod,Description,Metadata} = Module:trails(),
		{trails,{Appmod,Description,Metadata}}
	end,
	Trails_list_appmods = lists:map(F,Trail_list_modules),
	ets:insert(?MODULE,Trails_list_appmods),
    {ok, ?MODULE}.


handle_call({create, Name}, _From,ServerName) ->
	{reply,ok,ServerName};


handle_call({delete, Name}, _From,ServerName) ->
	{reply,ok,ServerName}.


handle_cast(_, State) ->
    {noreply, State}.


handle_info(_, State) ->
    {noreply, State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.
