%%% @doc Trails handler.
%%%      This behavior defines the callback `trails/0' which must be
%%%      implemented by the different `yaws' appmods in your project.
-module(yaws_swagger_trails).

%% API
-export([trails/1]).

%% @doc Returns the appmod routes defined in the called module.
-callback trails() -> maps:new().

-spec trails(module()) -> maps:new().
trails(Module) -> Module:trails().
