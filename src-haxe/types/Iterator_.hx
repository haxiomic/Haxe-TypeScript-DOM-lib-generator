package types;

typedef Iterator_ = {
	var kind : String;
	var readonly : Bool;
	var type : Array<Typed>;
	@:optional
	var comments : {
		var comment : haxe.DynamicAccess<String>;
	};
};