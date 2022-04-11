package types;

typedef NamedConstructor = {
	var name : String;
	var signature : Array<Signature>;
	@:optional
	var specs : String;
};