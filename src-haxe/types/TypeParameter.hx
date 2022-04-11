package types;

typedef TypeParameter = {
	var name : String;
	@:optional
	@:native("extends")
	var extends_ : String;
	@:optional
	@:native("default")
	var default_ : String;
};