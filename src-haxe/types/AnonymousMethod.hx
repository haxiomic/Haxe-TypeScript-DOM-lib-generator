package types;

typedef AnonymousMethod = {
	@:optional
	var tags : String;
	@:optional
	@:native("static")
	var static_ : Bool;
	@:optional
	var getter : Bool;
	@:optional
	var stringifier : Bool;
	@:optional
	var comment : String;
	@:optional
	var overrideSignatures : Array<String>;
	@:optional
	var additionalSignatures : Array<String>;
	@:optional
	var specs : String;
	@:optional
	var exposed : String;
	@:optional
	var deprecated : Bool;
	var signature : Array<Signature>;
	@:optional
	var secureContext : Bool;
};