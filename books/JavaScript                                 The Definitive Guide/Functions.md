- In JavaScript, functions are objects, and they can be manipulated by programs. JavaScript can assign functions to variables and pass them to other functions, for example. Since functions are objects, you can set properties on them and even invoke methods on them
- `“arrow functions, Function() constructor, function* defines generator, async function.`
- function declarations are allowed within blocks. A function defined within a block only exists within that block, however, and is not visible outside the block.
- Note that the function name is optional
- functions defined with expressions cannot be invoked before they are defined.
- The interesting thing about nested functions is their variable scoping rules: they can access the parameters and variables of the function

```js
// This function expression defines a function that squares its argument.
// Note that we assign it to a variable
const square = function(x) { return x*x; };
// Function expressions can include names, which is useful for recursion.
const f = function fact(x) { if (x <= 1) return 1; else return x*fact(x-1); };
// Function expressions can also be used as arguments to other functions: 
[3,2,1].sort(function(a,b) { return a-b; });
// Function expressions are sometimes defined and immediately invoked: 
let tensquared = (function(x) {return x*x;}(10));
```

- But arrow functions support an even more compact syntax. If the body of the function is a single return statement, you can omit the return keyword, the semicolon that goes with it, and the curly braces, and write the body of the function as the expression whose value is to be returned:
- Furthermore, if an arrow function has exactly one parameter, you can omit the parentheses around the parameter list:
- Note that, when writing an arrow function, you must not put a new line between the function parameters and the => arrow
- Arrow functions also differ from other functions in that they do not have a prototype property, which means that they cannot be used as constructor functions for new classes
- they inherit the value of the this keyword from the environment in which they are defined rather than defining their own invocation context
```js
const polynomial = x => x*x + 2*x + 3;
```

## Function Invocation

- function, method, constructor
- When methods return objects, you can use the return value of one method invocation as part of a subsequent invocation. This results in a `series (or “chain”) of method` invocations as a single expression.
- you will enable a style of programming known as `method chaining` in which an object can be named once and then multiple methods can be invoked on it.

```js
//f?.(x) <=>
(f !== null && f !== undefined) ? f(x) : undefined
// Define and invoke a function to determine if we're in strict mode.
const strict = (function() { return !this; }());
```
- The this keyword is not scoped the way variables are, and, except for arrow functions, nested functions do not inherit the this value of the containing function
```js
let o = { // An object o.
	m: function() { // Method m of the object.
		let self = this; // Save the "this" value in a variable.
		this === o// => true: "this" is the object o.
		f(); // Now call the helper function f(). 
		function f() { // A nested function f
			this === o // => false: "this" is global or undefined 'strict mode'
			self === o // => true: self is the outer "this" value.
		} 
	}
}; 
o.m(); // Invoke the method m on the object o.
  
//In ES6 and later, another workaround to this issue is to convert the nested function f into an arrow function, which will properly inherit the this value:
const f = () => { 
	this === o // true, since arrow functions inherit this
};


//Another workaround is to invoke the bind() method of the nested function to define a new function that is implicitly invoked on a specified object:
const f = (function() { 
	this === o // true, since we bound this function to the outer this
}).bind(this);

```

#### Constructor Invocation

- If a function or method invocation is preceded by the keyword new, then it is a constructor invocation
#### Indirect Invocation

- JavaScript functions are objects, and like all JavaScript objects, they have methods. Two of these methods,` call()` and `apply()`, invoke the function indirectly.
#### Implicit Function Invocation

- If an object has `getters or setters `defined, then querying or setting the value of its properties may invoke those methods. See §6.10.6 for more information.
-  When an object is used in a string context (such as when it is concatenated with a string), its `toString()` method is called. Similarly, when an object is used in a numeric context, its `valueOf() `method is invoked. See §3.9.3 for details.
-  When you loop over the elements of an `iterable object`, there are a number of method calls that occur. Chapter 12 explains how iterators work at the function call level and demonstrates how to write these methods so that you can define your own iterable types.
- A `tagged template literal` is a function invocation in disguise. §14.5 demonstrates how to write functions that can be used in conjunction with template literal strings.
-  `Proxy objects `(described in §14.7) have their behavior completely controlled by functions. Just about any operation on one of these objects will cause a function to be invoked.

## Optional Parameters and Defaults

- The programmer who calls your function cannot omit the first argument and pass the second: they would have to explicitly pass undefined as the first argument.
- Parameter default expressions are evaluated when your function is called, not when it is defined.
```js
function getPropertyNames(o, a = []) { 
	for(let property in o)
		a.push(property);
	return a;
}
```

## Rest Parameters and Variable-Length Argument Lists

- Rest allow us to write functions that can be invoked with arbitrarily more arguments than parameters.
- are stored in an array that becomes the value of the rest parameter
- The array may be empty, but a rest parameter will never be undefined
```js
function max(first=-Infinity, ...rest) { 
	let maxValue = first; // Start by assuming the first arg is biggest
	// Then loop through the rest of the arguments, looking for bigger
	for(let n of rest) { 
		if (n > maxValue) { maxValue = n;} 
	}
// Return the biggest 
return maxValue;
}
max(1, 10, 100, 2, 3, 1000, 4, 5, 6) // => 1000
```

Functions like the previous example that can accept any number of arguments are `called variadic functions, variable arity functions, or vararg functions.`

- (p196)The Arguments object dates back to the earliest days of JavaScript and carries with it some strange historical baggage that makes it inefficient and hard to optimize, especially outside of strict mode. You may still encounter code that uses the Arguments object, but you should avoid using it in any new code you write. When refactoring old code, if you encounter a function that uses arguments, you can often replace it with a ...args rest parameter. Part of the unfortunate legacy of the Arguments object is that, in strict mode, arguments is treated as a reserved word, and you cannot declare a function parameter or a local variable with that name.

## Destructuring Function Arguments into Parameters

```js

function vectorAdd([x1,y1], [x2,y2]) { 
	// Unpack 2 arguments into 4 parameters
	return [x1 + x2, y1 + y2];
}
vectorAdd([1,2], [3,4]) // => [4,6]


// Multiply the vector {x,y} or {x,y,z} by a scalar value function 
vectorMultiply({x, y, z=0}, scalar) { 
	return { x: x*scalar, y: y*scalar, z: z*scalar };
}
vectorMultiply({x: 1, y: 2}, 2) // => {x: 2, y: 4, z: 0}
```

- Some languages (like Python) allow the caller of a function to invoke a function with arguments specified in name=value form, which is convenient when there are many optional arguments or when the parameter list is long enough that it is hard to remember the correct order. JavaScript does not allow this directly, but you can approximate it by destructuring an object argument into your function parameters
```js
function arraycopy({from, to=from, n=from.length, fromIndex=0, toIndex=0}) { 
	let valuesToCopy = from.slice(fromIndex, fromIndex + n);
	to.splice(toIndex, 0, ...valuesToCopy);
	return to;
}
let a = [1,2,3,4,5], b = [9,8,7,6,5];
arraycopy({from: a, n: 3, to: b, toIndex: 4}) // => [9,8,7,6,1,2,3,5]




function f([x, y, ...coords], ...rest) { 
	return [x+y, ...rest, ...coords]; // Note: spread operator here
}
f([1, 2, 3, 4], 5, 6) // => [3, 5, 6, 3, 4]



// Multiply the vector {x,y} or {x,y,z} by a scalar value, retain other props 
function vectorMultiply({x, y, z=0, ...props}, scalar) { 
	return { x: x*scalar, y: y*scalar, z: z*scalar, ...props };
}
vectorMultiply({x: 1, y: 2, w: -1}, 2) // => {x: 2, y: 4, z: 0, w: -1}

```

## Defining Your Own Function Properties

- Functions are not primitive values in JavaScript, but a specialized kind of object, which means that functions can have properties. When a function needs a “static” variable whose value persists across invocations, it is often convenient to use a property of the function itself
```js
uniqueInteger.counter = 0;
function uniqueInteger() { 
	return uniqueInteger.counter++;
}
```

## Closures

- combination of a function object and a scope (a set of variable bindings) in which the function’s variables are resolved is called a closure in the computer science literature.
```js
let scope = "global scope";
// A global variable

function checkscope() {
	let scope = "local scope";
	// A local variable
	function f() {
		return scope;
	} // Return the value in scope here return f;
}
let s = checkscope()(); // What does this return?
```

- Remember the fundamental rule of lexical scoping: JavaScript functions are executed using the scope they were defined in. The nested function f() was defined in a scope where the variable scope was bound to the value “local scope”. That binding is still in effect when f is executed, no matter where it is executed from.
```js
let uniqueInteger = (function() {
	let counter = 0;
	// Private state of function below
	return function() { return counter++; };
}());
uniqueInteger() // => 0
uniqueInteger() // => 1
```
- It is the return value of the function that is being assigned to uniqueIn teger
```js
function counter() {
	let n = 0;
	return { 
		count: function() { return n++; },
		reset: function() { n = 0; }
	};
}
let c = counter(), d = counter();
c.count() // => 0
d.count() // => 0: they count independently
```

- The counter() function returns a “counter” object. This object has two methods: count() returns the next integer, and reset() resets the internal state. The first thing to understand is that the two methods share access to the private variable n.
- The second thing to understand is that each invocation of counter() creates a new scope— independent of the scopes used by previous invocations—and a new private variable within that scope. So if you call counter() twice, you get two counter objects with different private variables. Calling count() or reset() on one counter object has no effect on the other.
```js
function counter(n) {// Function argument n is the private variable
	return {
	// Property getter method returns and increments private counter var.
		get count() { return n++; },
	// Property setter doesn't allow the value of n to decrease
		set count(m) { 
			if (m > n)
				n = m;
			else 
				throw Error("count can only be set to a larger value");
			}
	}
}
let count = counter(1000)
c.count //=> 1000
c.count //=> 1001

```

- Another thing to remember when writing closures is that this is a JavaScript keyword, not a variable. As discussed earlier, arrow functions inherit the this value of the function that contains them, but functions defined with the function keyword do not. So if you’re writing a closure that needs to use the this value of its containing function, you should use an arrow function, or call bind(), on the closure before returning it, or assign the outer this value to a variable that your closure will inherit:

```js
function constfuncs() {
	let funcs = [];
	for(var i = 0; i < 10; i++) {
		funcs[i] = () => i;
	} 
	return funcs;
}
let funcs = constfuncs(); funcs[5]()
// => 10; Why doesn't this return 5?
//P208
```

## Function Properties, Methods, and Constructor

#### The length Property

- The read-only length property of a function specifies the arity of the function—the number of parameters it declares in its parameter list, which is usually the number of arguments that the function expects. If a function has a rest parameter, that parameter is not counted for the purposes of this length property.

#### The name property

- The read-only name property of a function specifies the name that was used when the function was defined, if it was defined with a name, or the name of the variable or property that an unnamed function expression was assigned to when it was first created. This property is primarily useful when writing debugging or error messages.

#### The prototype Property

- All functions, except arrow functions, have a prototype property that refers to an
object known as the prototype object.

#### The call() and apply() Methods

- call() and apply() allow you to indirectly invoke (§8.2.4) a function as if it were a method of some other object. The first argument to both call() and apply() is the object on which the function is to be invoked; this argument is the invocation context and becomes the value of the this keyword within the body of the function.
```js
f.call(o, arg1, arg2)
f.apply(o, [arg1, arg2])
```
- Remember that arrow functions inherit the this value of the context where they are defined. This cannot be overridden with the call() and apply() methods. If you call either of those methods on an arrow function, the first argument is effectively ignored.

#### The bind() Method

- The primary purpose of bind() is to bind a function to an object. When you invoke the bind() method on a function f and pass an object o, the method returns a new function. Invoking the new function (as a function) invokes the original function f as a method of o
```js
function f(y) { return this.x + y; } // This function needs to be bound
let o = { x: 1 }; // An object we'll bind to
let g = f.bind(o); // Calling g(x) invokes f() on o
g(2) // => 3 
let p = { x: 10, g };
p.g(2) // => 3: g is still bound to o, not p.
```
- Arrow functions inherit their this value from the environment in which they are defined, and that value cannot be overridden with bind()
- any arguments you pass to bind() after the first are bound along with the this value. This partial application feature of bind() does work with arrow functions.
```js
let sum = (x,y) => x + y;
// Return the sum of 2 args
let succ = sum.bind(null, 1); // Bind the first argument to 1
succ(2) // => 3: x is bound to 1, and we pass 2 for the y argument

function f(y,z) {return this.x + y + z; }
let g = f.bind({x: 1}, 2); // Bind this and y
g(3) // => 6: this.x is bound to 1, y is bound to 2 and z is 3
```

#### toString

In practice, most (but not all) implementations of this toString() method return the complete source code for the function. Built-in functions typically return a string that includes something like “\[native code\]” as the function body

## Function Contructor

```js
const f = new Function("x", "y", "return x*y;");
```

- The Function() constructor expects any number of string arguments. The last argument is the text of the function body
- The Function() constructor allows JavaScript functions to be dynamically created and compiled at runtime
- A last, very important point about the Function() constructor is that the functions it creates do not use lexical scoping; instead, they are always compiled as if they were top-level functions, as the following code demonstrates:
- The Function() constructor is best thought of as a globally scoped version of eval() (see §4.12.2) that defines new variables and functions in its own private scope. You will probably never need to use this constructor in your code.

```js
let scope = "global";
function constructFunction() {
	let scope = "local";
	return new Function("return scope"); // Doesn't capture local scope!
}
// This line returns "global" because the function returned by the
// Function() constructor does not use the local scope.
constructFunction()() // => "global"
```

## Functional Programming

- JavaScript is not a functional programming language like Lisp or Haskell, but the fact that JavaScript can manipulate functions as objects means that we can use functional programming techniques in JavaScript

#### Processing Arrays with Functions

```js
// First, define two simple functions
const sum = (x,y) => x+y;
const square = x => x*x;
// Then use those functions with Array methods to compute mean and stddev let 
data = [1,1,3,5,5];
let mean = data.reduce(sum)/data.length; // mean == 3
let deviations = data.map(x => x-mean);
let stddev = Math.sqrt(deviations.map(square).reduce(sum)/(data.length-1)); stddev // => 2
```

- This new version of the code looks quite different than the first one, but it is still invoking methods on objects, so it has some object-oriented conventions remaining. Let’s write functional versions of the map() and reduce() methods:
```js
const map = function(a, ...args) { return a.map(...args); };
const reduce = function(a, ...args) { return a.reduce(...args); };

// With these map() and reduce() functions defined, our code to compute the mean and standard deviation now looks like this:

const sum = (x,y) => x+y;
const square = x => x*x;
let data = [1,1,3,5,5];
let mean = reduce(data, sum)/data.length;
let deviations = map(data, x => x-mean);
let stddev = Math.sqrt(reduce(map(deviations, square), sum)/(data.length-1)); stddev // => 2

```

#### Higher-Order Functions

- A higher-order function is a function that operates on functions, taking one or more functions as arguments and returning a new function. Here is an example:
```js
function not(f) {
	return function(...args) {
		// Return a new function
		let result = f.apply(this, args); // that calls f
		return !result; // and negates its result.
	};
}

const even = x => x % 2 === 0;
const odd = not(even);// A new function that does the opposite 
[1,1,3,5,5].every(odd) //true
```

```js
function mapper(f) {
	return a => map(a, f);
}
const increment = x => x+1;
const incrementAll = mapper(increment);
incrementAll([1,2,3]) // => [2,3,4]



function compose(f, g) {
	return function(...args) {
// We use call for f because we're passing a single value and // apply for g because we're passing an array of values.
	return f.call(this, g.apply(this, args));
	}; 
}
const sum = (x,y) => x+y;
const square = x => x*x;
compose(square, sum)(2,3) // => 25; the square of the sum
```

#### Partial Application of Functions

- The bind() method of a function f (see §8.7.5) returns a new function that invokes f in a specified context and with a specified set of arguments. We say that it binds the function to an object and partially applies the arguments. The bind() method partially applies arguments on the left—that is, the arguments you pass to bind() are placed at the start of the argument list that is passed to the original function. But it is also possible to partially apply arguments on the right:

```js
// The arguments to this function are passed on the left
function partialLeft(f, ...outerArgs) {
	return function(...innerArgs) { // Return this function
		let args = [...outerArgs, ...innerArgs]; // Build the argument list
		return f.apply(this, args);// Then invoke f with it 
	};
}

// The arguments to this function are passed on the right
function partialRight(f, ...outerArgs) {
	return function(...innerArgs) { // Return this function
		let args = [...innerArgs, ...outerArgs];// Build the argument list
		return f.apply(this, args); // Then invoke f with it
	};
}

const f = function(x,y,z) { return x * (y - z); };
partialLeft(f, 2)(3,4) // => -2: Bind first argument: 2 * (3 - 4)
partialRight(f, 2)(3,4) // => 6: Bind last argument: 3 * (4 - 2)



const increment = partialLeft(sum, 1);
const cuberoot = partialRight(Math.pow, 1/3);
cuberoot(increment(26)) // => 3



const not = partialLeft(compose, x => !x);
const even = x => x % 2 === 0;
const odd = not(even);
const isNumber = not(isNaN);
odd(3) && isNumber(2) // => true

```

#### Memoization

- In §8.4.1, we defined a factorial function that cached its previously computed results. In functional programming, this kind of caching is called memoization. The code that follows shows a higher-order function, memoize(), that accepts a function as its argument and returns a memoized version of the function:

```js
function memoize(f) {
	const cache = new Map(); // Value cache stored in the closure.
	return function(...args) {
// Create a string version of the arguments to use as a cache key.
		let key = args.length + args.join("+");
		if (cache.has(key)) {
			return cache.get(key);
		} else { 
			let result = f.apply(this, args);
			cache.set(key, result);
			return result;
		}
	}; 
}
```