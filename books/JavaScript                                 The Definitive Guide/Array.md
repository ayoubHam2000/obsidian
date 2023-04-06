- JavaScript arrays are zero-based and use 32-bit indexes: the index of the first element is 0, and the highest possible index is 4294967294 (2^32−2), for a maximum array size of 4,294,967,295 elements
- Arrays inherit properties from Array.prototype, which defines a rich set of array manipulation methods
- ES6 introduces a set of new array classes known collectively as “typed arrays.” Unlike regular JavaScript arrays, typed arrays have a fixed length and a fixed numeric element type. They offer high performance and byte-level access to binary data and are covered in §11.2.
- If an array literal contains multiple commas in a row, with no value between, the array is sparse. Array elements for which values are omitted do not exist but appear to be undefined if you query them:

## Create

• Array literals
• The ... spread operator on an iterable object
• The Array() constructor
• The Array.of() and Array.from() factory methods

```js
let a = [1, 2, 3];
let b = [0, ...a, 4]; // b == [0, 1, 2, 3, 4] “spread operator“
```

- The spread operator works on any iterable object. (Iterable objects are what the for/of loop iterates over; we first saw them in §5.4.4, and we’ll see much more about them in Chapter 12.) Strings are iterable, so you can use a spread operator to turn any string into an array of single-character strings
```js
let digits = [..."0123456789ABCDEF"];
digits // => ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]

//remove duplicate elements from an array
let letters = [..."hello world"];
[...new Set(letters)]
// => ["h","e","l","o"," ","w","r","d"]
```

```js
//array of size 10
let a = new Array(10);
//array of two elements
let b = new Array(10, 20)

Array.of() // => []; returns empty array with no arguments
Array.of(10) // => [10]; can create arrays with a single numeric argument 
Array.of(1,2,3) // => [1, 2, 3]

let copy = Array.from(original);
let truearray = Array.from(arraylike);
```

- Array.from() also accepts an optional second argument. If you pass a function as the second argument, then as the new array is being built, each element from the source object will be passed to the function you specify, and the return value of the function will be stored in the array instead of the original value.

## Reading and Writing Array Elements

```js
let a = []
a[5] = 4
a.length //length = 6

// All arrays are objects, and you can create properties of any name on them
let b = []
b["l"] = 7
b.length //length = 0

//Note that you can index an array using numbers that are negative or that are not integers. When you do this, the number is converted to a string

let c = []
c[1.040] = 8 //create a property names "1.04"
c["1.040"] = 8 //create a property names "1.040"
```

## Sparse Array

- If the array is sparse, the value of the length property is greater than the number of elements.

## Array Length

```js
a = [1,2,3,4,5]; // Start with a 5-element array.
a.length = 3; // a is now [1,2,3].
a.length = 0; // Delete all elements. a is []
a.length = 5; // Length is 5, but no elements, like new Array(5)
```

## Methods

```js
a = []
a.push([1, 2]) //push() method to add one or more values to the end of an array


// unshift() method to insert a value at the beginning of an array
// pop() removes the last element of the array
// shift() method removes and returns the first element of the array
// splice() is the general-purpose method for inserting, deleting, or replacing array elements. It alters the length property and shifts array elements to higher or lower indexes as needed.
// forEach() forEach() is aware of sparse arrays and does not invoke your function for elements that are not there.


//The push() method does not flatten an array you pass to it, but if you want to push all of the elements from one array onto another array, you can use the spread operator (§8.3.4) to flatten it explicitly: 
a.push(...values);



// There is one feature of unshift() that is worth calling out because you may find it surprising. When passing multiple arguments to unshift(), they are inserted all at once, which means that they end up in the array in a different order than they would be if you inserted them one at a time:

let a = []; // a == []
a.unshift(1) // a == [1]
a.unshift(2) // a == [2, 1]
a = []; // a == []
a.unshift(1,2)  // a == [1, 2]
 


```

- The methods described in this section iterate over arrays by passing array elements: all of these methods accept a function as their first argument and invoke that function once for each element (or some elements) of the array. If the array is sparse, the function you pass is not invoked for nonexistent elements. In most cases, the function you supply is invoked with three arguments: the value of the array element, the index of the array element, and the array itself. Often, you only need the first of these argument values and can ignore the second and third values

```js
let data = [1,2,3,4,5]
data.forEach(function(v, i, a) { a[i] = v + 1; }); // data == [2,3,4,5,6]

//For the map() method, however, the function you pass should return a value. Note that map() returns a new array: it does not modify the array it is invoked on. If that array is sparse, your function will not be called for the missing elements, but the returned array will be sparse in the same way as the original array: it will have the same length and the same missing elements.

let a = [1, 2, 3];
a.map(x => x*x) // => [1, 4, 9]: the function takes input x and returns x*x

a.filter((x,i) => i%2 === 0) // => [5, 3, 1]; every other value
// Note that filter() skips missing elements in sparse arrays and that its return value is always dense. To close the gaps in a sparse array, you can do this:

let dense = sparse.filter(() => true);

// And to close gaps and remove undefined and null elements, you can use filter, like this:
a = a.filter(x => x !== undefined && x !== null);

let a = [1,2,3,4,5];
a.every(x => x < 10) // => true: all values are < 10.
a.every(x => x % 2 === 0) // => false: not all values are even.


let a = [1,2,3,4,5];
a.some(x => x%2===0) // => true; a has some even numbers.
a.some(isNaN) // => false; a has no non-numbers.

//reduce()
let a = [1,2,3,4,5];
a.reduce((x,y) => x+y, 0) // => 15; the sum of the values
a.reduce((x,y) => x*y, 1) // => 120; the product of the values
a.reduce((x,y) => (x > y) ? x : y) // => 5; the largest of the values
/*
* reduce() takes two arguments. The first is the function that performs the reduction operation. The second (optional) argument is an initial value to pass to the function.
* 
* When you invoke reduce() like this with no initial value, it uses the first element of the array as the initial value
* 
* Calling reduce() on an empty array with no initial value argument causes a TypeError. If you call it with only one value—either an array with one element and no initial value or an empty array and an initial value—it simply returns that one value without ever calling the reduction function.
*/


// reduceRight() works just like reduce(), except that it processes the array from highest index to lowest (right-to-left), rather than from lowest to highest. You might want to do this if the reduction operation has right-to-left associativity, for example:
// Compute 2^(3^4). Exponentiation has right-to-left precedence
let a = [2, 3, 4];
a.reduceRight((acc,val) => Math.pow(val,acc)) // => 2.4178516392292583e+24

//-----------------------------------------------

//When called with no arguments, flat() flattens one level of nesting
let a = [1, [2, [3, [4]]]];
a.flat(1) // => [1, 2, [3, [4]]]
a.flat(2) // => [1, 2, 3, [4]]
a.flat(3) // => [1, 2, 3, 4]
a.flat(4) // => [1, 2, 3, 4]

// The flatMap() method works just like the map() method (see “map()” on page 166) except that the returned array is automatically flattened as if passed to flat(). That is, calling a.flatMap(f) is the same as (but more efficient than) a.map(f).flat():

let phrases = ["hello world", "the definitive guide"];
let words = phrases.flatMap(phrase => phrase.split(" "));
words // => ["hello", "world", "the", "definitive", "guide"];

[-2, -1, 1, 2].flatMap(x => x < 0 ? [] : Math.sqrt(x)) // => [1, 2**0.5]


//-----------------------------------------------


let a = [1,2,3];
a.concat(4, 5) // => [1,2,3,4,5]
a.concat([4,5],[6,7]) // => [1,2,3,4,5,6,7];
arrays are flattened a.concat(4, [5,[6,7]]) // => [1,2,3,4,5,[6,7]]; but not nested arrays
a // => [1,2,3]; the original array is unmodified
// Note that concat() makes a new copy of the array it is called on. In many cases, this is the right thing to do, but it is an expensive operation. If you find yourself writing code like a = a.concat(x), then you should think about modifying your array in place with push() or splice() instead of creating a new one.

```
- The `find()` and `findIndex()` methods are like filter() in that they iterate through your array looking for elements for which your predicate function returns a truthy value. Unlike filter(), however, these two methods stop iterating the first time the predicate finds an element. When that happens, find() returns the matching element, and findIndex() `returns the index of the matching element`. `If no matching element is found, find() returns undefined and findIndex() returns -1:`

```js
//slice()

//The slice() method returns a slice, or subarray, of the specified array. Its two arguments specify the start and end of the slice to be returned. The returned array contains the element specified by the first argument and all subsequent elements up to, but not including, the element specified by the second argument. If only one argument is specified, the returned array contains all elements from the start position to the end of the array. If either argument is negative, it specifies an array element relative to the length of the array. An argument of –1, for example, specifies the last element in the array, and an argument of –2 specifies the element before that one. Note that slice() does not modify the array on which it is invoked

let a = [1,2,3,4,5];
a.slice(0,3); // Returns [1,2,3]
a.slice(3); // Returns [4,5]
a.slice(1,-1); // Returns [2,3,4]
a.slice(-3,-2); // Returns [3]

//splice()

// The first argument to splice() specifies the array position at which the insertion and/or deletion is to begin. The second argument specifies the number of elements that should be deleted from (spliced out of) the array.
// splice() returns an array of the deleted elements, or an empty array if no elements were deleted
// The first two arguments to splice() specify which array elements are to be deleted. These arguments may be followed by any number of additional arguments that specify elements to be inserted into the array, starting at the position specified by the first argument.
let a = [1,2,3,4,5];
a.splice(2,0,"a","b") // => []; a is now [1,2,"a","b",3,4,5]
a.splice(2,2,[1,2],3) // => ["a","b"]; a is now [1,2,[1,2],3,3,4,5]



//fill()

let a = new Array(5); // Start with no elements and length 5
a.fill(0) // => [0,0,0,0,0]; fill the array with zeros
a.fill(9, 1) // => [0,9,9,9,9]; fill with 9 starting at index 1
a.fill(8, 2, -1) // => [0,9,8,8,9]; fill with 8 at indexes 2, 3


//copyWithin() 

// copies a slice of an array to a new position within the array. It modifies the array in place and returns the modified array, but it will not change the length of the array. The first argument specifies the destination index to which the first element will be copied. The second argument specifies the index of the first element to be copied. If this second argument is omitted, 0 is used. The third argument specifies the end of the slice of elements to be copied. If omitted, the length of the array is used.


let a = [1,2,3,4,5];
a.copyWithin(1) // => [1,1,2,3,4]: copy array elements up one
a.copyWithin(2, 3, 5) // => [1,1,3,4,4]: copy last 2 elements to index 2 
a.copyWithin(0, -2) // => [4,4,3,4,4]: negative offsets work, too

```

## Array Searching and Sorting Methods

Arrays implement `indexOf()`, `lastIndexOf()`, and `includes()` methods that are similar to the same-named methods of strings. There are also `sort()` and `reverse()` methods for reordering the elements of an array. These methods are described in the subsections that follow

```js
let a = [0,1,2,1,0];
a.indexOf(1) // => 1: a[1] is 1
a.lastIndexOf(1) // => 3: a[3] is 1
a.indexOf(3) // => -1: no element has value 3

// indexOf() and lastIndexOf() take an optional second argument that specifies the array index at which to begin the search. If this argument is omitted, indexOf() starts at the beginning and lastIndexOf() starts at the end. Negative values are allowed for the second argument and are treated as an offset from the end of the array, as they are for the slice() method: a value of –1, for example, specifies the last element of the array.

// Note that strings have indexOf() and lastIndexOf() methods that work like these array methods, except that a negative second argument is treated as zero.

// This means that indexOf() will not detect the NaN value in an array, but includes() will:

let a = [1,true,3,NaN];
a.includes(true)// => true
a.includes(2) // => false
a.includes(NaN) // => true
a.indexOf(NaN) // -1; indexOf can't find NaN


//sort()

//sort() sorts the elements of an array in place and returns the sorted array. When sort() is called with no arguments, it sorts the array elements in alphabetical order (temporarily converting them to strings to perform the comparison, if necessary):
// If an array contains undefined elements, they are sorted to the end of the array.

let a = [33, 4, 1111, 222];
a.sort(); // a == [1111, 222, 33, 4]; alphabetical order
a.sort(function(a,b) { // Pass a comparator function
	return a-b; // Returns < 0, 0, or > 0, depending on order
}); // a == [4, 33, 222, 1111]; numerical order
a.sort((a,b) => b-a); // a == [1111, 222, 33, 4]; reverse numerical order


// reverse()

let a = [1,2,3];
a.reverse(); // a == [3,2,1]
```

## Array to String Conversions

```js
JSON.stringify();

let a = [1, 2, 3]
a.join() // => 1, 2, 3
a.join(" ") // => "1 2 3"
a.join("") // => "123"
let b = new Array(10); // An array of length 10 with no elements
b.join("-") // => "---------": a string of 9 hyphens

[1,2,3].toString() // => "1,2,3"
["a", "b", "c"].toString() // => "a,b,c"
[1, [2,"c"]].toString() // => "1,2,c"

toLocaleString()

```

## Array-Like Objects

- It is often perfectly reasonable to treat any object with a numeric length property and corresponding non-negative integer properties as a kind of array.
- you can still iterate through them with the same code you’d use for a true array. It turns out that many array algorithms work just as well with arraylike objects as they do with real arrays. This is especially true if your algorithms treat the array as read-only or if they at least leave the array length unchanged.
- Since array-like objects do not inherit from Array.prototype, you cannot invoke array methods on them directly. You can invoke them indirectly using the Function.call method, however
```js
let a = {"0": "a", "1": "b", "2": "c", length: 3}; // An array-like object 
Array.prototype.join.call(a, "+") // => "a+b+c"
Array.prototype.map.call(a, x => x.toUpperCase()) // => ["A","B","C"] 
Array.prototype.slice.call(a, 0) // => ["a","b","c"]: true array copy 
Array.from(a) // => ["a","b","c"]: easier array copy
```

## Strings as Arrays

- The fact that strings behave like arrays also means, however, that we can apply generic array methods to them. For example:
- Keep in mind that strings are immutable values, so when they are treated as arrays, they are read-only arrays. Array methods like push(), sort(), reverse(), and splice() modify an array in place and do not work on strings. Attempting to modify a string using an array method does not, however, cause an error: it simply fails silently.
```js
Array.prototype.join.call("JavaScript", " ") // => "J a v a S c r i p t"
```


## Other

```js
let a [1, 2, 3]
delete a[2]; //a now has no element at index 2


// If you want to use a for/of loop for an array and need to know the index of each array element, use the entries() method of the array, along with destructuring assignment, like this:
let everyother = "";
for(let [index, letter] of letters.entries()){
	if (index % 2 === 0)
		everyother += letter; // letters at even indexes
}



Array.isArray([])// => true
Array.isArray({}) // => false

```