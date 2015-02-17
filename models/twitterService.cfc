component name="twitterService" extends="twitterExtends" accessors=true singleton {

	property name="twitterUserService" inject="twitterUserService@twitter";

	function getUser(){
		getTwitterUserService().setup(oauthToken=getOAuthToken(),oauthSecret=getOAuthSecret());

		return getTwitterUserService();
	}

}