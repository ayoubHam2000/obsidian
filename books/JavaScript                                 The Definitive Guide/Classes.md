- A simple JavaScript class
```js

// factory function
function range(from, to)
{
	let r = Object.create(range.methods);
	r.from = from;
	r.to = to;
	return r;
}

range.methods = {
	includes(x) { return this.from <= x && x <= this.to; },
	*[Symbol.iterator]() {
		for(let x = Math.ceil(this.from); x <= this.to; x++)
			yield x;
	},
	toString() { return "(" + this.from + "..." + this.to + ")"}
}

let r = range(1,3);
// Create a range object
r.includes(2) // => true: 2 is in the range 
r.toString() // => "(1...3)"
console.log([...r]) // => [1, 2, 3]; convert to an array via iterator


//same exmaple but with the constructor function
//this example demonstrates the idiomatic way to create a class in versions of JavaScript that do not support the ES6 class keyword.

function Range(from, to) {
	// These are noninherited properties that are unique to this object.
	this.from = from;
	this.to = to;
}

Range.prototype = {
	includes: function(x) { return this.from <= x && x <= this.to; },
	[Symbol.iterator]: function*() {
		for(let x = Math.ceil(this.from); x <= this.to; x++)
			yield x;
	},
	toString: function() { return "(" + this.from + "..." + this.to + ")"; }
}

let r = new Range(1,3);
console.log(r.__proto__)
r.includes(2)
r.toString()
console.log([...r])

```

- Another critical difference between Examples 9-1 and 9-2 is the way the prototype object is named. In the first example, the prototype was `range.methods`. This was a convenient and descriptive name, but arbitrary. In the second example, the prototype is `Range.prototype`, and this name is mandatory. 

```js
r instanceof Range // => true: r inherits from Range.prototype
```

- The instanceof operator was described in §4.9.4. The lefthand operand should be the object that is being tested, and the righthand operand should be a constructor function that names a class. The expression o instanceof C evaluates to true if o inherits from C.prototype. The inheritance need not be direct: if o inherits from an object that inherits from an object that inherits from C.prototype, the expression will still evaluate to true.
- Technically speaking, in the previous code example, the instanceof operator is not checking whether r was actually initialized by the Range constructor. Instead, it is checking whether r inherits from Range.prototype. If we define a function Strange() and set its prototype to be the same as Range.prototype, then objects created with new Strange() will count as Range objects as far as instanceof is concerned
```js
function Strange() {}
Strange.prototype = Range.prototype;
new Strange() instanceof Range // => true
```

- If you want to test the prototype chain of an object for a specific prototype and do not want to use the constructor function as an intermediary, you can use the isPrototypeOf() method. In Example 9-1, for example, we defined a class without a constructor function, so there is no way to use instanceof with that class. Instead, however, we could test whether an object r was a member of that constructor-less class with this code:

```js
range.methods.isPrototypeOf(r); // range.methods is the prototype object.
```

----

## The constructor Property

- Every regular JavaScript function automatically has a prototype property. The value of this property is an object that has a single, non-enumerable constructor property. The value of the constructor property is the function object
```js
let F = function(){}
F.prototype.constructor === F //true

let o = new F();
o.constructor === F //true


Range.prototype = {
	constructor: Range, // Explicitly set the constructor back-reference
/* method definitions go here */
};
// Extend the predefined Range.prototype object so we don't overwrite
// the automatically created Range.prototype.constructor property. 
Range.prototype.includes = function(x) {
	return this.from <= x && x <= this.to;
};
Range.prototype.toString = function() {
	return "(" + this.from + "..." + this.to + ")";
};

```