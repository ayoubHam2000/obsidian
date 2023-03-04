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
let empty = [];// [] is an empty array with no elements.
empty.length // => 0

// Arrays and objects can hold other arrays and objects:
let points = [ {x: 0, y: 0}, {x:1,y:1} ];
let data = {  
	trial1: [[1,2], [3,4]],
	trial2: [[2,3], [4,5]]
	};


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
```

