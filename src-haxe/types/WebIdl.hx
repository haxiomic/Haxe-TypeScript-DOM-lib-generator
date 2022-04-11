package types;

typedef WebIdl = {
	@:optional
	var callbackFunctions : {
		var callbackFunction : { };
	};
	@:optional
	var callbackInterfaces : {
		@:native("interface")
		var interface_ : { };
	};
	@:optional
	var dictionaries : {
		var dictionary : { };
	};
	@:optional
	var enums : {
		@:native("enum")
		var enum_ : { };
	};
	@:optional
	var interfaces : {
		@:native("interface")
		var interface_ : { };
	};
	@:optional
	var mixins : {
		var mixin : { };
	};
	@:optional
	var typedefs : {
		@:native("typedef")
		var typedef_ : Array<TypeDef>;
	};
	@:optional
	var namespaces : Array<Interface>;
};