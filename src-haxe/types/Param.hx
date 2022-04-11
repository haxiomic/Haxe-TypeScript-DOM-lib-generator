package types;

typedef Param = {
	var name : String;
	@:optional
	var optional : Bool;
	@:optional
	var variadic : Bool;
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