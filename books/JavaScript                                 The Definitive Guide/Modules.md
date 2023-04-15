- require()-based modules are a fundamental part of the Node programming environment
- Instead, ES6 defines modules using import and export keywords. Although import and export have been part of the language for years, they were only implemented by web browsers and Node relatively recently
- The following code, for example, defines a mini statistics module that exports mean() and stddev() functions while leaving the implementation details hidden
```js
const stats = (function()
{
	// Utility functions private to the module
	const sum = (x, y) => x + y;
	const square = x => x * x;
	// A public function that will be exported
	function mean(data) {
		return data.reduce(sum)/data.length;
	}
	// A public function that we will export
	function stddev(data) {
		let m = mean(data);
		return Math.sqrt(
		data.map(x => x - m).map(square).reduce(sum)/(data.length-1));
	}
	// We export the public function as properties of an object
	return { mean, stddev };
}());
```

- Imagine a tool that takes a set of files, wraps the content of each of those files within an immediately invoked function expression, keeps track of the return value of each
- function, and concatenates everything into one big file. The result might look something like this.
```js
const modules = {};
function require(moduleName) { return modules[moduleName]; }


modules["sets.js"] = (function() {
	const exports = {};
	exports.BitSet = class BitSet { ... };
	return exports;
}());

modules["stats.js"] = (function() {
	const exports = {};
	const sum = (x, y) => x + y;
	const square = x = > x * x;
	exports.mean = function(data) { ... };
	exports.stddev = function(data) { ... };
	return exports;
}());

const stats = require("stats.js");
const BitSet = require("sets.js").BitSet;

//This code is a rough sketch of how code-bundling tools (such as webpack and Parcel) for web browsers work, and it’s also a simple introduction to the require() function like the one used in Node programs
```

- Node modules import other modules with the require() function and export their public API by setting properties of the Exports object

## Modules in Node

```js
let a = 20
let b = 80
exports.a = a
exports.b = b
```

```js
let a = 20
let b = 55
module.exports = {a, b}
```

- If you want to import a system module built in to Node or a module that you have installed on your system via a package manager, then you simply use the unqualified name of the module, without any “/” characters that would turn it into a filesystem path
- When you want to import a module of your own code, the module name should be the path to the file that contains that code, relative to the current module’s file. It is legal to use absolute paths that begin with a / character, but typically, when importing modules that are part of your own program, the module names will begin with ./ or sometimes ../ to indicate that they are relative to the current directory or the parent directory
```js
const m = require('./test.js') //path of the file
const q = require('fs') //node module
```

- (You can also omit the .js suffix on the files you’re importing and Node will still find the files, but it is common to see these file extensions explicitly included.)
- When a module exports just a single function or class, all you have to do is require it. When a module exports an object with multiple properties, you have a choice: you can import the entire object, or just import the specific properties (using destructuring assignment) of the object that you plan to use.
```js
const m = require('./test.js') //path of the file

m.a //20

const {a} = require('./test')

```

## Modules in ES6

#### import

- ES6 adds import and export keywords to JavaScript and finally supports real modularity as a core language feature. ES6 modularity is conceptually the same as Node modularity: each file is its own module, and constants, variables, functions, and classes defined within a file are private to that module unless they are explicitly exported. Values that are exported from one module are available for use in modules that explicitly import them. ES6 modules differ from Node modules in the syntax used for exporting and importing and also in the way that modules are defined in web browsers.
- Code inside an ES6 module is automatically in strict mode. slightly stricter than strict mode: in strict mode, in functions invoked as functions, this is undefined. In modules, this is undefined even in toplevel code.
- Node 13 supports ES6 modules, but for now, the vast majority of Node programs still use Node modules.
```js
//ES6 modules

//To export a constant, variable, function, or class from an ES6 module, simply add the keyword export before the declaration

export const PI = Math.PI;
export function degreesToRadians(d) { return d * PI / 180; }
export class Circle {
	constructor(r) { this.r = r; }
	area() { return PI * this.r * this.r;
	}
}

//alternative

export { Circle, degreesToRadians, PI };
```

- It is common to write modules that export only one value (typically a function or class), and in this case, we usually use export default instead of export: 
```js
export default class BitSet { // implementation omitted 
}
```

- Default exports are slightly easier to import than non-default exports, so when there is only one exported value, using export default makes things easier for the modules that use your exported value.
- Regular exports with export can only be done on declarations that have a name. Default exports with export default can export any expression including anonymous function expressions and anonymous class expressions. This means that if you use export default, you can export object literals. So unlike the export syntax, if you see curly braces after export default, it really is an object literal that is being exported.
- Finally, note that the export keyword can only appear at the top level of your JavaScript code. You may not export a value from within a class, function, loop, or conditional. (This is an important feature of the ES6 module system and enables static analysis: a modules export will be the same on every run, and the symbols exported can be determined before the module is actually run.)
#### import

```js
import BitSet from './bitset.js';
```

- The identifier to which the imported value is assigned is a `constant`, as if it had been declared with the const keyword. Like exports, imports can only appear at the top level of a module and are not allowed within classes, functions, loops, or conditionals.
- imports are “hoisted” to the top, and all imported values are available for any of the module’s code runs.

```js
import { mean, stddev } from "./stats.js";
```

- The curly braces make this kind of import statement look something like a destructuring assignment, and destructuring assignment is actually a good analogy for what this style of import is doing. The identifiers within curly braces are all hoisted to the top of the importing module and behave like constants.
- import everything with an import statement like this:
```js
import * as stats from "./stats.js";
```
- Modules typically define either one default export or multiple named exports. It is legal, but somewhat uncommon, for a module to use both export and export default. But when a module does that, you can import both the default value and the named values with an import statement like this
```js
import Histogram, { mean, stddev } from "./histogram-stats.js";
import { default as Histogram, mean, stddev } from "./histogram-stats.js";
```

```js

// But if a module runs some code, then it can be useful to import even without symbols
import "./analytics.js";
```

```js

//as key renaming
import { render as renderImage } from "./imageutils.js";
import { render as renderUI } from "./ui.js";

export {
	layout as calculateLayout, render as renderLayout
};
```

```js
// Keep in mind that, although the curly braces look something like object literals, they are not, and the export keyword expects a single identifier before the as, not an expression. This means, unfortunately, that you cannot use export renaming like this:

export { Math.sin as sin, Math.cos as cos }; // SyntaxError
```

#### Re-Exports

```js
// Given that the implementations are now in separate files
// defining this “./stat.js” module is simple:

import { mean } from "./stats/mean.js";
import { stddev } from "./stats/stddev.js";
export { mean, stdev };


//Instead of importing a symbol simply to export it again, you can combine the import and the export steps into a single “re-export”

export { mean } from "./stats/mean.js";
export { stddev } from "./stats/stddev.js";


//Note that the names mean and stddev are not actually used in this code. If we are not being selective with a re-export and simply want to export all of the named values from another module

export * from "./stats/mean.js";
export * from "./stats/stddev.js";

//Re-export syntax allows renaming with as just as regular import and export
export { mean, mean as average } from "./stats/mean.js";
export { stddev } from "./stats/stddev.js";


//if the module uses export default
export { default as mean } from "./stats/mean.js";
export { default as stddev } from "./stats/stddev.js";

//If you want to re-export a named symbol from another module as the default export
export { mean as default } from "./stats.js"


//to re-export the default export of another module as the default export
export { default } from "./stats/mean.js"

```

## JavaScript Modules on the Web

```js
* If you want to natively use import directives in a web browser, you must tell the web browser that your code is a module by using a <script type="module"> tag.

* tell nodejs that your code is module by adding "type": "module" in package.json

* you can use tools like Babel and webpack to transform your code into non-modular ES5 code, then load that less-efficient transformed code via <script nomodule>.

* Some programmers like to use the filename extension .mjs to distinguish their modular JavaScript files from their regular, non-modular JavaScript files with the traditional .js extension. For the purposes of web browsers and <script> tags, the file extension is actually irrelevant. (The MIME type is relevant, however, so if you use .mjs files, you may need to configure your web server to serve them with the same MIME type as .js files.) Node’s support for ES6 does use the filename extension as a hint to distinguish which module system is used by each file it loads. So if you are writing ES6 modules and want them to be usable with Node, then it may be helpful to adopt the .mjs naming convention.
```

#### Dynamic Imports with import()

- Although dynamic loading has been possible for a long time, it has not been part of the language itself. That changes with the introduction of import() in ES2020 (as of early 2020, dynamic import is supported by all browsers that support ES6 modules). You pass a module specifier to import() and it returns a Promise object that represents the asynchronous process of loading and running the specified module. When the dynamic import is complete, the Promise is “fulfilled” (see Chapter 13 for complete details on asynchronous programming and Promises) and produces an object like the one you would get with the import * as form of the static import statement.
```js
import * as stats from "./stats.js";

--

import("./stats.js").then(stats => {
	let average = stats.mean(data);
})

//or

async analyzeData(data) {
	let stats = await import("./stats.js");
	return {
		average: stats.mean(data),
		stddev: stats.stddev(data)
	};
}
```

- The argument to import() should be a module specifier, exactly like one you’d use with a static import directive. But with import(), you are not constrained to use a constant string literal: any expression that evaluates to a string in the proper form will do.
- Dynamic import() looks like a function invocation, but it actually is not. Instead, import() is an operator and the parentheses are a required part of the operator syntax. The reason for this unusual bit of syntax is that import() needs to be able to resolve module specifiers as URLs relative to the currently running module, and this requires a bit of implementation magic that would not be legal to put in a JavaScript function. The function versus operator distinction rarely makes a difference in practice, but you’ll notice it if you try writing code like console.log(import); or let require = import;

#### import.meta.url

- the special syntax import.meta refers to an object that contains metadata about the currently executing module. The url property of this object is the URL from which the module was loaded. (In Node, this will be a file:// URL.)
```js
console.log(import.meta)
console.log(import.meta.url) //"http://10.12.6.8:8080/test.js"
```