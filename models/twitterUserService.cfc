component name="twitterUserService" extends="twitterExtends" accessors=true singleton {

	function show(required any userID=0){

		if( !isNumeric(arguments.userID) || !arguments.userID ){
			throw("Invalid Twitter UserID. UserID Required",'twitter.show');
		}

		oauthService.init();
		oauthService.setRequestMethod('GET');
		oauthService.setConsumerKey(getConsumerKey());
		oauthService.setConsumerSecret(getConsumerSecret());
		oauthService.setOAuthToken(getOAuthToken());
		oauthService.setOAuthSecret(getOAuthSecret());
		oauthService.setRequestURL('https://api.twitter.com/1.1/users/show.json');
		oauthService.addParam(name="user_id",value=arguments.userID);

		return checkResponse(oauthService.send());
	}

}