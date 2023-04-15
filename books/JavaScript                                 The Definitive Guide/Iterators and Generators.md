- iterated—looped over—with the for/of loop
- Iterators can also be used with the ... operator to expand or “spread” an iterable object into an array initializer or function invocation, as we saw in
- Iterators can be used with destructuring assignment
```js
let purpleHaze = Uint8Array.of(255, 0, 255, 128);
let [r, g, b, a] = purpleHaze; // a == 128
```

## How Iterators Work

- First, there are the iterable objects: these are types like Array, Set, and Map that can be iterated. Second, there is the iterator object itself, which performs the iteration. And third, there is the iteration result object that holds the result of each step of the iteration.
- An iterable object is any object with a special iterator method that returns an iterator object. 
- An iterator is any object with a next() method that returns an iteration result object. 
- And an iteration result object is an object with properties named value and done.
```js
let iterable = [99];
let iterator = iterable[Symbol.iterator]();
for(let result = iterator.next(); !result.done; result = iterator.next())
{
	console.log(result.value) // result.value == 99
}

let list = [1,2,3,4,5];
let iter = list[Symbol.iterator]();
let head = iter.next().value; // head == 1
let tail = [...iter]; // tail == [2,3,4,5]
```

- In order to make a class iterable, you must implement a method whose name is the Symbol `Symbol.iterator`. That method must return an iterator object that has a `next()` method. And the next() method must return an iteration result object that has a value property and/or a boolean done property. Example 12-1 implements an iterable Range class and demonstrates how to create iterable, iterator, and iteration result objects.

```js
class Range {
	constructor (from, to) {
			this.from = from;
			this.to = to;
	}
	
	has(x) { return typeof x === "number" && this.from <= x && x <= this.to; }
	
	toString() { return `{ x | ${this.from} ≤ x ≤ ${this.to} }`; }
	
	[Symbol.iterator]() {
		let next = Math.ceil(this.from);
		let last = this.to;
		return {
			// It must return an iterator result object
			next() {
				return (next <= last) ? { value: next++ } : { done: true };
			},
			// As a convenience, we make the iterator itself iterable.
			[Symbol.iterator]() { return this; }
		};
	}
}

for(let x of new Range(1,10))
	console.log(x); // Logs numbers 1 to 10
[...new Range(-2,2)] // => [-2, -1, 0, 1, 2]


function map(iterable, f) {
	let iterator = iterable[Symbol.iterator]();
	return {
		// This object is both iterator and iterable
		[Symbol.iterator]() { return this; },
		next() {
			let v = iterator.next();
			if (v.done) {
				return v;
			} else {
				return { value: f(v.value) };
			} 
		} 
	}; 
}

[...map(new Range(1,4), x => x*x)] // => [1, 4, 9, 16]

function filter(iterable, predicate) {
	let iterator = iterable[Symbol.iterator]();
	return { // This object is both iterator and iterable
		[Symbol.iterator]() { return this; },
		next() {
			for(;;) {
				let v = iterator.next();
				if (v.done || predicate(v.value)) {
					return v;
				}
			}
		}
	};
}

[...filter(new Range(1,10), x => x % 2 === 0)] // => [2,4,6,8,10]

// Here is a function that allows you to lazily iterate the words of a string without keeping them all in memory at once

function words(s) {
	var r = /\s+|$/g;
	// Match one or more spaces or end
	r.lastIndex = s.match(/[^ ]/).index; // Start matching at first nonspace 
	return { // Return an iterable iterator object
		[Symbol.iterator]() { return this; },
		next() {
			let start = r.lastIndex;
			if (start < s.length) {
				let match = r.exec(s);
				if (match) {
					return { value: s.substring(start, match.index) };
				}
			}
			return { done: true };
		} 
	}; 
}

[...words(" abc def ghi! ")] // => ["abc", "def", "ghi!"]

```

## “Closing” an Iterator: The Return Method

... then the interpreter will check to see if the iterator object has a return() method. If this method exists, the interpreter will invoke it with no arguments, giving the iterator the chance to close files, release memory, and otherwise clean up after itself. The return() method must return an iterator result object. The properties of the object are ignored, but it is an error to return a non-object value.

- The `return()` method is a method that can be implemented by an iterator object to prematurely end the iteration and return a final value. When the `return()` method is called, the `done` property of the next object returned by the `next()` method will be set to `true`, indicating that the iteration has ended.

```js
function iterableObj()
{
	return {
		data: [1, 2, 3, 4, 5],
		index: 0,
	
		[Symbol.iterator]() { return (this); },
	
		next() {
		  if (this.index < this.data.length && this.index != -1) {
			return { value: this.data[this.index++], done: false };
		  } else {
			return { value: undefined, done: true };
		  }
		},
		return(value) {
		  console.log(`Iteration ended prematurely. Final value: ${value}`);
		  this.index = -1;
		  return { value: value, done: true };
		}
	}
}

let iterator = iterableObj()

for (let value of iterator) {
	console.log(value);
	if (value === 3) {
		iterator.return("The iteration was ended prematurely.");
	}
}

```

## Generators

- A generator is a kind of iterator defined with powerful new ES6 syntax; it’s particularly useful when the values to be iterated are not the elements of a data structure, but the result of a computation
- To create a generator, you must first define a generator function. A generator function is syntactically like a regular JavaScript function but is defined with the keyword `function*` rather than function. (Technically, this is not a new keyword, just a * after the keyword function and before the function name.) 
- When you invoke a generator function, it does not actually execute the function body, but instead returns a generator object. This generator object is an iterator. Calling its `next() `method causes the body of the generator function to run from the start (or whatever its current position is) until it reaches a yield statement. 
- `yield` is new in ES6 and is something like a return statement. The value of the yield statement becomes the value returned by the next() call on the iterator.

```js
function* oneDigitPrimes() {
	yield 2;
	yield 3;
	yield 5;
	yield 7;
}

let primes = oneDigitPrimes();

primes.next().value //=> 2
primes.next().value //=> 3
primes.next().value //=> 5
primes.next().value //=> 7
primes.next().done //=> true

// Generators have a Symbol.iterator method to make them iterable 
primes[Symbol.iterator]() // => primes

[...oneDigitPrimes()] // => [2,3,5,7]

const seq = function*(from,to) { 
	for(let i = from; i <= to; i++) yield i;
};
[...seq(3,5)] // => [3, 4, 5]


let o = {
	x: 1, y: 2, z: 3,
	// A generator that yields each of the keys of this object
	 *g() {
		for(let key of Object.keys(this)) {
			yield key;
		}
	} 
};
[...o.g()] // => ["x", "y", "z", "g"]

```

```js
function* fibonacciSequence() {
	let x = 0, y = 1;
	for(;;) {
		yield y; [x, y] = [y, x+y]; // Note: destructuring assignment
	}
}


// Yield the first n elements of the specified iterable object
function* take(n, iterable) {
	let it = iterable[Symbol.iterator](); // Get iterator for iterable object 
	while(n-- > 0) { // Loop n times:
		let next = it.next(); // Get the next item from the iterator.
		if (next.done) return; // If there are no more values, return early
		else yield next.value; // otherwise, yield the value
	}
}

// An array of the first 5 Fibonacci numbers 
[...take(5, fibonacciSequence())] // => [1, 1, 2, 3, 5]
```

```js
// Given an array of iterables, yield their elements in interleaved order.
function* zip(...iterables) {
	// Get an iterator for each iterable
	let iterators = iterables.map(i => i[Symbol.iterator]());
	let index = 0;
	while(iterators.length > 0) {
		// While there are still some iterators
		if (index >= iterators.length) {
			index = 0;
		}
		let item = iterators[index].next(); // Get next item from next iterator.
		if (item.done) {
			// If that iterator is done
			iterators.splice(index, 1);
		} else {
			yield item.value; index++;
		}
	} 
}

// Interleave three iterable objects
[...zip(oneDigitPrimes(),"ab",[0])] // => [2,"a",0,3,"b",5,7]
```

## yield* and Recursive Generators

```js
function* sequence(...iterables) {
	for(let iterable of iterables) {
		for(let item of iterable) {
			yield item;
		}
	} 
}
```

- This process of yielding the elements of some other iterable object is common
enough in generator functions that ES6 has special syntax for it. The yield* keyword is like yield except that, rather than yielding a single value, it iterates an iterable object and yields each of the resulting values. The sequence() generator function that we’ve used can be simplified with yield* like this

```js
function* sequence(...iterables) {
	for(let iterable of iterables) {
		yield* iterable;
	}
}
[...sequence("abc",oneDigitPrimes())] // => ["a","b","c",2,3,5,7]
```

- the Example bellow does not work, however. yield and yield* can only be used within generator functions, but the nested arrow function in this code is a regular function, not a function* generator function, so yield is not allowed.
- yield* can be used with any kind of iterable object, including iterables implemented with generators. This means that yield* allows us to define recursive generators, and you might use this feature to allow simple non-recursive iteration over a recursively defined tree structure, for example.
```js
function* sequence(...iterables) {
	iterables.forEach(iterable => yield* iterable ); // Error
}
```

```js
function* generateTree() {
	yield 1;
	yield* [2, 3, 4];
	yield* generateTreeChild();
}
  
function* generateTreeChild() {
	yield* [5, 6];
	yield* generateTreeGrandChild();
}

function* generateTreeGrandChild() {
	yield* [7, 8];
}


for (let value of generateTree()) {
	console.log(value);
}
```

## The Return Value of a Generator Function

- if the value property is defined, then the done property is undefined or is false. And if done is true, then value is undefined. But in the case of a generator that returns a value, the final call to next returns an object that has both value and done defined. The value property holds the return value of the generator function, and the done property is true, indicating that there are no more values to iterate. This final value is ignored by the for/of loop and by the spread operator, but it is available to code that manually iterates with explicit calls to next()

```js
function *oneAndDone() {
	yield 1; return "done";
}
[...oneAndDone()] // => [1]

// But it is available if you explicitly call next()
let generator = oneAndDone();
generator.next() // => { value: 1, done: false}
generator.next()  // => { value: "done", done: true }
// If the generator is already done, the return value is not returned again 
generator.next() // => { value: undefined, done: true }
```

## The Value of a yield Expression

- When the next() method of a generator is invoked, the generator function runs until it reaches a yield expression. The expression that follows the yield keyword is evaluated, and that value becomes the return value of the next() invocation. At this point, the generator function stops executing right in the middle of evaluating the yield expression. The next time the next() method of the generator is called, the argument passed to next() becomes the value of the yield expression that was paused. So the generator returns values to its caller with yield, and the caller passes values in to the generator with next(). The generator and caller are two separate streams of execution passing values (and control) back and forth. The following code illustrates:

```js
function* smallNumbers() {
	console.log("next() invoked the first time; argument discarded");
	let y1 = yield 1; // y1 == "b"
	console.log("next() invoked a second time with argument", y1);
	let y2 = yield 2; // y2 == "c"
	console.log("next() invoked a third time with argument", y2);
	let y3 = yield 3; // y3 == "d"
	console.log("next() invoked a fourth time with argument", y3);
	return 4;
}
let g = smallNumbers();
console.log("generator created; no code runs yet");
let n1 = g.next("a"); // n1.value == 1
console.log("generator yielded", n1.value);
let n2 = g.next("b"); // n2.value == 2
console.log("generator yielded", n2.value);
let n3 = g.next("c"); // n3.value == 3
console.log("generator yielded", n3.value);
let n4 = g.next("d"); // n4 == { value: 4, done: true }
console.log("generator returned", n4.value);

//Output

generator created; no code runs yet
next() invoked the first time; argument discarded
generator yielded 1
next() invoked a second time with argument b
generator yielded 2
next() invoked a third time with argument c
generator yielded 3
next() invoked a fourth time with argument d
generator returned 4


```

## The return() and throw() Methods of a Generator

- Recall from earlier in the chapter that, if an iterator defines a return() method and iteration stops early, then the interpreter automatically calls the return() method to give the iterator a chance to close files or do other cleanup. In the case of generators, you can’t define a custom return() method to handle cleanup, but you can structure the generator code to use a try/finally statement that ensures the necessary cleanup is done (in the finally block) when the generator returns. By forcing the generator to return, the generator’s built-in return() method ensures that the cleanup code is run when the generator will no longer be used.

```js
const iterator = iterableObj();

for (let value of iterator) {
  console.log(value);
  if (value === 3) {
    iterator.throw("An error occurred.");
  }
}

iterator.return("The iteration was ended.");

```

- When a generator uses` yield*` to yield values from some other iterable object, then a call to the `next()` method of the generator causes a call to the `next()` method of the iterable object. The same is true of the `return()` and` throw()` methods. If a generator uses `yield*` on an iterable object that has these methods defined, then calling `return()` or `throw()` on the generator causes the iterator’s `return()` or `throw()` method to be called in turn. All iterators must have a `next()` method. Iterators that need to clean up after incomplete iteration should define a `return()` method. And any iterator may define a `throw()` method, though I don’t know of any practical reason to do so.
```js
function* iterableObj() {
	const data = [1, 2, 3, 4, 5];
	let index = 0;

	try {
		while (index < data.length) {
			const value = data[index++];
			const shouldThrow = yield value;
			if (shouldThrow) {
				throw shouldThrow;
			}
		}
	} 
	catch(e){
		console.log(`Fix or reset or handle Error.`);
	}
	finally {
		console.log(`Iteration ended.`);
	}
}

  
const iterator = iterableObj();

for (let value of iterator) {
  console.log(value);
  if (value === 3) {
    iterator.throw("An error occurred.");
  }
}

iterator.return("The iteration was ended.");

```

- Generators are a very powerful generalized control structure. They give us the ability
to pause a computation with yield and restart it again at some arbitrary later time with an arbitrary input value. It is possible to use generators to create a kind of cooperative threading system within single-threaded JavaScript code. And it is possible to use generators to mask asynchronous parts of your program so that your code appears sequential and synchronous, even though some of your function calls are actually asynchronous and depend on events from the network.
- Trying to do these things with generators leads to code that is mind-bendingly hard to understand or to explain. It has been done, however, and the only really practical use case has been for managing asynchronous code. JavaScript now has async and await keywords (see Chapter 13) for this very purpose, however, and there is no longer any reason to abuse generators in this way.