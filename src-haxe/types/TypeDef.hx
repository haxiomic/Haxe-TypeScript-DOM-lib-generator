package types;

typedef TypeDef = {
	var name : String;
	@:optional
	var deprecated : Bool;
	@:optional
	var legacyNamespace : String;
	@:optional
	var typeParameters : Array<TypeParameter>;
	var type : ts.AnyOf2<String, Array<Typed>>;
	@:optional
	var subtype : ts.AnyOf2<Typed, Array<Typed>>;
	@:optional
	var nullable : Bool;
	@:optional
	var overrideType : String;
	@:optional
	var additionalTypes : Array<String>;
};