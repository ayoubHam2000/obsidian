## Statement

![[Screen Shot 2023-04-04 at 8.19.28 PM.png]]


A statement block is simply a sequence of statements enclosed within curly braces.

```js
{
	let a = 5;
	let b = 6;
}
```

`A compound statement` allows you to use multiple statements where JavaScript syntax expects a single statement. `The empty statement` is the opposite: it allows you to include no statements where one is expected.

```js
;
```

When you intentionally use the empty statement, it is a good idea to comment your code in a way that makes it clear that you are doing it on purpose

```js
if (expression) {

} else if (expression) {

} else {

}

//=======

switch (expression) {
	case 1: expression === 1
		break ; 
	default:
		break ; 
}

//======

while (expression) {

}

//======

do {

} while (expression);


//======

let i, j = 0;
for (i = 0; i < 10 && j < 20; i++, j += 10) {
	console.log(i, j)
}

//======

for/of
//The for/of loop works with iterable objects.
//Objects are not (by default) iterable
//If you want to iterate through the properties of an object, you can use the for/in loop (introduced in §5.4.5), or use for/of with the Object.keys() method

let o = {x:1, y:2, z:10}
for (let item of Object.keys(o)){
	console.log(item)
}
//Object.values(o), Object.entries(o)
//Note that strings are iterated by Unicode codepoint.

let m = new Map([[1, "value"]])
for (let [key, value] of m){
	console.log(key, value)
}

// introduces a new kind of iterator, known as an asynchronous iterator, and a variant on the for/of loop, known as the for/await loop that works with asynchronous iterators.

async function printStream(stream) { 
	for await (let chunk of stream) { 
		console.log(chunk);
	} 
}

//========

for/in

for (variables in object)

let m = {a:1,b:2,c:3}
for (let item in m) {
	console.log(item)
	console.log(m[item])
}
```

## Jump statements

```js
//continue, break, return, throw, try/catch/finally
// JavaScript allows statements to be named, or labeled, and break and continue can identify the target loop or other statement label.
```

## Labled statement

Any statement may be labeled by preceding it with an identifier and a colon
```js
//identifier: statement

mainloop: while(token !== null) 
{ // Code omitted... 
	continue mainloop; // Jump to the next iteration of the named loop // More code omitted...
}
```

- The namespace for labels is different than the namespace for variables and functions, so you can use the same identifier as a statement label and as a variable or function name

## yeild

- The yield statement is much like the return statement but is used only in ES6 generator functions
- In order to understand yield, you must understand iterators and generators
//Chapter 12

## Throw

`throw expression`
```js

function div(number)
{
	if (number === 0)
		throw new Error("number = 0")
	return (number);
}

```

- expression may evaluate to a value of any type. You might throw a number that represents an error code or a string that contains a human-readable error message. The Error class and its subclasses are used when the JavaScript interpreter itself throws an error.
- When an exception is thrown, the JavaScript interpreter immediately stops normal program execution and jumps to the nearest exception handler. Exception handlers are written using the catch clause of the `try/catch/finally` statement

## Try/Catch/Finally

The try/catch/finally statement is JavaScript’s exception handling mechanism. The try clause of this statement simply defines the block of code whose exceptions are to be handled. The try block is followed by a catch clause, which is a block of statements that are invoked when an exception occurs anywhere within the try block. The catch clause is followed by a finally block containing cleanup code that is guaranteed to be executed, regardless of what happens in the try block. Both the catch and finally blocks are optional, but a try block must be accompanied by at least one of these blocks. The try, catch, and finally blocks all begin and end with curly braces. These braces are a required part of the syntax and cannot be omitted, even if a clause contains only a single statement.

```js
try {
	// Normally, this code runs from the top of the block to the bottom
	// without problems. But it can sometimes throw an exception,
	// either directly, with a throw statement, or indirectly, by calling
	// a method that throws an exception.
} catch(e) {
	// The statements in this block are executed if, and only if, the try
	// block throws an exception. These statements can use the local variable
	// e to refer to the Error object or other value that was thrown.
	// This block may handle the exception somehow, may ignore the
	// exception by doing nothing, or may rethrow the exception with throw.
} finally {
	// This block contains statements that are always executed, regardless of
	// what happens in the try block. They are executed whether the try
	// block terminates:
	// 1) normally, after reaching the bottom of the block
	// 2) because of a break, continue, or return statement
	// 3) with an exception that is handled by a catch clause above
	// 4) with an uncaught exception that is still propagating
}

let i = 0
while (i < 100) {
	try {
		console.log(i)
		continue ;
	} finally {
		i++;
	}
}


function parseJSON(s) { 
	try {
		return JSON.parse(s); 
	}
	catch {
	// Something went wrong but we don't care what it was return undefined;
	} 
}
```


## Use Strict

"use strict" is a directive introduced in ES5. Directives are not statements (but are
close enough that "use strict" is documented here). There are two important differences between the "use strict" directive and regular statements:
- It does not include any language keywords: the directive is just an expression statement that consists of a special string literal (in single or double quotes).
- It can appear only at the start of a script or at the start of a function body, before any real statements have appeared.
- Code passed to the eval() method is strict code if eval() is called from strict code or if the string of code includes a "use strict" directive. In addition to code explicitly declared to be strict, any code in a class body (Chapter 9) or in an ES6 module (§10.3) is automatically strict code. This means that if all of your JavaScript code is written as modules, then it is all automatically strict, and you will never need to use an explicit "use strict" directive.
- [[The different between strict mode and regular mode]]

## Declarations

- The keywords `const, let, var, function, class, import, and export` are not technically statements, but they look a lot like statements, and this book refers informally to them as statements, so they deserve a mention in this chapter.
- Variables declared with var are scoped to the containing function rather than the containing block This can be a source of bugs, and in modern JavaScript there is really no reason to use var instead of let
- Unlike functions, class declarations are not `hoisted`, and you cannot use a class declared this way in code that appears before the declaration.
- The import and export declarations are used together to make values defined in one module of JavaScript code available in another module. A module is a file of JavaScript code with its own global namespace, completely independent of all other modules. The only way that a value (such as function or class) defined in one module can be used in another module is if the defining module exports it with export and the using module imports it with import.
```js
import Circle from './geometry/circle.js';
import { PI, TAU } from './geometry/constants.js';
import { magnitude as hypotenuse } from './vectors/utils.js';


export const TAU = 2 * Math.PI;
export function magnitude(x,y) { 
	return Math.sqrt(x*x + y*y); 
}
export default class Circle { /* class definition omitted here */ }

```

## Other

`with` : The with statement is forbidden in strict mode (see §5.6.3) and should be considered deprecated in non-strict mode

`debugger` : The debugger statement normally does nothing. If, however, a debugger program is available and is running, then an implementation may (but is not required to) perform some kind of debugging action. In practice, this statement acts like a breakpoint: execution of JavaScript code stops, and you can use the debugger to print variables’ values, examine the call stack, and so on
