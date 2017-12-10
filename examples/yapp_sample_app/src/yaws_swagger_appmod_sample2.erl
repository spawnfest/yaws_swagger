%%% 
-module(yaws_swagger_appmod_sample2).
-behaviour(yaws_swagger_trails).

-export([trails/0]).


trails()->
	RequestBody =
    #{ name => <<"echo Server">>
     , in => body
     , description => <<"request body (as json)">>
     , required => true
     },
	 Metadata =
	    #{get =>
	      #{tags => [<<"echo">>],
	        description => <<"Gets echo var from the server">>,
	        produces => [<<"text/plain">>]
	      },
	      put =>
	      #{tags => [<<"echo">>],
	        description => <<"Sets echo var in the server">>,
	        produces => [<<"text/plain">>],
	        parameters => [
	          #{name => <<"echo">>,
	            description => <<"Echo message">>,
	            in => <<"path">>,
	            required => false,
	            type => <<"string">>}
	        ]
	      }
	    },
    Path = <<"/messages/">>,
  {Path," ",[{req_body,RequestBody},{metadata,Metadata}]}.
