package types;

typedef Member = {
	var name : String;
	@:optional
	@:native("default")
	var default_ : String;
	@:optional
	var required : Bool;
	@:optional
	var specs : String;
	@:optional
	var comment : String;
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