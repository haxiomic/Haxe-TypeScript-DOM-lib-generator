package types;

typedef Dictionary = {
	var name : String;
	@:optional
	@:native("extends")
	var extends_ : String;
	var members : {
		var member : haxe.DynamicAccess<Member>;
	};
	@:optional
	var overrideIndexSignatures : Array<String>;
	@:optional
	var specs : String;
	@:optional
	var typeParameters : Array<TypeParameter>;
	@:optional
	var legacyNamespace : String;
};