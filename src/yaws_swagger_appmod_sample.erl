%%% 
-module(yaws_swagger_appmod_sample).

-export([trails/0]).


trails()->
	Metadata =
    #{get =>
      #{tags => ["example"],
        description => "Retrives trails's server description",
        produces => ["text/plain"]
      }
    },
  {"users","Description",Metadata}.
