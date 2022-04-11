package types;

typedef WebIdl = {
	@:optional
	var callbackFunctions : {
		var callbackFunction : haxe.DynamicAccess<CallbackFunction>;
	};
	@:optional
	var callbackInterfaces : {
		@:native("interface")
		var interface_ : haxe.DynamicAccess<Interface>;
	};
	@:optional
	var dictionaries : {
		var dictionary : haxe.DynamicAccess<Dictionary>;
	};
	@:optional
	var enums : {
		@:native("enum")
		var enum_ : haxe.DynamicAccess<Enum_>;
	};
	@:optional
	var interfaces : {
		@:native("interface")
		var interface_ : haxe.DynamicAccess<Interface>;
	};
	@:optional
	var mixins : {
		var mixin : haxe.DynamicAccess<Interface>;
	};
	@:optional
	var typedefs : {
		@:native("typedef")
		var typedef_ : Array<TypeDef>;
	};
	@:optional
	var namespaces : Array<Interface>;
};