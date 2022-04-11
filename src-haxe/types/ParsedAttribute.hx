package types;

typedef ParsedAttribute = {
	@:optional
	@:native("enum-values")
	var enum_values : String;
	var name : String;
	@:optional
	@:native("value-syntax")
	var value_syntax : String;
};