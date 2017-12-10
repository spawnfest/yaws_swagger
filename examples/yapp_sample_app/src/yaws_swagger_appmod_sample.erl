%%% 
-module(yaws_swagger_appmod_sample).
-behaviour(yaws_swagger_trails).

-include_lib("yaws/include/yaws_api.hrl").

-export([trails/0,out/1]).



out(A) ->
    {ehtml,
     [{p,[],
       box(io_lib:format("A#arg.appmoddata = ~p~n"
                         "A#arg.appmod_prepath = ~p~n"
                         "A#arg.querydata = ~p~n",
                         [A#arg.appmoddata,
                          A#arg.appmod_prepath,
                          A#arg.querydata]))}]}.


box(Str) ->
    {'div',[{class,"box"}],{pre,[],Str}}.


trails()->
	RequestBody =
    #{ name => <<"request body">>
     , in => body
     , description => <<"request body (as json)">>
     , required => true
     },
  Metadata =
    #{ get =>
       #{ tags => [<<"newspapers">>]
        , description => <<"Returns the list of newspapers">>
        , produces => [<<"application/json">>]
        }
     , post =>
       # { tags => [<<"newspapers">>]
         , description => <<"Creates a new newspaper">>
         , consumes => [<<"application/json">>]
         , produces => [<<"application/json">>]
         ,parameters =>[RequestBody]
         }
     },
    Path = <<"/appmod/">>,
  {Path," ",[{req_body,RequestBody},{metadata,Metadata}]}.
