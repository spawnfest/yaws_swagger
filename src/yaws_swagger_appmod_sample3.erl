%%% 
-module(yaws_swagger_appmod_sample3).
-behaviour(yaws_swagger_trails).

-export([trails/0]).


trails()->
	RequestBody =
    #{ name => <<"request body">>
     , in => body
     , description => <<"request body (as json)">>
     , required => true
     },
  Metadata =
    #{ get =>
       #{ tags => ["newspapers"]
        , description => "Returns the list of newspapers"
        , produces => ["application/json"]
        }
     , post =>
       # { tags => ["newspapers"]
         , description => "Creates a new newspaper"
         , consumes => ["application/json"]
         , produces => ["application/json"]
         , parameters => [RequestBody] % and then use that parameter here
         }
     },
    Path = <<"/users/">>,
  {Path," ",[{req_body,RequestBody},{metadata,Metadata}]}.
