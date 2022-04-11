package types;

typedef Event = {
	var name : String;
	var type : String;
	@:optional
	var dispatch : String;
	@:optional
	@:native("skips-window")
	var skips_window : String;
	@:optional
	var bubbles : Int;
	@:optional
	var cancelable : Int;
	@:optional
	var follows : String;
	@:optional
	var precedes : String;
	@:optional
	var tags : String;
	@:optional
	var aliases : String;
	@:optional
	var specs : String;
};