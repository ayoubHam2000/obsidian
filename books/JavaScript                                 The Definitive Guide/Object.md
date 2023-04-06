- An object is a composite value: it aggregates multiple values (primitive values or other objects) and allows you to store and retrieve those values by name
- JavaScript object also inherits the properties of another object, known as its “prototype.”
- A property has a name and a value. A property name may be any string, including the empty string (or any Symbol).
- In addition to its name and value, each property has three property attributes:
	- The writable attribute specifies whether the value of the property can be set.
	- The enumerable attribute specifies whether the property name is returned by a for/in loop.
	- The configurable attribute specifies whether the property can be deleted and whether its attributes can be altered.

## Creating Object

- Objects can be created with object literals, with the new keyword, and with the Object.create() function
```js
let l = {a:1}
let o = new Object()
```
- All objects created by object literals have the same `prototype object`, and we can refer to this prototype object in JavaScript code as `Object.prototype`. **Objects created using the new keyword and a constructor invocation use the value of the prototype property of the constructor function as their prototype.** So the object created by new Object() inherits from Object.prototype, just as the object created by {} does. Similarly, the object created by new Array() uses Array.prototype as its prototype, and the object created by new Date() uses Date.prototype as its prototype.
- You can pass null to create a new object that does not have a prototype, but if you do this, the newly created object will not inherit anything, not even basic methods like toString() (which means it won’t work with the + operator either):
```js
let o2 = Object.create(null);

* To obtain the value of a property, use the dot (.) or square bracket ([]) operators

* When using square bracket notation, we’ve said that the expression inside the square brackets must evaluate to a string or a value that can be converted to a string or to a Symbol

* JavaScript objects are associative arrays, and this section explains why that is important.

* Since you can’t know the property names when you write the program, there is no way you can use the . operator to access the properties of the portfolio object. You can use the [] operator, however, because it uses a string value (which is dynamic and can change at runtime) rather than an identifier (which is static and must be hardcoded in the program) to name the property.

function computeValue(portfolio) {
	let total = 0.0;
	for(let stock in portfolio)
	{
		// For each stock in the portfolio:
		let shares = portfolio[stock];
		// get the number of shares
		let price = getQuote(stock);
		// look up share price
		total += shares * price; 
	}
	return total; 
}

let o = {};
// o inherits object methods from Object.prototype
o.x = 1; // and it now has an own property x.
let p = Object.create(o); // p inherits properties from o and Object.prototype 
p.y = 2;// and has an own property y.
let q = Object.create(p); // q inherits properties from p, o, and...
q.z = 3;// ...Object.prototype and has an own property z.
let f = q.toString(); q.x + q.y
// toString is inherited from Object.prototype // => 3; x and y are inherited from o and p

// Now suppose you assign to the property x of the object o. If o already has an own (non-inherited) property named x, then the assignment simply changes the value of this existing property. Otherwise, the assignment creates a new property named x on the object o. If o previously inherited the property x, that inherited property is now hidden by the newly created own property with the same name.

let a = Object.create({x:4})
let b = Object.create(a)
b.x = 5
```
![[Screen Shot 2023-04-04 at 10.44.20 PM.png|400]]
```js
b.__proto__.x = 99
console.log(a.x) //99
```
- If o inherits a read-only property named x, for example, then the assignment is not allowed.
- There is one exception to the rule that a property assignment either fails or creates or sets a property in the original object. `If o inherits the property x, and that property is an accessor property with a setter method` (see §6.10.6),` then that setter method is called rather than creating a new property x in o`. Note, however, that the setter method is called on the object o, not on the prototype object that defines the.
- In strict mode (§5.6.3), a TypeError is thrown whenever an attempt to set a property fails. Outside of strict mode, these failures are usually silent.

**The rules that specify when a property assignment succeeds and when it fails are intuitive** but difficult to express concisely. An attempt to set a property p of an object o fails in these circumstances:
- o has an own property p that is read-only: it is not possible to set read-only properties.
- o has an inherited property p that is read-only: it is not possible to hide an inherited read-only property with an own property of the same name.
- o does not have an own property p; o does not inherit a property p with a setter method, and o’s extensible attribute (see §14.2) is false. Since p does not already exist in o, and if there is no setter method to call, then p must be added to o. But if o is not extensible, then no new properties can be defined on it.

## Deleting properties

- The delete operator only deletes own properties, not inherited ones. (To delete an inherited property, you must delete it from the prototype object in which it is defined. Doing this affects every object that inherits from that prototype.)
-  delete does not remove properties that have a configurable attribute of false

## Testing Properties

- set—to check whether an object has a property
with a given name. You can do this with the `in operator`, with the `hasOwnProperty()` and `propertyIsEnumerable()` methods, or `simply by querying the property`

```js
let o = { x: 1 };
"x" in o // => true: o has an own property "x" 
"y" in o // => false: o doesn't have a property "y"
"toString" in o // => true: o inherits a toString property

let o = { x: 1 }; 
o.hasOwnProperty("x") // => true: o has an own property x
o.hasOwnProperty("y") // => false: o doesn't have a property y
o.hasOwnProperty("toString") // => false: toString is an inherited property

//The propertyIsEnumerable(). It returns true only if the named property is an own property and its enumerable attribute is true. Certain built-in properties are not enumerable.

let o = { x: 1 };
o.propertyIsEnumerable("x") // => true: o has an own enumerable property x
o.propertyIsEnumerable("toString") // => false: not an own property 
Object.prototype.propertyIsEnumerable("toString") // => false: not enumerable

//There is one thing the in operator can do that the simple property access technique shown here cannot do. in can distinguish between properties that do not exist and properties that exist but have been set to undefined. Consider this code:

let o = { x: undefined }; // Property is explicitly set to undefined
o.x !== undefined // => false: property exists but is undefined
o.y !== undefined // => false: property doesn't even exist
"x" in o // => true: the property exists
"y" in o // => false: the property doesn't exist
delete o.x; // Delete the property x
"x" in o // => false: it doesn't exist anymore
```

**get an array of property names**

- `Object.keys()` returns an array of the names of the enumerable own properties of an object. It does not include non-enumerable properties, inherited properties, or properties whose name is a Symbol (see §6.10.3).
- `Object.getOwnPropertyNames()` works like Object.keys() but returns an array of the names of non-enumerable own properties as well, as long as their names are strings.
- `Object.getOwnPropertySymbols()` returns own properties whose names are Symbols, whether or not they are enumerable.
- `Reflect.ownKeys()` returns all own property names, both enumerable and nonenumerable, and both string and Symbol. (See §14.6.)

## Extending Object

- `Object.assign()` expects two or more objects as its arguments. It modifies and returns the first argument, which is the target object, but does not alter the second or any subsequent arguments, which are the source objects. For each source object, it copies the enumerable own properties of that object (including those whose names are Symbols) into the target object. It processes the source objects in argument list order so that properties in the first source object override properties by the same name in the target object and properties in the second source object (if there is one) override properties with the same name in the first source object.
- `Object.assign()` copies properties with ordinary property get and set operations, so if a source object has a getter method or the target object has a setter method, they will be invoked during the copy, but they will not themselves be copied.
```js
//One reason to assign properties from one object into another is when you have an object that defines default values for many properties and you want to copy those default properties into another object if a property by that name does not already exist in that object. Using Object.assign() naively will not do what you want:

Object.assign(o, defaults); // overwrites everything in o with defaults
// Instead, what you can do is to create a new object, copy the defaults into it, and then override those defaults with the properties in o:
o = Object.assign({}, defaults, o);

// spread operator
o = {...defaults, ...o};
```

## Object serialization

- Object serialization is the process of converting an object’s state to a string from which it can later be restored. The functions JSON.stringify() and JSON.parse() serialize and restore JavaScript objects.

```js
let o = {x: 1, y: {z: [false, null, ""]}}; // Define a test object let 
s = JSON.stringify(o); //s == '{"x":1,"y":{"z":[false,null,""]}}'
let p = JSON.parse(s); // p == {x: 1, y: {z: [false, null, ""]}}
```

- JSON syntax is a subset of JavaScript syntax, and it cannot represent all JavaScript values. Objects, arrays, strings, finite numbers, true, false, and null are supported and can be serialized and restored. NaN, Infinity, and -Infinity are serialized to null. Date objects are serialized to ISO-formatted date strings (see the Date.toJSON() function), but JSON.parse() leaves these in string form and does not restore the original Date object

## Object Methods

- toString()
```js
// Because this default method does not display much useful information, many classes define their own versions of toString().
let point = { 
	x: 1, 
	y: 2,
	toString: function() { return `(${this.x}, ${this.y})`; } 
};
```
- toLocaleString()
	- The `toLocaleString()` method is a built-in function in JavaScript that converts a date or number into a string representation using the conventions of the specified locale.

- valueOf()
	- The valueOf() method is much like the toString() method, but it is called when JavaScript needs to convert an object to some primitive type other than a string— typically, a number

- toJSON()
	- Object.prototype does not actually define a toJSON() method, but the JSON.string ify() method (see §6.8) looks for a toJSON() method on any object it is asked to serialize. If this method exists on the object to be serialized, it is invoked, and the return value is serialized, instead of the original object. The Date class (§11.4) defines a toJSON() method that returns a serializable string representation of the date.
	
```js
let point = { 
	x: 1, 
	y: 2,
	toString: function() { return `(${this.x}, ${this.y})`; }, 
	toJSON: function() { return this.toString(); }
}; 
JSON.stringify([point]) // => '["(1, 2)"]'

```


## Shorthand Properties

```js
let x = 1, y = 2;
let o = { x, y }; instead of let o = { x: x, y: y};
o.x + o.y // => 3
```

## Computed Property Names

```js
const PROPERTY_NAME = "p1";
function computePropertyName() { return "p" + 2; }

let p = { 
	[PROPERTY_NAME]: 1,
	[computePropertyName()]: 2
}; 

p.p1 + p.p2 // => 3
```

## Symbols as Property Names

```js
const extension = Symbol("my extension symbol");
let o = { 
	[extension]: { /* extension data stored in this object */ }
};

o[extension].x = 0; // This won't conflict with other properties of o
```

- The point of Symbols is not security, but to define a safe extension mechanism for JavaScript objects. If you get an object from third-party code that you do not control and need to add some of your own properties to that object but want to be sure that your properties will not conflict with any properties that may already exist on the object, you can safely use Symbols as your property names. If you do this, you can also be confident that the third-party code will not accidentally alter your symbolically named properties. (That third-party code could, of course, use Object.getOwn PropertySymbols() to discover the Symbols you’re using and could then alter or delete your properties. This is why Symbols are not a security mechanism.)

## Spread Operator

In ES2018 and later, you can copy the properties of an existing object into a new object using the “spread operator” ... inside an object literal:
```js
let position = { x: 0, y: 0 };
let dimensions = { width: 100, height: 75 };
let rect = { ...position, ...dimensions };
rect.x + rect.y + rect.width + rect.height // => 175
```
- If the object that is spread and the object it is being spread into both have a property with the same name, then the value of that property will be the one that comes last:
- Also note that the spread operator only spreads the own properties of an object, not any inherited ones:
- Finally, it is worth noting that, although the spread operator is just three little dots in your code, it can represent a substantial amount of work to the JavaScript interpreter. If an object has n properties, the process of spreading those properties into another object is likely to be an O(n) operation. This means that if you find yourself using ... within a loop or recursive function as a way to accumulate data into one large object, you may be writing an inefficient O(n^2) algorithm that will not scale well as n gets larger.

## Shorthand Methods

```js
...

const METHOD_NAME = "m";
const symbol = Symbol();
let weirdMethods = { 
	"method With Spaces"(x) { return x + 1; },
	[METHOD_NAME](x) { return x + 2; },
	[symbol](x) { return x + 3; 
	}
};
weirdMethods["method With Spaces"](1) // => 2
weirdMethods[METHOD_NAME](1) // => 3
weirdMethods[symbol](1) // => 4

```

## Property Getters and Setters
- If a property has both a getter and a setter method, it is a read/write property. If it has only a getter method, it is a read-only property. And if it has only a setter method, it is a write-only property
```js
let p = {
	// x and y are regular read-write data properties.
	x: 1.0,
	y: 1.0,
	// r is a read-write accessor property with getter and setter.
	// Don't forget to put a comma after accessor methods.
	get r() { return Math.hypot(this.x, this.y); },
	set r(newvalue) { 
		let oldvalue = Math.hypot(this.x, this.y);
		let ratio = newvalue/oldvalue;
		this.x *= ratio; this.y *= ratio;
		},
	// theta is a read-only accessor property with getter only.
	get theta() { return Math.atan2(this.y, this.x); }
};
p.r // => Math.SQRT2
p.theta // => Math.PI / 4

```