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