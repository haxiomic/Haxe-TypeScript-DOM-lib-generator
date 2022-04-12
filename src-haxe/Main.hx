/**
 * Haxe DOM extern generator
 * 
 * using haxe 4.2.4
 **/

import haxe.macro.Expr.TypePath;
import haxe.io.Path;
import haxe.DynamicAccess;
import haxe.macro.Expr.TypeDefinition;
import tool.HaxeTools;
import types.Enum_;
import types.WebIdl;

final jsDomPack = ['js', 'dom'];
final outputDir = 'haxe-generated';

function main() {
	trace("Haxe DOM extern generator");

	dynamicImport("./build.js")
		.then(module -> module.emitDom())
		.then(webidl -> generateDomExterns(webidl));
}

function generateDomExterns(webidl: WebIdl) {
	var webidl: AbstractAnon<WebIdl> = webidl;

	function preview(it:DynamicAccess<Any>) {
		var limit = 2;
		var i = 0;
		for (key => x in it) {
			var str = Std.string(x);
			if (str.length > 100) {
				str = str.substr(0, 100) + '...';
			}
			Console.printlnFormatted('\t<b>$key</b>: $str');
			if (++i > limit) break;
		}
	}

	Console.log('<b,cyan>enums</b> (${webidl.enums.enum_.keys().length})');
	preview(webidl.enums.enum_);

	Console.log('<b,green>callbackFunctions</b> (${webidl.callbackFunctions.callbackFunction.keys().length})');
	preview(webidl.callbackFunctions.callbackFunction);

	Console.log('<b,magenta>callbackInterfaces</b> (${webidl.callbackInterfaces.interface_.keys().length})');
	preview(webidl.callbackInterfaces.interface_);

	Console.log('<b,red>dictionaries</b> (${webidl.dictionaries.dictionary.keys().length})');
	preview(webidl.dictionaries.dictionary);

	Console.log('<b,blue>interfaces</b> (${webidl.interfaces.interface_.keys().length})');
	preview(webidl.interfaces.interface_);

	Console.log('<b,#FF337D>mixins</b> (${webidl.mixins.mixin.keys().length})');
	preview(webidl.mixins.mixin);

	Console.log('<b,#FFA500>namespaces</b> (${webidl.namespaces.length})');
	preview(cast webidl.namespaces);

	Console.log('<b,#33FF64>typedefs</b> (${webidl.typedefs.typedef_.length})');
	preview(cast webidl.typedefs.typedef_);

	var hxTypes = new Array<TypeDefinition>();
	for (e in webidl.enums.enum_) {
		hxTypes.push(generateEnum(e));
	}

	writeFiles(hxTypes);

	Console.log('<light_green>Saved files to <b>${outputDir}/</></light_green>');
}

function generateTypePath(def: {name: String}): TypePath {
	return {
		name: def.name,
		pack: jsDomPack,
	}
}

function generateEnum(e: Enum_) {
	function enumFieldName(value: String) {
		return if (value == "") {
			"NONE";
		} else {
			HaxeTools.toSafeIdent(value).toUpperCase();
		}
	}

	var typePath = generateTypePath(e);

	var hxType: TypeDefinition = {
		name: typePath.name,
		pack: typePath.pack,
		kind: TDAbstract(macro :String),
		fields: [for (value in e.value) {
			name: enumFieldName(value),
			kind: FVar(null, {expr: EConst(CString(value)), pos: null}),
			pos: null,
		}],
		meta: [{name: ":enum", pos: null}],
		pos: null,
	};

	return hxType;
}

function writeFiles(hxTypes: Array<TypeDefinition>) {
	var printer = new Printer();
	dynamicImport("fs").then(fs -> {
		for (hxType in hxTypes) {
			var path = Path.join([outputDir].concat(hxType.pack.concat([hxType.name + '.hx'])));
			var dir = Path.directory(path);
			fs.mkdirSync(dir, { recursive: true });

			var str = printer.printTypeDefinition(hxType);
			fs.writeFileSync(path, str);
		}
	});
}

@:native("import")
extern function dynamicImport(path: String): js.lib.Promise<Dynamic>;