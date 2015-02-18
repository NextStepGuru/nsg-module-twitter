component {

	// Module Properties
	this.title 				= "twitter";
	this.author 			= "Jeremy R DeYoung";
	this.webURL 			= "http://www.nextstep.guru";
	this.description 		= "This is the default configuration for nsg's layout.";
	this.version			= "1.0.3";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "twitter";
	// Model Namespace
	this.modelNamespace		= "twitter";
	// CF Mapping
	this.cfmapping			= "twitter";
	// Module Dependencies
	this.dependencies 		= ["nsg-module-security","nsg-module-oauth"];

	function configure(){

		// parent settings
		parentSettings = {

		};

		// module settings - stored in modules.name.settings
		settings = {
			oauth = {
				oauthVersion 		= 1,
				tokenRequestURL 	= "https://api.twitter.com/oauth/request_token",
				authorizeRequestURL = "https://api.twitter.com/oauth/authorize",
				accessRequestURL 	= "https://api.twitter.com/oauth/access_token"
			}
		};

		// Layout Settings
		layoutSettings = {
		};

		// datasources
		datasources = {

		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="oauth",action="index"},
			{pattern="/oauth/:id?", handler="oauth",action="index"}
		];

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = "twitterLoginSuccess,twitterLoginFailure"
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Binder Mappings
		binder.mapDirectory( "#moduleMapping#.models" );

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		var nsgSocialLogin = controller.getSetting('nsgSocialLogin',false,arrayNew());
			arrayAppend(nsgSocialLogin,{"name":"twitter","icon":"twitter","title":"Twitter"});
			controller.setSetting('nsgSocialLogin',nsgSocialLogin);
		var nsgMenu = controller.getSetting('nsgMenu',false,[]);
		// menu::login
		arrayAppend(nsgMenu,{ "menu"="topRight","subid":"login","icon"="fa fa-twitter","id":"loginTwitter","title":"Sign-in with Twitter","link":"/security/login/twitter","roles":"","type":"link","isUserLoggedIn":false });
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}