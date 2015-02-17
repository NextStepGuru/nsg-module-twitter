component {

	property name="oauthService" inject="oauthV1Service@oauth";
	property name="twitterService" inject="twitterService@twitter";

	function preHandler(event,rc,prc){
		if( !structKeyExists(getSetting('twitter'),'oauth') ){
			throw('You must define the OAuth setting in your Coldbox.cfc','twitter.setup');
		}
		prc.twitterCredentials = getSetting('twitter')['oauth'];
		prc.twitterSetting = getModuleSettings( module=event.getCurrentModule(), setting="oauth" );

		if(!structKeyExists(session,'twitterOAuth')){
			session['twitterOAuth'] = structNew();
		}
	}

	function index(event,rc,prc){

		if( event.getValue('id','') == 'announceUser' ){
			var results = duplicate(session['twitterOAuth']);

			twitterService.setup(results['oauth_token'],results['oauth_token_secret'])
			var data = twitterService.getUser().show(userID=results['user_id']);

			// add the user data to the announceInterception
			structAppend(results,data);

			announceInterception( state='twitterLoginSuccess', interceptData=results );
			setNextEvent(view=prc.twitterCredentials['loginSuccess'],ssl=( cgi.server_port == 443 ? true : false ));

		}else if( event.valueExists('oauth_token') ){
			session['twitterOAuth']['oauth_token'] = event.getValue('oauth_token');
			session['twitterOAuth']['oauth_verifier'] = event.getValue('oauth_verifier');

			oauthService.init();
			oauthService.setConsumerKey(prc.twitterCredentials['consumerKey']);
			oauthService.setConsumerSecret(prc.twitterCredentials['consumerSecret']);
			oauthService.setRequestURL(prc.twitterSetting['accessRequestURL']);
			oauthService.setRequestMethod('POST');
			oauthService.addParam(name="oauth_token",value=session['twitterOAuth']['oauth_token']);
			oauthService.addParam(name="oauth_verifier",value=session['twitterOAuth']['oauth_verifier']);

			var results = oauthService.send();

			if( results['status_code'] == 200 ){
				var myFields = listToArray(results['fileContent'],'&');

				for(var i=1;i<=arrayLen(myFields);i++){
					session['twitterOAuth'][listFirst(myFields[i],'=')] = listLast(myFields[i],'=');
				}
				// redirect to hide any url/code data
				setNextEvent('twitter/oauth/announceUser');
			}else{
				announceInterception( state='twitterLoginFailure', interceptData={'request':results} );
				throw('Unknown Twitter OAuth Error','twitter.access');
			}

		}else{

			oauthService.init();
			oauthService.setConsumerKey(prc.twitterCredentials['consumerKey']);
			oauthService.setConsumerSecret(prc.twitterCredentials['consumerSecret']);
			oauthService.setRequestURL(prc.twitterSetting['tokenRequestURL']);
			oauthService.setRequestMethod('POST');

			oauthService.addParam(name="oauth_callback",value=prc.twitterCredentials['callbackURL']);

			var results = oauthService.send();

			if( results['status_code'] == 200 ){
				var myFields = listToArray(results['fileContent'],'&');

				for(var i=1;i<=arrayLen(myFields);i++){
					session['twitterOAuth'][listFirst(myFields[i],'=')] = listLast(myFields[i],'=');
				}

				location(url=prc.twitterSetting['authorizeRequestURL'] & "?oauth_token=#session['twitterOAuth']['oauth_token']#",addToken=false);

			}else{
				announceInterception( state='twitterLoginFailure', interceptData={'request':results} );
				throw('Unknown Twiter OAuth Error','twitter.request');
			}
		}
	}

}