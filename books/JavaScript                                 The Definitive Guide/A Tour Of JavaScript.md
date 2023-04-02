
 [[notes]]
 [[Unicode]]
 [[Optional Semicolons]]
 [[JavaScript types]]
 [[Conversions]]
 [[Operators]]

## Tour Of JavaScript

```js
let x; // Declare a variable named x.
x = 0; // Now the variable x has the value 0  
x // => 0: A variable evaluates to its value.

// JavaScript supports several types of values

x=1;  // Numbers.
x = 0.01;  //Numbers can be integers or reals.
x = "hello world"; // Strings of text in quotation marks.
x = 'JavaScript'; // Single quote marks also delimit strings.
x = true;  // A Boolean value.
x = false;  // The other Boolean value.
x = null;  // Null is a special value that means "no value."
x = undefined; // Undefined is another special value like null.

let book = {               // Objects are enclosed in curly braces.
    topic: "JavaScript",   // The property "topic" has value "JavaScript."
    edition: 7             // The property "edition" has value 7
};                         // The curly brace marks the end of the object.

// Access the properties of an object with . or []:
book.topic                 // => "JavaScript"
book["edition"]            // => 7: another way to access property values.
book.author = "Flanagan";  // Create new properties by assignment.
book.contents = {};        // {} is an empty object with no properties.”

// Conditionally access properties with ?. (ES2020):
book.contents?.ch01?.sect1 // => undefined: book.contents has no ch01 property.

// JavaScript also supports arrays (numerically indexed lists) of values:
let primes = [2, 3, 5, 7]; // An array of 4 values, delimited with [ and ].

primes[0] // => 2: the first element (index 0) of the array.
primes.length // => 4: how many elements in the array.
primes[primes.length-1] // => 7: the last element of the array.
primes[4] = 9; // Add a new element by assignment.
primes[4] = 11; // Or alter an existing element by assignment. 
primes["1"] // "1" converted to 1
let empty = [];// [] is an empty array with no elements.
empty.length // => 0

// Arrays and objects can hold other arrays and objects:
let points = [ {x: 0, y: 0}, {x:1,y:1} ];
let data = {  
	trial1: [[1,2], [3,4]],
	trial2: [[2,3], [4,5]]
	};

// Template Literals
// string literals can be delimited with backticks
let errorMessage = `\
\u2718 Test failure at ${filename}:${linenumber}:
${exception.message}
Stack trace:
${exception.stack}
`;
`\n`.length // => 1: the string has a single newline character
String.raw`\n`.length // => 2: a backslash character and the letter n
// A powerful but less commonly used feature of template literals is that, if a function name (or “tag”) comes right before the opening backtick, then the text and the values of the expressions within the template literal are passed to the function. like in that last example raw`\n`
```
#conditional_property_access 
```js

//ES2020 Conditional Property Access
expression ?. identifier
expression ?.[ expression ]
?.()
// Consider the expression a?.b. If a is null or undefined, then the expression evaluates to undefined without any attempt to access the property b. If a is some other value, then a?.b evaluates to whatever a.b would evaluate to (and if a does not have a property named b, then the value will again be undefined).

let a = {b: null}
a?.b //undefined becasue b is null
a = null
a?.b //undefined
log?.(x) //if log is not defined the expression will evalute to undefined


```


## Expression

- `An expression` is a phrase of JavaScript that can be evaluated to produce a value.
```js
// Operators act on values (the operands) to produce a new value.
// Arithmetic operators are some of the simplest:
3+2 // => 5: addition
3-2 // => 1: subtraction
3*2 // => 6: multiplication
3/2 // => 1.5: division
"3" + "2" // => "32": + adds numbers, concatenates strings

let count = 0; // Define a variable
count++;
count--;
count += 2;
count *= 3;
count
// unequal, less than, greater than, and so on. They evaluate to true or false.
x<=y // => true: less-than or equal

```

## statements

- An expression is something that computes a value but doesn’t do anything: it doesn’t alter the program state in any way. Statements, on the other hand, don’t have a value, but they do alter the state. The other broad category of statement is control structures, such as conditionals and loops.
```js
// Functions are parameterized blocks of JavaScript code that we can invoke.
function plus1(x) { // Define a function named "plus1" with parameter "x"
	return x + 1;// Return a value one larger than the value passed in
} // Functions are enclosed in curly braces

let square = function(x) { // Functions are values and can be assigned to vars
	return x * x; // Compute the function's value
}; // Semicolon marks the end of the assignment.

// so functions defined this way are known as arrow functions. Arrow functions are most commonly used when you want to pass an unnamed function as an argument to another function.

const plus1 = x => x + 1; // The input x maps to the output x + 1
const square = x => x * x; // The input x maps to the output x * x

// When functions are assigned to the properties of an object, we call
// them "methods."  All JavaScript objects (including arrays) have methods:

let a = []; // Create an empty array
a.push(1,2,3); // The push() method adds elements to an array
a.reverse(); // Another method: reverse the order of elements

let points = [ {x: 0, y: 0}, {x:1,y:1} ];
// We can define our own methods, too. The "this" keyword refers to the object
// on which the method is defined: in this case, the points array from earlier.
points.dist = function() { // Define a method to compute distance between points
	let p1 = this[0];  
	let p2 = this[1];  
	let a = p2.x-p1.x;  
	let b = p2.y-p1.y;  
	return Math.sqrt(a*a + b*b);
};
points.dist()


//Loop over array, assigning each element to x.
function sun(array){
	for(let x of array) {
		sum += x; 
	}
}


// This class extends Map so that the get() method returns the specified
class DefaultMap extends Map {
constructor(defaultValue) {
	super();
		// Invoke superclass constructor
		this.defaultValue = defaultValue; // Remember the default value
	}
	get(key) {
		if (this.has(key)) {// value instead of null when the key is not in the map
			return super.get(key);
		}
		else {
			return this.defaultValue;
		}
	}
}

// Convert the Map to an array of [key,value] arrays
letterCounts = new DefaultMap(0);
let entries = [...this.letterCounts];

```

## Math

```js
x = 0xff
x = 0b10101
x = 0o7854
x = 20
x = 2.33e-10
x = .33e-10
x = .33
x = 1_000_000
x = 0xff_ff
x = 2**68 //ES2016 adds ** for expo‐nentiation
x = 10n //ES2020 BIG Int
x = 0b10n
Infinity
Number.POSITIVE_INFINITY
NaN
Number.NaN

//------

Math.pow(2,53) // => 9007199254740992: 2 to the power 53
Math.round(.6) // => 1.0: round to the nearest integer
Math.ceil(.6) // => 1.0: round up to an integer
Math.floor(.6) // => 0.0: round down to an integer
Math.abs(-5) // => 5: absolute value
Math.max(x,y,z) // Return the largest argument
Math.min(x,y,z) // Return the smallest argument
Math.random() // Pseudo-random number x where 0 <= x < 1.0
Math.PI // π: circumference of a circle / diameter
Math.E // e: The base of the natural logarithm
Math.sqrt(3) // => 3**0.5: the square root of 3
Math.pow(3, 1/3) // => 3**(1/3): the cube root of 3
Math.sin(0) // Trigonometry: also Math.cos, Math.atan, etc.
Math.log(10) // Natural logarithm of 10
Math.log(100)/Math.LN10 // Base 10 logarithm of 100
Math.log(512)/Math.LN2 // Base 2 logarithm of 512
Math.exp(3) // Math.E cubed
//---

Math.cbrt(27) // => 3: cube root
Math.hypot(3, 4) // => 5: square root of sum of squares of all arguments
Math.log10(100) // => 2: Base-10 logarithm
Math.log2(1024) // => 10: Base-2 logarithm
Math.log1p(x) // Natural log of (1+x); accurate for very small x
Math.expm1(x) // Math.exp(x)-1; the inverse of Math.log1p()
Math.sign(x) // -1, 0, or 1 for arguments <, ==, or > 0
Math.imul(2,3) // => 6: optimized multiplication of 32-bit integers
Math.clz32(0xf) // => 28: number of leading zero bits in a 32-bit integer
Math.trunc(3.9) // => 3: convert to an integer by truncating fractional part
Math.fround(x) // Round to nearest 32-bit float number
Math.sinh(x) // Hyperbolic sine. Also Math.cosh(), Math.tanh()
Math.asinh(x) // Hyperbolic arcsine. Also Math.acosh(), Math.atanh()
//---
Number.parseInt() // Same as the global parseInt() function
Number.parseFloat() // Same as the global parseFloat() function
Number.isNaN(x) // Is x the NaN value? or x != x
Number.isFinite(x) // Is x a number and finite?
Number.isInteger(x) // Is x an integer?
Number.isSafeInteger(x) // Is x an integer -(2**53) < x < 2**53?
Number.MIN_SAFE_INTEGER // => -(2**53 - 1)
Number.MAX_SAFE_INTEGER // => 2**53 - 1
Number.EPSILON // => 2**-52: smallest difference between numbers


// Arithmetic in JavaScript does not raise errors in cases of overflow,
// underflow, or division by zero.
// (Overflow) -> Infinity or -Infinity.
// (Underflow) -> 0 or -0
// n / 0 -> Infinity
// 0 / 0 -> NaN
// Infinity / Infinity -> NaN

/*
The not-a-number value has one unusual feature in JavaScript: it does not compare
equal to any other value, including itself. This means that you can’t write x===NaN to determine whether the value of a variable x is NaN. Instead, you must write x != x or Number.isNaN(x).
*/

// JavaScript numbers have plenty of precision and can approximate 0.1 very closely. But the fact that this number cannot be represented exactly can lead to problems. Consider this code

let x = .3 - .2;
let y = .2 - .1;
x === y // => false: the two values are not the same!
x === .1 // => false: .3-.2 is not equal to .1
y === .1  // => true: .2-.1 is equal to .1

//BigInt. ES2020
// BigInt values can have thousands or even millions of digits,
// You can use BigInt() as a function for converting regular JavaScript numbers or strings to BigInt values
BigInt(Number.MAX_SAFE_INTEGER) // => 9007199254740991n
BigInt(string)
// Because BigInt and Regular integer are not generilized each other javascript prevent mixed operation between them.
//Although the standard +, -, *, /, %, and ** operators work with BigInt, it is important to understand that you may not mix operands of type BigInt with regular number operands.

// Comparison operators, by contrast, do work with mixed numeric types

1 < 2n // => true
2 > 1n // => true
0 == 0n // => true
0 === 0n // => false: the === checks for type equality as well
```

## Date

- JavaScript Dates are objects, but they also have a
numeric representation as a timestamp that specifies the number of elapsed milli‐
seconds since January 1, 1970
```js
let timestamp = Date.now(); // The current time as a timestamp (a number).
// 1678377525125

let now = new Date(); // The current time as a Date object.
// Thu Mar 09 2023 16:58:55 GMT+0100 (GMT+01:00)

let ms = now.getTime(); // Convert to a millisecond timestamp.
// 1678377525125

let iso = now.toISOString(); // Convert to a string in standard format.
// '2023-03-09T15:58:55.932Z'

```

## String

- The JavaScript type for representing text is the string. A string is an immutable
ordered sequence of 16-bit values
- Unicode characters whose codepoints do not fit in 16 bits are encoded using the rules of UTF-16 as a sequence (known as a `surrogate pair`) of two 16-bit values. This means that a JavaScript string of length 2 (two 16-bit values) might represent only a single Unicode character
```js
let euro = "€";
let love = "💙";
euro.length // => 1: this character has one 16-bit element
love.length // => 2: UTF-16 encoding of ❤ is "\ud83d\udc99"
```
- Most string-manipulation methods defined by JavaScript operate on 16-bit values,
not characters. They do not treat `surrogate pairs` specially, they perform no normal‐
ization of the string, and don’t even ensure that a string is well-formed UTF-16.
- In ES6, however, strings are iterable, and if you use the `for/of loop` or ... operator
with a string, `it will iterate the actual characters of the string, not the 16-bit values.`
- **single or double quotes or backticks (' or " or \`).**
- String com‐parison is done simply by `comparing the 16-bit values.`
```js

let s = "Hello, world";
s.length //the number of 16-bit values it contains

// Obtaining portions of a string
s.substring(1,4) // => "ell": the 2nd, 3rd, and 4th characters.
s.slice(1,4) // => "ell": same thing
s.slice(-3) // => "rld": last 3 characters
s.split(", ") // => ["Hello", "world"]: split at delimiter string

// Searching a string
s.indexOf("l") // => 2: position of first letter l
s.indexOf("l", 3) // => 3: position of first "l" at or after 3
s.indexOf("zz") // => -1: s does not include the substring "zz"
s.lastIndexOf("l") // => 10: position of last letter l

// Boolean searching functions in ES6 and later
s.startsWith("Hell") // => true: the string starts with these
s.endsWith("!") // => false: s does not end with that
s.includes("or") // => true: s includes substring "or"

// Creating modified versions of a string
s.replace("llo", "ya") // => "Heya, world"
s.toLowerCase() // => "hello, world"
s.toUpperCase() // => "HELLO, WORLD"
s.normalize() // Unicode NFC normalization: ES6
s.normalize("NFD") // NFD normalization. Also "NFKC", "NFKD"

// Inspecting individual (16-bit) characters of a string
s.charAt(0) // => "H": the first character
s.charAt(s.length-1) // => "d": the last character
s.charCodeAt(0) // => 72: 16-bit number at the specified position
s.codePointAt(0) // => 72: ES6, works for codepoints > 16 bits

// String padding functions in ES2017
"x".padStart(3) // => " x": add spaces on the left to a length of 3
"x".padEnd(3) // => "x ": add spaces on the right to a length of 3
"x".padStart(3, "*") // => "**x": add stars on the left to a length of 3
"x".padEnd(3, "-") // => "x--": add dashes on the right to a length of 3

// Space trimming functions. trim() is ES5; others ES2019
" test ".trim() // => "test": remove spaces at start and end
" test ".trimStart() // => "test ": remove spaces on left. Also trimLeft
" test ".trimEnd() // => " test": remove spaces at right. Also trimRight

// Miscellaneous string methods
s.concat("!") // => "Hello, world!": just use + operator instead
"<>".repeat(5) // => "<><><><><>": concatenate n copies. ES6

let s = "hello, world";
s[0] // => "h"
```
- Remember that strings are immutable in JavaScript. Methods like replace() and
toUpperCase() return new strings: they do not modify the string on which they are
invoked.

## Array

```js
let c = Array.from(b); //create a copy of array b
```

## RegExp

Text between a pair of slashes constitutes a regular expression literal. The second
slash in the pair can also be followed by one or more letters, which modify the mean‐
ing of the pattern. `/[chars]/[chars]`
```js
/^HTML/; // Match the letters H T M L at the start of a string
/[1-9][0-9]*/; // Match a nonzero digit, followed by any # of digits
/\bjavascript\b/i; // Match "javascript" as a word, case-insensitive

let text = "testing: 1, 2, 3"; // Sample text
let pattern = /\d+/g; // Matches all instances of one or more digits
pattern.test(text) // => true: a match exists
text.search(pattern) // => 9: position of first match
text.match(pattern) // => ["1", "2", "3"]: array of all matches
text.replace(pattern, "#") // => "testing: #, #, #"
text.split(/\D+/) // => ["","1","2","3"]: split on nondigits

```

## Boolean
- any JavaScript value can be converted to a `boolean value`
- All other values, including all objects (and arrays) convert to, and work like, true.
- false, and the six `undefined, null, 0, -0, "", NaN` values that convert to it, are sometimes called `falsy` values, and all other values are called `truthy`. Any time JavaScript expects a boolean value, a falsy value works like false and a truthy value works like true.

## null and undefined

- null is a `language keyword` that evaluates to a special value that is usually used to
indicate the absence of a value. 
- undefined is a predefined global constant (not a language keyword like null that represents a deeper kind of absence. It is the value of variables that have not been initialized and the value you get when you query the value of an object property or array element that does not exist. The undefined value is also the return value of functions that do not explicitly return a value and the value of function parameters for which no argument is passed.
- The equality operator == considers them to be equal. (Use the strict equality operator === to distinguish them.
- Neither null nor undefined have any properties or methods.
- you can consider undefined to represent a system-level, `unexpected`, or error-like absence of
value and null to represent a program-level, normal, or `expected` absence of value

## Symbol

```js
let s = Symbol("sym_x");
let s = Symbol.for("shared");
s.toString() // => "Symbol(shared)"
Symbol.keyFor(t) // => "shared"
```

## Global Object

When the JavaScript interpreter starts (or whenever a web browser loads a new page), it creates a new global object and gives it an initial set of properties that define:`Global constants`, `Global functions`, `Constructor functions`,`` Global objects`

```js

```

![[Conversions#ConversionCode]]

## Variable Declaration and Assignment

- Before you can use a variable or constant in a JavaScript program, you must declare it. In ES6 and later, this is done with the `let` and `const` keywords, which we explain next
- Variables declared with `var` do not have block scope. Instead, they are scoped to the body of the containing function no matter how deeply nested they are inside that function.
- If you use `var` outside of a function body, it declares a `global variable`. But global variables declared with `var` differ from globals declared with `let` in an important way. Globals declared with var are implemented as `properties of the global object` (§3.7). The global object can be referenced as `globalThis`. **So if you write var x = 2; outside of a function, it is like you wrote globalThis.x = 2;.** Note however, that the analogy is not perfect: the properties created with global var declarations cannot be deleted with the delete operator (§4.13.4). Global variables and constants declared with let and const are not properties of the global object.
```js
let i = 0, j = 0, k = 0;
const H0 = 74;

```

## Destructuring Assignment

```js
let [x,y] = [1,2]; // Same as let x=1, y=2
[x,y] = [x+1,y+1]; // Same as x = x + 1, y = y + 1
[x, y] = [y, x] //swap x and y

let o = { x: 1, y: 2 };
for(const [name, value] of Object.entries(o))
{
	console.log(name, value);
}

let [x,y] = [1]; // x == 1; y == undefined 
[x,y] = [1,2,3]; // x == 1; y == 2
[,x,,y] = [1,2,3,4]; // x == 2; y == 4

let [x, ...y] = [1,2,3,4]; // y == [2,3,4]
let [a, [b, c]] = [1, [2,2.5], 3]; // a == 1; b == 2; c == 2.5

// You can use any iterable object (Chapter 12) on the righthand side of the assignment;

let [first, ...rest] = "Hello";

let points = [{x: 1, y: 2}, {x: 3, y: 4}];
let [{x: x1, y: y1}, {x: x2, y: y2}] = points; // destructured into 4 variables (x1, y1, x2, y2).

// Destructuring assignment can also be performed when the righthand side is an object value. In this case, the lefthand side of the assignment looks something like an object literal: a comma-separated list of variable names within curly braces

let transparent = {r: 0.0, g: 0.0, b: 0.0, a: 1.0}; // A RGBA color let 
{r, g, b} = transparent; // r == 0.0; g == 0.0; b == 0.0

// Same as const sin=Math.sin, cos=Math.cos, tan=Math.tan 
const {sin, cos, tan} = Math;

```

## Eval

eval() expects one argument. If you pass any value other than a string, it simply returns that value. If you pass a string, it attempts to parse the string as JavaScript code, throwing a SyntaxError if it fails. If it successfully parses the string, then it evaluates the code and returns the value of the last expression or statement in the string or undefined if the last expression or statement had no value. If the evaluated string throws an exception, that exception propogates from the call to eval().
The key thing about eval() (when invoked like this) is that it uses the variable environment of the code that calls it. That is, it looks up the values of variables and defines new variables and functions in the same way that local code does. If a function defines a local variable x and then calls eval("x"), it will obtain the value of the local variable. If it calls eval("x=1"), it changes the value of the local variable. And if the function calls eval("var y = 3;"), it declares a new local variable y. On the other hand, if the evaluated string uses let or const, the variable or constant declared will be local to the evaluation and will not be defined in the calling environment.

```js
const geval = eval
x = "global"
y = "global"

console.log(globalThis.y) //global

function l(){
	let x = "local"
	eval("x += ' changed';")
	return (x)
}

  

function g(){
	let y = "local"
	geval("y += ' changed';")
	return (y);
}

console.log(l(), x) //local changed global
console.log(g(), y) //local global changed


//-----------------------------
  

function test1(){
	eval("n = 100")
	console.log(n) //100
	console.log(globalThis.n) //100
}
test1()
console.log(n) //100
console.log(globalThis.n) //100

//-----------------------------

function test2(){
	eval("var q = 101")
	console.log(q) //101
	console.log(globalThis.q) //not defined
}
test2()
console.log(q) //not defined
console.log(globalThis.q) //not defined

//----------------------------- 

eval("let r = 100")
console.log(r) //not defined

```
When eval() is called from strict-mode code, or when the string of code to be evaluated itself begins with a “use strict” directive, then eval() does a local eval with a private variable environment. This means that in strict mode, evaluated code can query and set local variables, but it cannot define new variables or functions in the local scope. Furthermore, strict mode makes eval() even more operator-like by effectively making “eval” into a reserved word