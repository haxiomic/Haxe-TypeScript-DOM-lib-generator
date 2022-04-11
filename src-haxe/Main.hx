/**
 * Haxe DOM extern generator
 * 
 * using haxe 4.2.4
 **/

import haxe.DynamicAccess;
import types.WebIdl;

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
}

@:native("import")
extern function dynamicImport(path: String): js.lib.Promise<Dynamic>;