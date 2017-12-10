%%%-------------------------------------------------------------------
%% @doc ets server for storing routes.
%% @end
%%%-------------------------------------------------------------------

-module(yaws_swagger_ets_server).
-behaviour(gen_server).


%% API exports
-export([start_link/0, stop/0, add/1,delete/1,start_trail/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).
         

%%for starting the ets server 
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


%%for stopping the ets server
stop() ->
    gen_server:call(?MODULE, stop).


start_trail(Trail_list_modules)->
    gen_server:call(?MODULE, {start_trails,Trail_list_modules}).
	

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

init([]) ->
	?MODULE = ets:new(?MODULE, [bag, named_table, protected]),
    {ok, ?MODULE}.


handle_call({start_trails, Trail_list_modules}, _From,ServerName) ->
	io:format("~ntrail list is ~p ",[Trail_list_modules]),
	F = 
	fun(Module)->
		{Appmod,Description,Metadata} = Module:trails(),
		{{trail,Module},{Appmod,Description,Metadata}}
	end,
	Trails_list_appmods = lists:map(F,Trail_list_modules),
	ets:insert(?MODULE,Trails_list_appmods),
	{reply,ok,ServerName};


handle_call({create, Module}, _From,ServerName) ->
	{Appmod,Description,Metadata} = Module:trails(),
	Trail_ets = {{trail,Module},{Appmod,Description,Metadata}},
	ets:insert(?MODULE,Trail_ets),
	{reply,ok,ServerName};


handle_call({delete, Name}, _From,ServerName) ->
	ets:delete(?MODULE, Name),
	{reply,ok,ServerName}.


handle_cast(_, State) ->
    {noreply, State}.


handle_info(_, State) ->
    {noreply, State}.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


terminate(_Reason, _State) ->
    ok.
