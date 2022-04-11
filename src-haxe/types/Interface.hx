package types;

typedef Interface = {
	var name : String;
	@:optional
	var mixin : Bool;
	@:optional
	@:native("extends")
	var extends_ : String;
	@:optional
	var comment : String;
	@:optional
	var constants : {
		var constant : haxe.DynamicAccess<Constant>;
	};
	var methods : {
		var method : haxe.DynamicAccess<Method>;
	};
	@:optional
	var events : {
		var event : Array<Event>;
	};
	@:optional
	var attributelessEvents : {
		var event : Array<Event>;
	};
	@:optional
	var properties : {
		var property : haxe.DynamicAccess<Property>;
		@:optional
		var namesakes : haxe.DynamicAccess<Array<Property>>;
	};
	@:optional
	var constructor : Constructor;
	@:optional
	@:native("implements")
	var implements_ : Array<String>;
	@:optional
	var anonymousMethods : {
		var method : Array<AnonymousMethod>;
	};
	@:optional
	@:native("anonymous-content-attributes")
	var anonymous_content_attributes : {
		var parsedattribute : Array<ParsedAttribute>;
	};
	@:optional
	var element : Array<Element>;
	@:optional
	var namedConstructor : NamedConstructor;
	@:optional
	var exposed : String;
	@:optional
	var overrideExposed : String;
	@:optional
	var tags : String;
	@:optional
	@:native("implicit-this")
	var implicit_this : Int;
	@:optional
	var noInterfaceObject : Bool;
	@:optional
	var global : String;
	@:optional
	var typeParameters : Array<TypeParameter>;
	@:optional
	var overrideIndexSignatures : Array<String>;
	@:optional
	var specs : String;
	@:optional
	var iterator : Iterator_;
	@:optional
	var legacyWindowAlias : Array<String>;
	@:optional
	var legacyNamespace : String;
	@:optional
	var nested : {
		var interfaces : Array<Interface>;
		var enums : Array<Enum_>;
		var dictionaries : Array<Dictionary>;
		var typedefs : Array<TypeDef>;
	};
	@:optional
	var deprecated : ts.AnyOf2<String, Bool>;
	@:optional
	var secureContext : Bool;
};