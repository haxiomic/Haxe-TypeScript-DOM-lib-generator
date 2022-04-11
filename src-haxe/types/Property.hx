package types;

typedef Property = {
	var name : String;
	@:optional
	var eventHandler : String;
	@:optional
	var readonly : Bool;
	@:optional
	var replaceable : String;
	@:optional
	var putForwards : String;
	@:optional
	var stringifier : Bool;
	@:optional
	var tags : String;
	@:optional
	@:native("property-descriptor-not-enumerable")
	var property_descriptor_not_enumerable : String;
	@:optional
	@:native("content-attribute")
	var content_attribute : String;
	@:optional
	@:native("content-attribute-reflects")
	var content_attribute_reflects : String;
	@:optional
	@:native("content-attribute-value-syntax")
	var content_attribute_value_syntax : String;
	@:optional
	@:native("content-attribute-enum-values")
	var content_attribute_enum_values : String;
	@:optional
	@:native("content-attribute-aliases")
	var content_attribute_aliases : String;
	@:optional
	@:native("content-attribute-boolean")
	var content_attribute_boolean : String;
	@:optional
	@:native("css-property")
	var css_property : String;
	@:optional
	@:native("css-property-enum-values")
	var css_property_enum_values : String;
	@:optional
	@:native("css-property-initial")
	var css_property_initial : String;
	@:optional
	@:native("css-property-value-syntax")
	var css_property_value_syntax : String;
	@:optional
	@:native("css-property-shorthand")
	var css_property_shorthand : String;
	@:optional
	@:native("css-property-subproperties")
	var css_property_subproperties : String;
	@:optional
	@:native("css-property-animatable")
	var css_property_animatable : String;
	@:optional
	@:native("css-property-aliases")
	var css_property_aliases : String;
	@:optional
	@:native("lenient-this")
	var lenient_this : String;
	@:optional
	@:native("treat-null-as")
	var treat_null_as : String;
	@:optional
	@:native("event-handler-map-to-window")
	var event_handler_map_to_window : String;
	@:optional
	@:native("static")
	var static_ : Bool;
	@:optional
	var comment : String;
	@:optional
	var optional : Bool;
	@:optional
	var specs : String;
	@:optional
	var deprecated : Bool;
	@:optional
	var exposed : String;
	@:optional
	var secureContext : Bool;
	var type : ts.AnyOf2<String, Array<Typed>>;
	@:optional
	var subtype : ts.AnyOf2<Typed, Array<Typed>>;
	@:optional
	var nullable : Bool;
	@:optional
	var overrideType : String;
	@:optional
	var additionalTypes : Array<String>;
};