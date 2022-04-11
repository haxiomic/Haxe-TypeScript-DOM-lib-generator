/**
 * Haxe DOM extern generator
 * 
 * using haxe 4.2.4
 **/

import types.WebIdl;

function main() {
	trace("Haxe DOM extern generator");

	dynamicImport("./build.js")
		.then(module -> module.emitDom())
		.then(webidl -> generateDomExterns(webidl));
}

function generateDomExterns(webidl: WebIdl) {
	var webidl: AbstractAnon<WebIdl> = webidl;

	for (e in webidl.enums.enum_) {
		Console.examine('Enum', e.name, e.value);
	}
}

@:native("import")
extern function dynamicImport(path: String): js.lib.Promise<Dynamic>;