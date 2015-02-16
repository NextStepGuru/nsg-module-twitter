Coldbox Module to allow Social Login via Twitter
================

Setup & Installation
---------------------

####Add the following structure to Coldbox.cfc
	twitter = {
		oauth = {
			// This must MATCH exactly the twitter oauth callback url
			callbackURL		= "http://www.nextstep.guru/twitter/oauth",

			// URL where success will be sent
			loginSuccess	= "login.success",

			// URL where failures will be sent
			loginFailure	= "login.failure",

			// Twitter provided consumer Key & Secret
			consumerKey		= "{{Twitter_Provided_Consumer_Key_Here}}",
			consumerSecret	= "{{Twitter_Provided_Consumer_Secret_Here}}"
		}
	}

Interception Point
---------------------
If you want to capture any data from a successful login, use the interception point twitterLoginSuccess. Inside the interceptData structure will contain all the provided data from twitter for the specific user.

####An example interception could look like this

	component {

		function twitterLoginSuccess(event,interceptData){
			var queryService = new query(sql="SELECT roles,email,password FROM user WHERE twitterUserID = :id;");
				queryService.addParam(name="id",value=interceptData['user_id']);
			var lookup = queryService.execute().getResult();

			if( lookup.recordCount ){
				login {
					loginuser name=lookup.email password=lookup.password roles=lookup.roles;
				};
			}else{
				// create new user
			}

		}
	}

