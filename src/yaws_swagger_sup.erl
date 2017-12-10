%%%-------------------------------------------------------------------
%% @doc yaws_swagger top level supervisor.
%%%this also starts up the ets server which is used for storing routes
%%contains crud  methods for retreiving info about routes
%% @end
%%%-------------------------------------------------------------------

-module(yaws_swagger_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1,start_trail/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).


start_trail(Trail_list_modules) ->
    ChildSpec = {yaws_swagger_ets_serv,
                 {yaws_swagger_ets_server, start_link,[Trail_list_modules]},
                  permanent, 10500, worker, [yaws_swagger_ets_server]},
    supervisor:start_child(?SERVER, ChildSpec).
%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
	{ok, {{one_for_one, 6, 3600}, []}}.

%%====================================================================
%% Internal functions
%%====================================================================
