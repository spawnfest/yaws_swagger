
# cnc
by command_n_conquer

yaws_swagger
=====

An OTP application for integrating yaws appmods(application modules) with swagger.

With this application you can document your yaws api endpoints for easy use by front end devs.
it uses  [swagger ui](https://swagger.io/swagger-ui/) to generate a user interface based on your api endpoints which you feed into the applicaton .


   
    
To Use
------    
    
	in your rebar.config add the application as a dependancy .
  
   ```
   {yaws_swagger,{git,"https://github.com/spawnfest/yaws_swagger.git",{branch,"master"}}}`
   ```
then in your application start module  add a list of modules which have the behaviour yaws_swagger_trails implemented 
using the yaws_swagger_app:add_trails/1 or yaws_swagger_app:add_trail/1 functions .
find a sample application module below below 
```
%%%-------------------------------------------------------------------
%% @doc yapp_sample_app public API
%% @end
%%%-------------------------------------------------------------------

-module(yapp_sample_app_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
	yaws_swagger_app:add_trails([yaws_swagger_appmod_sample,yaws_swagger_appmod_sample2]),
	%%list of modules implementing the behaviour yaws_swagger_trails [yaws_swagger_appmod_sample,yaws_swagger_appmod_sample2]
    yapp_sample_app_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions which must be implemented in the module containing metadata 
%%====================================================================

```

the ```yaws_swagger_app:add_trails/1``` function adds a list of modules  which you want to feed into the yaws_swagger application.

the modules must implement the ```-behaviour(yaws_swagger_trails).```
which means they must return a trails function whic contains metadata which will be fed into the yaws_swagger application
```
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
  ```


%%====================================================================
%% Configuration in yaws.conf file
%%====================================================================

  
  in your yaws.conf file add a yapp called yaws_swagger which is a yapp itself
  ```
  ###yap servers
###yap admin server
<server yapp_server>
        port = 8008
        listen = 0.0.0.0
		docroot = priv/docroot_gconf
        dir_listings = false
        arg_rewrite_mod = yapp
        <opaque>
           yapp_server_id = internal
	   bootstrap_yapps = yaws_swagger
        </opaque>
</server>
```
browser to   ```localhost:8008\yaws_swagger``` to view swagger docs
to manipulate trails information find functions below 
there are various function for manipulation the trails list 

* ```yaws_swagger_app:add_trails/1```
* ```yaws_swagger_app:add_trail/1```
* ```yaws_swagger_app:get_trails/0```
* ```yaws_swagger_app:delete_trail/1```

enjoy!!

