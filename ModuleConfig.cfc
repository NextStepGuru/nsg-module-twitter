component {

	// Module Properties
	this.title 				= "twitter";
	this.author 			= "";
	this.webURL 			= "";
	this.description 		= "";
	this.version			= "1.0.0";
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
	this.dependencies 		= [];

	function configure(){

		// parent settings
		parentSettings = {

		};

		// module settings - stored in modules.name.settings
		settings = {

		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {

		};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			{pattern="/oauth/:id?", handler="oauth",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Binder Mappings
		binder.mapDirectory( "models" );

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}