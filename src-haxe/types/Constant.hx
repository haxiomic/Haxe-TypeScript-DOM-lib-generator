package types;

typedef Constant = {
	var name : String;
	var value : String;
	@:optional
	var tags : String;
	@:optional
	var exposed : String;
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