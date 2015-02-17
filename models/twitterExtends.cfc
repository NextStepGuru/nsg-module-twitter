component name="twitterExtends" hint="The Default twitter Setup for all Related Objects" accessors=true singleton {

	property name="oauthService" inject="oauthV1Service@oauth";
	property name="twitterCredentials" inject="coldbox:setting:twitter";
	property name="oauthToken";
	property name="oauthSecret";
	property name="consumerKey";
	property name="consumerSecret";

	function setup(required string oauthToken="",required string oauthSecret=""){
		setOAuthToken(arguments.oauthToken);
		setOAuthSecret(arguments.oauthSecret)
		setConsumerKey(getTwitterCredentials()['oauth']['consumerKey']);
		setConsumerSecret(getTwitterCredentials()['oauth']['consumerSecret']);
	}

	function checkResponse(any data){
		if(arguments.data['status_code'] == 200){
			var myData = deserializeJSON(arguments.data['fileContent']);

			if( structKeyExists(myData,'dateLastActivity') ){
				myData['modifiedAt'] = lsParseDateTime(myData['dateLastActivity']);
			}

			return myData;
		}else if(arguments.data['status_code'] == 429){
			throw("Rate-Limit Error","twitter.service");
		}else if(arguments.data['status_code'] == 401){
			throw("Unauthorized Access","twitter.service");
		}else{
			throw(data['fileContent'],"twitter.error",data['status_code'])
		}
	}

}