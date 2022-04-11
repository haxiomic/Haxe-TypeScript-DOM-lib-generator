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
	trace(webidl);
}

@:native("import")
extern function dynamicImport(path: String): js.lib.Promise<Dynamic>;