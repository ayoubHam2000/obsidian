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

## Classes with the class Keyword

```js
class Range {

	constructor(from, to) {
		this.from = from; this.to = to;
	}
	
	includes(x) { return this.from <= x && x <= this.to; }
	
	*[Symbol.iterator]() {
		for(let x = Math.ceil(this.from); x <= this.to; x++)
			yield x;
	}
	
	toString() { return `(${this.from}...${this.to})`; }

}

//subclass

class Span extends Range {
	constructor(start, length) {
		if (length >= 0) {
			super(start, start + length);
		} else {
			super(start + length, start);
		}
	}
}

```

- If your class does not need to do any initialization, you can omit the constructor keyword and its body, and an empty constructor function will be implicitly created for you
- As with function definition expressions, class definition expressions can include an optional class name
```js
let squre = class {constructor(x) {this.area = x * x;}};
```

- All code within the body of a class declaration is implicitly in strict mode (§5.6.3), even if no "use strict" directive appears. This means, for example, that you can’t use octal integer literals or the with statement within class bodies and that you are more likely to get syntax errors if you forget to declare a variable before using it
- Unlike function declarations, class declarations are not “hoisted.” Recall from §8.1.1 that function definitions behave as if they had been moved to the top of the enclosing file or enclosing function, meaning that you can invoke a function in code that comes before the actual definition of the function. Although class declarations are like function declarations in some ways, they do not share this hoisting behavior: you cannot instantiate a class before you declare it.

## Static Methods

- You can define a static method within a class body by prefixing the method declaration with the static keyword. Static methods are defined as properties of the constructor function rather than properties of the prototype object.
```js

class Range {
	...
	static parse(s) {
		let matches = s.match(/^\((\d+)\.\.\.(\d+)\)$/);
		if (!matches) {
			throw new TypeError(`Cannot parse Range from "${s}".`)
		}
		return new Range(parseInt(matches[1]), parseInt(matches[2]));
	}
}
```

## Public, Private, and Static Fields

```js
class Buffer {
	constructor() {
		this.size = 0;
		this.capacity = 4096;
		this.buffer = new Uint8Array(this.capacity);
	}
}

// With the new instance field syntax that is likely to be standardized, you could instead write

class Buffer {
	size = 0;
	capacity = 4096;
	buffer = new Uint8Array(this.capacity);
}
```

- The field initialization code has moved out of the constructor and now appears directly in the class body. (That code is still run as part of the constructor, of course. If you do not define a constructor, the fields are initialized as part of the implicitly created constructor.) The this. prefixes that appeared on the lefthand side of the assignments are gone, but note that you still must use this. to refer to these fields, even on the righthand side of the initializer assignments. The advantage of initializing your instance fields in this way is that this syntax allows (but does not require) you to put the initializers up at the top of the class definition, making it clear to readers exactly what fields will hold the state of each instance. You can declare fields without an initializer by just writing the name of the field followed by a semicolon. If you do that, the initial value of the field will be undefined. It is better style to always make the initial value explicit for all of your class fields.
```js
//private
class Buffer {
	#size = 0;
	get size() { return this.#size; }
}
//Note that private fields must be declared using this new field syntax before they can be used. You can’t just write this.#size = 0; in the constructor of a class unless you include a “declaration” of the field directly in the class body

//static
static integerRangePattern = /^\((\d+)\.\.\.(\d+)\)$/;
static parse(s) {
	let matches = s.match(Range.integerRangePattern);
	if (!matches) {
		throw new TypeError(`Cannot parse Range from "${s}".`)
	}
	return new Range(parseInt(matches[1]), matches[2]);
}
```

## Adding Methods to Existing Classes

```js
Complex.prototype.conj = function() { return new Complex(this.r, -this.i); };

if (!String.prototype.startsWith) {
	// ...then define it like this using the older indexOf() method. 
	String.prototype.startsWith = function(s) { return this.indexOf(s) === 0;
	}; 
}

```
- The prototype object of built-in JavaScript classes is also open like this, which means that we can add methods to numbers, strings, arrays, functions, and so on. This is useful for implementing new language features in older versions of the language:

## Subclasses and Prototypes

```js
function Span(start, span) {
	if (span >= 0) {
		this.from = start;
		this.to = start + span;
	} else {
		this.to = start;
		this.from = start + span;
	}
}
// Ensure that the Span prototype inherits from the Range prototype 
Span.prototype = Object.create(Range.prototype);
// We don't want to inherit Range.prototype.constructor, so we
// define our own constructor property.
Span.prototype.constructor = Span;
// By defining its own toString() method, Span overrides the
// toString() method that it would otherwise inherit from Range. 
Span.prototype.toString = function() {
	return `(${this.from}... +${this.to - this.from})`;
};

```

#### Subclasses with extends and super

- A robust subclassing mechanism needs to allow classes to invoke the methods and constructor of their superclass, but prior to ES6, JavaScript did not have a simple way to do these things.
- Fortunately, ES6 solves these problems with the super keyword as part of the class syntax

```js
class EZArray extends Array {
	get first() { return this[0]; }
	get last() { return this[this.length-1]; }
}

let a = new EZArray();
a instanceof EZArray // => true: a is subclass instance a instanceof Array
// => true: a is also a superclass instance.
a.push(1,2,3,4); // a.length == 4; we can use inherited methods 
a.pop() // => 4: another inherited method
a.first // => 1: first getter defined by subclass 
a.last // => 3: last getter defined by subclass
a[1] // => 2: regular array access syntax still works. 
Array.isArray(a) // => true: subclass instance really is an array 
EZArray.isArray(a) // => true: subclass inherits static methods, too!
```

```js
class TypedMap extends Map {
	constructor(keyType, valueType, entries) {
		// If entries are specified, check their types
		if (entries) {
			for(let [k, v] of entries) {
				if (typeof k !== keyType || typeof v !== valueType) {
					throw new TypeError(`Wrong type for entry [${k}, ${v}]`);
				}
			}
		}
		// Initialize the superclass with the (type-checked) initial entries 
		super(entries);
		// And then initialize this subclass by storing the types
		this.keyType = keyType;
		this.valueType = valueType;
	}
	// Now redefine the set() method to add type checking for any
	// new entries added to the map.
	set(key, value) {
		// Throw an error if the key or value are of the wrong type
		if (this.keyType && typeof key !== this.keyType) {
			throw new TypeError(`${key} is not of type ${this.keyType}`);
		}
		if (this.valueType && typeof value !== this.valueType) {
			throw new TypeError(`${value} is not of type ${this.valueType}`);
		}
		// If the types are correct, we invoke the superclass's version of
		// the set() method, to actually add the entry to the map. And we
		// return whatever the superclass method returns.
		return super.set(key, value);
	}
}
```
- You may not use the this keyword in your constructor until after you have invoked the superclass constructor with super(). This enforces a rule that superclasses get to initialize themselves before subclasses do.

#### Delegation Instead of Inheritance

- it is often easier and more flexible to get that desired behavior into your class by having your class create an instance of the other class and simply delegating to that instance as needed. You create a new class not by subclassing, but instead by wrapping or “composing” other classes. This delegation approach is often called “composition,” and it is an oft-quoted maxim of object-oriented programming that one should “favor composition over inheritance.”

## Notes

- ES6 introduces a class keyword that makes it easier to define classes, but under the hood, constructor and prototype mechanism remains the same.
- Subclasses are defined using the extends keyword in a class declaration. • Subclasses can invoke the constructor of their superclass or overridden methods of their superclass with the super keyword.



```js
class AbstractSet {
    has(x) {throw new Error("Abstruct method")}
}

class NotSet extends AbstractSet {
	constructor (set) {
		super();
		this.set = set;
	}

	has(x) {return !this.set.has(x);}

	toString() {return `{ x| x ∉ ${this.set.toString()}}`}
}

class RangeSet extends AbstractSet {
	constructor(from, to) {
			super()
			this.from = from;
		this.to = to;
	}

	has(x) {return x >= this.from && x <= this.to}
	toString() {return `{ x| ${this.from} ≤ x ≤ ${this.to} }`; }
}

class AbstrctEnumerableSet extends AbstractSet {
	get size() {throw new Error("Abstruct method")}
	[Symbol.iterator]() {throw new Error("Abstract method")}

	isEmpty() {return this.size === 0;}
	toString() {return `{${Array.from(this).join(", ")}}`}
	equals(set) {
		if (!(set instanceof AbstrctEnumerableSet))
			return (false);
		if (this.size !== set.size)
			return (false);
		for (let element of this) {
			if (!set.has(element))
					return (false)
		}
		return (true);
	}
}

class SingletonSet extends AbstrctEnumerableSet {
	constructor (member) {
		super()
		this.member = member;
	}

	has(x) { return x === this.member}
	get size() {return 1;}
	*[Symbol.iterator]() { yield this.member;}
}

class AbstractWritableSet extends AbstrctEnumerableSet {
	insert(x) {throw new Error("Abstract method")}
	remove(x) {throw new Error("Abstruct method")}

	add(set) {
		for (let element of set) {
			this.insert(element)
		}
	}

	subtract(set) {
		for (let element of set) {
			this.remove(element)
		}
	}

	intersect(set) {
		for (let element of this) {
			if (!set.has(element)) {
				this.remove(element)
			}
		}
	}
}


class BitSet extends AbstractWritableSet {
	constructor (max) {
		super();
		this.max = max;
		this.n = 0;
		this.numBytes = math.floor(max / 8) + 1;
		this.data = new Uint8Array(this.numBytes);
	}

	_valid(x) { return Number.isInteger(x) && x >= 0 && x <= this.max;}

	_has(byte, bit) { return (this.data[byte] & BitSet.bits[bit]) !== 0;}

	has(x) {
		if (this._valid(x)) {
			let byte = Math.floor(x / 8)
			let bit = x % 8
			return this._has(byte, bit)
		} else {
			return (false)
		}
	}

	insert(x) {
		if (this._valid(x)) {
			let byte = Math.floor(x / 8)
			let bit = x % 8;
			if (!this._has(byte, bit)) {
				this.data[byte] |= BitSet.bits[bit];
				this.n++;
			}
		} else {
			throw new TypeError("Invalide set element: " + x)
		}
	}

	remove(x) {
		if (this._valid(x)) {
			let byte = Math.floor(x / 8)
			let bit = x % 8;
			if (!this._has(byte, bit)) {
				this.data[byte] &= BitSet.bits[bit];
				this.n--;
			}
		} else {
			throw new TypeError("Invalid set element: " + x)
		}
	}

	get size() { return this.n}

	*[Symbol.iterator]() {
		for (let i = 0; i <= this.max; i++){
			if (this.has(i)) {
				yield i;
			}
		}
	}
}

BitSet.bits = new Uint8Array([1, 2, 4, 8, 16, 32, 64, 128]);
BitSet.masks = new Uint8Array([~1, ~2, ~4, ~8, ~16, ~32, ~64, ~128]);
```