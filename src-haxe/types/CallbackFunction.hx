package types;

typedef CallbackFunction = {
	var name : String;
	var signature : Array<Signature>;
	@:optional
	var tags : String;
	@:optional
	var overrideSignatures : Array<String>;
	@:optional
	var specs : String;
	@:optional
	var typeParameters : Array<TypeParameter>;
};