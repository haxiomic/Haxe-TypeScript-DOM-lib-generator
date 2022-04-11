/**
 * This macro exists as a work around to enable supporting @:native() on anonymous structure fields
 * 
 * It wraps the anon in an abstract and uses getters and setters to access the native field
 * 
 * See https://github.com/HaxeFoundation/haxe/issues/5105
 **/

#if !macro

@:genericBuild(AbstractAnon.build())
class AbstractAnon<T> {}

#else

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

class AbstractAnon {

	static function build() {
		var localType = Context.getLocalType();
		var targetType = switch localType {
			case TInst(_, [tp]): tp;
			default: Context.error("Expected TInst", Context.currentPos());
		}

		return patchType(targetType);
	}

	// we use a local lookup so we can break cycles in case of recursion
	@:persistent static var definedTypes = new Map<String, Bool>();

	static function patchType(targetTypeRaw: Type) {
		var targetType = unwrapNull(targetTypeRaw); // not null
		var isNullable = targetType != targetTypeRaw;

		var anon = switch targetType {
			case _ => Context.follow(_) => TAnonymous(anon): anon.get();
			default: Context.error("Type parameter must be a structure", Context.currentPos());
		}

		if (hasNativeFields(anon)) {
			var expectedName = generateName(targetType);

			var underlyingGenericParams: Array<ComplexType> = switch targetType {
				case TType(t, params):
					params.map(Context.toComplexType);
				case TAnonymous(anon):
					var params = [];
					for (field in anon.get().fields) {
						switch field.type {
							case TInst( _.get() => {kind: KTypeParameter(constraints)}, _):
								params.push(Context.toComplexType(field.type));
							default:
						}
					}
					params;
				default: [];
			}

			if (
				!definedTypes.exists(expectedName) &&
				(try Context.getType(expectedName) catch(e: Any) null) == null
			) {
				definedTypes.set(expectedName, true);
				generateAbstract(targetType, expectedName, underlyingGenericParams);
			}

			var localClass = Context.getLocalClass().get();
			var ref: ComplexType = TPath({
				pack: [],
				name: expectedName,
				params: underlyingGenericParams.map(p -> TPType(p)),
			});

			if (isNullable) {
				ref = macro : Null<$ref>;
			}

			return ref;
		} else {
			return Context.toComplexType(targetType);
		}
	}

	static function hasNativeFields(anon: AnonType) {
		for (field in anon.fields) {
			if (field.meta.has(':native')) {
				return true;
			}
			// check if field's type is anon with native fields
			var isAnonWithNative = switch Context.follow(field.type) {
				case TAnonymous(nestedAnon): hasNativeFields(nestedAnon.get());
				default: false;
			}
			if (isAnonWithNative) {
				return true;
			}
		}
		return false;
	}

	@:persistent
	static var idCounter = 0;

	static function generateName(type: Type) {
		var localName = Context.getLocalClass().get().name;
		return switch unwrapNull(type) {
			case TType(t, params):
				var t = t.get();
				'${localName}_${t.pack.concat([t.name]).join('_')}';
				// Context.getLocalClass().get().name + (idCounter++);
			case TAnonymous(anon):
				'${localName}_${idCounter++}';

			case default_: Context.error('Unhandled type $default_', Context.currentPos());
		}
	}

	static function generateAbstract(type: Type, generatedName: String, typeParameters: Array<ComplexType>) {
		var pos = Context.currentPos();
		var localClass = Context.getLocalClass().get();

		var underlyingTypeReference = Context.toComplexType(type);

		// replace type parameter references
		var underlyingTypeReference = switch underlyingTypeReference {
			case TPath(p): TPath({
				pack: p.pack,
				name: p.name,
				sub: p.sub,
				params: typeParameters.map(p -> TPType(p)),
			});
			case other: other; 
		}

		var typeDefinition: TypeDefinition = {
			name: generatedName,
			pack: [],
			kind: TDAbstract(underlyingTypeReference, [underlyingTypeReference], []),
			// add generic type parameters to match underlying type
			params: [for (p in typeParameters) {
				name: switch p {
					case TPath(p): p.name;
					default: Context.error("Expected TPath", pos);
				},
			}],
			fields: [],
			meta: [
				{name: ':forward', pos: pos},
				{name: ':transitive', pos: pos},
			],
			doc: "Auto-generated abstract over structure that enables @:native fields to work",
			pos: pos,
		};

		// generate getters and setters for @:native fields
		var anon = switch Context.follow(type) {
			case TAnonymous(anon): anon.get();
			default: Context.error("Type parameter must be a structure", pos);
		}

		for (field in anon.fields) {
			var fieldType = Context.toComplexType(field.type);
			
			// recursive type replace
			// if the field type is also an anon with :native fields, we should wrap
			var requiresOverwrite = field.meta.has(':native');
			switch Context.follow(field.type) {
				case TAnonymous(subAnon):
					if (hasNativeFields(subAnon.get())) {
						fieldType = patchType(field.type);
						requiresOverwrite = true;
					}
				default:
			}

			if (requiresOverwrite) {
				var name = field.name;
				var get_name = 'get_${name}';
				var set_name = 'set_${name}';

				var nativeMeta = field.meta.extract(':native')[0];
				var nativeName = switch nativeMeta {
					case null: name;
					case {params: params}: switch params[0] {
						case {expr: EConst(CString(s, kind))}: s;
						default: name;
					}
				}

				var newFields = (macro class X {
					public var $name(get, set): $fieldType;
					inline function $get_name(): $fieldType {
						return Reflect.field(this, $v{nativeName});
					}
					inline function $set_name(v: $fieldType) {
						Reflect.setField(this, $v{nativeName}, v);
						return v;
					}
				}).fields;

				typeDefinition.fields = typeDefinition.fields.concat(newFields);
			}
		}

		#if test
		// trace(new haxe.macro.Printer().printTypeDefinition(typeDefinition));
		#end

		Context.defineType(typeDefinition);
	}

	static function unwrapNull(type: Type) {
		return switch type {
			case TAbstract(_.get() => x = {name: 'Null', pack: [], module: 'StdTypes'}, [t]):
				t;
			default:
				type;
		}
	}

}

#end

// test
#if (!macro && test)
typedef Example<T, Q> = {
	@:native("example")
	var field: T;

	@:optional
	var nested: {
		@:native("example")
		var field: Q;
	}

	@:optional
	var enums: {
		@:native("enum")
		var enum_: haxe.DynamicAccess<Int>;
	};

	@:optional
	@:native('nested-native')
	var nestedNative: {
		@:native("example")
		var field: Q;
	}

	var normalFieldI: Int;
	var normalFieldS: String;
	@:optional
	var normalField2: {a: Float};

	@:native('recursive')
	var recursive: Example<T, Q>;
}

typedef FixedExample<T, Q> = AbstractAnon<Example<T, Q>>;

function test() {
	var x = {
		example: 42,
		nested: {
			example: "forty-two"
		},
		enums: {
			"enum": { a: 4 },
		},
		"nested-native": {
			{
				example: "yey"
			}
		},
	}

	var z: AbstractAnon<Example<Int, String>> = cast x;


	trace(z.field);
	trace(z.nested);
	trace(z.nested.field);

	trace(z.nestedNative);
	trace(z.nestedNative != null ? z.nestedNative.field : null);

	trace(z.enums);
	trace(z.enums.enum_);
	trace(z.enums.enum_.get('a'));
}
#end