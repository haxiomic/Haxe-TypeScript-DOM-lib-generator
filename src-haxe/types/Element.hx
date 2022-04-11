package types;

typedef Element = {
	var name : String;
	@:optional
	var namespace : String;
	@:optional
	var deprecated : Bool;
	@:optional
	var specs : String;
};