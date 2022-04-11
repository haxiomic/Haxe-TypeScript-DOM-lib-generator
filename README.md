# Haxe Externs Fork of TypeScript DOM generator

**Project does not yet work, just breaking ground!**

TypeScript's DOM lib generator is a benchmark quality browser API type definitions.
This project seeks to extend this generator to emit haxe externs. It tries to make as minimal changes as possible to the source project so that merging in upstream changes has minimal overhead.

```bash
npm install

# compile ts code so we can use it from haxe 
npm run build 

# compile and run haxe generator
npm run haxe-run
```

## List of changes made
**src/build.ts**
- export `emitDom()`
- modify `emitDom()` to return `Promise<WebIdl>`, rather than generating .d.ts files

**package.json**
Added 2 new scripts:
- `haxe-run`, which compiles the project and runs the haxe generator
- `haxe-dev-externs`, which uses [dts2hx](https://github.com/haxiomic/dts2hx) to generate externs for the [`WebIdl`](src/build/types.d.ts#L234) structure defined in [types.d.ts](src/build/types.d.ts)
- added dts2hx as a dev dependency

----

# TypeScript and JavaScript lib generator

This tool is used to generate the web-based `lib.dom.d.ts` file which is included with TypeScript releases, and as the `@types/web` package.

## Why is my fancy API still not available here?

A feature needs to be supported by two or more major browser engines to be included here, to make sure there is a good consensus among vendors: __Gecko__ (Firefox), __Blink__ (Chrome/Edge), and __WebKit__ (Safari).

If the condition is met but still is not available here, first check the [contribution guidelines](#contribution-guidelines) below and then please [file an issue](hthttps://github.com/microsoft/TypeScript-DOM-lib-generator/issues/new).

## Build Instructions

To get things setup:

```sh
npm install
```

To generate the `.d.ts` files

```sh
npm run build
```

To test:

```sh
npm run test
```


## `@types/[lib]` to TypeScript Versions

| `@types/[lib]` version | TypeScript Version  | Minimum TypeScript Support |
| ------------------------------------------------------------------------- | ----------- | -------------- |
| `@types/web` [0.0.1](https://www.npmjs.com/package/@types/web/v/0.0.1)    | ~4.3        | 4.4            |
| `@types/web` [0.0.2](https://www.npmjs.com/package/@types/web/v/0.0.2)    | ~4.4 beta   | 4.4            |
| `@types/web` [0.0.25](https://www.npmjs.com/package/@types/web/v/0.0.25)  | 4.4         | 4.4            |
| `@types/web` [0.0.28](https://www.npmjs.com/package/@types/web/v/0.0.28)  | 4.5 beta    | 4.4            |
| `@types/web` [0.0.37](https://www.npmjs.com/package/@types/web/v/0.0.37)  | 4.5 rc      | 4.4            |

## `@types/[lib]` Minimum Target

The libraries available on `@types/` like `@types/web` require a [`"target"`](https://www.typescriptlang.org/tsconfig#target) of ES6 or above, because [iterator](https://www.typescriptlang.org/docs/handbook/iterators-and-generators.html) APIs are included.

## Contribution Guidelines

The files in the `baselines/` directory from the TypeScript repo are used as baselines.
For each pull request, we will run the script and compare the generated files with the baseline files.
In order to make the tests pass, please update the baseline as well in any pull requests.

### When the type is missing

It's possible that the automated algorithm decided that it's not well supported by browsers and thus removed it. Say we want to add a new interface named `Foo`. Check if there is a document about that interface in [MDN](https://developer.mozilla.org/). If there is, see the browser compatibility section and check whether it's supported by two or more browser engines. (Note that Chromium-based browsers use the same browser engine and thus support from them counts as a single support.)

If all the conditions are fulfilled, it could be that the type is incorrectly removed by `inputfiles/removedTypes.jsonc`. Try finding and removing the relevant item there and run `npm run build && npm run baseline-accept`.

If conditions are not fulfilled but you think MDN is wrong, please file an issue at https://github.com/mdn/browser-compat-data/issues/. The type will be automatically added in a few weeks when MDN fixes their data.

### When the type exists but is wrong

It's possible that the type is too specific or too general. First you need to check whether `inputfiles/overridingTypes.jsonc` or `inputfiles/addedTypes.jsonc` have a relevant item, which can be fixed if exists. If they don't, add one in `overridingTypes.jsonc`. Run `npm run build && npm run baseline-accept` to make sure the resulting changes are what you want.

If you are familiar with Web IDL, you may also want to check whether the upstream IDL itself can be made more specific. Doing so will reduce the need for manual overrides in this repository and thus can be more helpful.

# This repo

## Code Structure

- `src/build.ts`: handles the emitting of the `.d.ts` files.
- `src/test.ts`: verifies the output by comparing the `generated/` and `baseline/` contents.

## Input Files

- `mdn/apiDescriptions.json`: a JSON file generated by fetching API descriptions from [MDN](https://developer.mozilla.org/en-US/docs/Web/API). **Do not edit this file**.
- `addedTypes.jsonc`: types that should exist but are missing from the spec data.
- `overridingTypes.jsonc`: types that are defined in the spec but have TypeScript-friendly modifications in the json files.
- `removedTypes.jsonc`: types that are defined in the spec but should be removed.
- `comments.json`: comment strings to be embedded in the generated .js files.
- `deprecatedMessage.json`: the reason why one type is deprecated. The reason why it is a separate file rather than merge in comment.json is mdn/apiDescriptions.json would also possibly be deprecated.

## Deployment to TypeScript

To migrate the *.d.ts files into TypeScript:

1. [Trigger the workflow here](https://github.com/microsoft/TypeScript-DOM-lib-generator/actions/workflows/pr-to-typescript.yml) - this will send a PR to TypeScript under your alias.


1. Update the README table with the mappings for versions in the `@types/[lib]`. E.g. TS 4.5 -> `@types/web` `0.0.23`. Find that number here: https://www.npmjs.com/package/@types/web

1. Generate a CHANGELOG for the releases:

    ```sh
    #                       lib        from  to
    npm run ts-changelog -- @types/web 0.0.2 0.0.23
    ```

    You might need to run `git pull origin main --tags` to run this ^

1. Add the CHANGELOG to the release issue
