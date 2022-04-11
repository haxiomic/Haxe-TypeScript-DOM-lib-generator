package types;

typedef Constructor = {
	var signature : Array<Signature>;
	@:optional
	var comment : String;
	@:optional
	var specs : String;
};