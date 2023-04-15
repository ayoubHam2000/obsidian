## Set And Map

#### Set

```js
let s = new Set();
let t = new Set([1, s]);
// any iterable object (including other Set objects) is allowed:

let t = new Set(s);
let unique = new Set("Mississippi"); // 4 elements: "M", "i", "s", and "p"
unique.size //=> 4
unique.add([1,2,3]);
unique.add(true);
unique.delete(true); //delete by value in case of an object delete by reference return true if deleted
unique.delete([1,2,3]) //false
unique.delete(true) //true
unique.clear();
```
- the JavaScript Set class always remembers the order that elements were inserted in, and it always uses this order when you iterate a set: the first element inserted will be the first one iterated (assuming you haven’t deleted it first), and the most recently inserted element will be the last one iterated.

#### Map

```js
let m = new Map([
	["1", "Ha"],
	[1, "New"]
]);

let copy = new Map(n); // A new map with the same keys and values as map n
let o = { x: 1, y: 2}; // An object with two properties
let p = new Map(Object.entries(o)); // Same as new map([["x", 1], ["y", 2]])

let m = new Map(); // Start with an empty
map m.size // => 0: empty maps have no keys
m.set("one", 1); // Map the key "one" to the value 1
m.set("two", 2); // And the key "two" to the value 2.
m.size // => 2: the map now has two keys
m.get("two") // => 2: return the value associated with key "two"
m.get("three") // => undefined: this key is not in the set
m.set("one", true); // Change the value associated with an existing key
m.size // => 2: the size doesn't change
m.has("one") // => true: the map has a key "one"
m.has(true) // => false: the map does not have a key true
m.delete("one") // => true: the key existed and deletion succeeded
m.size // => 1
m.delete("three") // => false: failed to delete a nonexistent key
m.clear(); // Remove all keys and values from the map

// Like the add() method of Set, the set() method of Map can be chained, which allows maps to be initialized without using arrays of arrays

let m = new Map().set("one", 1).set("two", 2).set("three", 3);
m.size
m.get("two") // => 2



for(let [key, value] of m) {}


[...m.keys()] // => ["x", "y"]: just the keys
[...m.values()] // => [1, 2]: just the values
[...m.entries()] // => [["x", 1], ["y", 2]]: same as [...m]

m.forEach((value, key) => { // note value, key NOT key, value
	// On the first invocation, value will be 1 and key will be "x"
	// On the second invocation, value will be 2 and key will be "y"
});

- It may seem strange that the value parameter comes before the key parameter in the code above, since with for/of iteration, the key comes first. As noted at the start of this section, you can think of a map as a generalized array in which integer array indexes are replaced with arbitrary key values
```

#### WeakMap & WeakSet

- The WeakMap class is a variant (but not an actual subclass) of the Map class that does not prevent its key values from being garbage collected
- WeakMap keys must be objects or arrays; primitive values are not subject to garbage collection and cannot be used as keys.
- WeakMap implements only the get(), set(), has(), and delete() methods. In particular, WeakMap is not iterable and does not define keys(), values(), or forEach(). If WeakMap was iterable, then its keys would be reachable and it wouldn’t be weak.
- WeakSet objects differ from Set objects in the same ways that WeakMap objects differ from Map objects

## Typed Arrays and Binary Data

- Regular JavaScript arrays can have elements of any type and can grow or shrink dynamically. JavaScript implementations perform lots of optimizations so that typical uses of JavaScript arrays are very fast.
- You must specify the length of a typed array when you create it, and that length can never change.
- The elements of a typed array are always initialized to 0 when the array is created.![[Screen Shot 2023-04-12 at 5.11.16 PM.png]]
- Uint8ClampedArray is a special-case variant on Uint8Array. Both of these types hold unsigned bytes and can represent numbers between 0 and 255. With Uint8Array, if you store a value larger than 255 or less than zero into an array element, it “wraps around,” and you get some other value. This is how computer memory works at a low level, so this is very fast. Uint8ClampedArray does some extra type checking so that, if you store a value greater than 255 or less than 0, it “clamps” to 255 or 0 and does not wrap around. (This clamping behavior is required by the HTML \<canvas\> element’s low-level API for manipulating pixel colors.)
- Each of the typed array constructors has a BYTES_PER_ELEMENT property with the value 1, 2, 4, or 8, depending on the type.
```js
let bytes = new Uint8Array(1024);
let matrix = new Float64Array(9);
let point = new Int16Array(3);
let rgba = new Uint8ClampedArray(4);
let sudoku = new Int8Array(81);

let white = Uint8ClampedArray.of(255, 255, 255, 0); // RGBA opaque white
// Recall that the Array.from() factory method expects an array-like or iterable object as its first argument. The same is true for the typed array variants, except that the iterable or array-like object must also have numeric elements
```
- When you create a new typed array from an existing array, iterable, or array-like object, the values may be truncated in order to fit the type constraints of your array. There are no warnings or errors when this happens

```js
Uint8Array.of(1.23, 2.99, 45000) // => new Uint8Array([1, 2, 200])
```

- the ArrayBuffer type. An ArrayBuffer is an opaque reference to a chunk of memory.
```js
let buffer = new ArrayBuffer(1024*1024);
buffer.byteLength // => 1024*1024; one megabyte of memory
```

- The `ArrayBuffer` class does not allow you to `read` or `write` any of the bytes that you have allocated. But `you can create typed arrays that use the buffer’s memory and that do allow you to read and write that memory`. To do this, call the typed array constructor with an ArrayBuffer as the first argument, a byte `offset` within the array buffer as the second argument, and the `array length `(in elements, not in bytes) as the third argument. The second and third arguments are optional. If you omit both, then the array will use all of the memory in the array buffer. If you omit only the length argument, then your array will use all of the available memory between the start position and the end of the array. One more thing to bear in mind about this form of the typed array constructor: arrays must be memory aligned, so if you specify a byte offset, the value should be a multiple of the size of your type. The Int32Array() constructor requires a multiple of four, for example, and the Float64Array() requires a multiple of eight.
```js
let asbytes = new Uint8Array(buffer); // Viewed as bytes
let asints = new Int32Array(buffer); // Viewed as 32-bit signed ints
let lastK = new Uint8Array(buffer, 1023*1024); // Last kilobyte as bytes
let ints2 = new Int32Array(buffer, 1024, 256); // 2nd kilobyte as 256 integers
```

- These four typed arrays offer four different views into the memory represented by the ArrayBuffer. It is important to understand that all typed arrays have an underlying ArrayBuffer, even if you do not explicitly specify one. If you call a typed array constructor without passing a buffer object, a buffer of the appropriate size will be automatically created
- The reason to work directly with ArrayBuffer objects is that sometimes you may want to have multiple typed array views of a single buffer.
- using Uint8Array() instead of Array() makes the code run more than four times faster and use eight times less memory in my testing.
- Typed arrays are not true arrays, but they re-implement most array methods, so you can use them pretty much just like you’d use regular arrays:
```js
let ints = new Int16Array(10); // 10 short integers 
ints.fill(3).map(x=>x*x).join("") // => "9999999999"
```
- Remember that typed arrays have fixed lengths, so the length property is read-only, and methods that change the length of the array (such as push(), pop(), unshift(), shift(), and splice()) are not implemented for typed arrays.
- Methods that alter the contents of an array without changing the length (such as sort(), reverse(), and fill()) are implemented. 
- Methods like map() and slice() that return new arrays return a typed array of the same type as the one they are called on.


- typed arrays also implement a few methods of their own.
```js
//set()

let bytes = new Uint8Array(1024); // A 1K buffer
let pattern = new Uint8Array([0,1,2,3]); // An array of 4 bytes 
bytes.set(pattern); // Copy them to the start of another byte array
bytes.set(pattern, 4); // Copy them again at a different offset 
bytes.set([0,1,2,3], 8); // Or just copy values direct from a regular array 
bytes.slice(0, 12) // => new Uint8Array([0,1,2,3,0,1,2,3,0,1,2,3])

//subarray

let ints = new Int16Array([0,1,2,3,4,5,6,7,8,9]);
let last3 = ints.subarray(ints.length-3, ints.length);
last3[0]

last3.buffer // The ArrayBuffer object for a typed array
last3.buffer === ints.buffer // => true: both are views of the same buffer 
last3.byteOffset // => 14: this view starts at byte 14 of the buffer 
last3.byteLength // => 6: this view is 6 bytes (3 16-bit ints) long
last3.buffer.byteLength // => 20: but the underlying buffer has 20 bytes

a.length * a.BYTES_PER_ELEMENT === a.byteLength // => true


let bytes = new Uint8Array(1024); // 1024 bytes
let ints = new Uint32Array(bytes.buffer); // or 256 integers
let floats = new Float64Array(bytes.buffer); // or 128 doubles
// Another approach is to create an initial typed array, then use the buffer of that array to create other views
```

- `subarray()` takes the same arguments as the slice() method and seems to work the same way. `But there is an important difference. slice() returns the specified elements in a new, independent typed array that does not share memory with the original array. subarray() does not copy any memory; it just returns a new view of the same underlying values:`

---
- On little-endian systems, the bytes of a number are arranged in an ArrayBuffer from least significant to most significant. On big-endian platforms, the bytes are arranged from most significant to least significant. You can determine the endianness of the underlying platform with code like this
```js
// If the integer 0x00000001 is arranged in memory as 01 00 00 00, then
// we're on a little-endian platform. On a big-endian platform, we'd get
// bytes 00 00 00 01 instead.
let littleEndian = new Int8Array(new Int32Array([1]).buffer)[0] === 1;
```

- Today, the most common CPU architectures are little-endian. Many network protocols, and some binary file formats, require big-endian byte ordering, however. If you’re using typed arrays with data that came from the network or from a file, `you can’t just assume that the platform endianness matches the byte order of the data`. 
- In general, when working with external data, you can use Int8Array and Uint8Array to view the data as an array of individual bytes, `but you should not use the other typed arrays with multibyte word sizes`.
- Instead, you can use the DataView class, which defines methods for reading and writing values from an ArrayBuffer with explicitly specified byte ordering:
```js
let view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);
let int = view.getInt32(0); // Read big-endian signed int from byte 0
int = view.getInt32(4, false); // Next int is also big-endian
int = view.getUint32(8, true); // Next int is little-endian and unsigned 
view.setUint32(8, int, false); // Write it back in big-endian format
```

- DataView defines 10 get methods for each of the 10 typed array classes (excluding `Uint8ClampedArray`). They have names like `getInt16()`, `getUint32()`, `getBigInt64()`, and `getFloat64()`. The first argument is the byte offset.
- DataView also defines 10 corresponding Set methods that write values into the underlying ArrayBuffer. The first argument is the offset at which the value begins. The second argument is the value to write. Each of the methods, except setInt8() and setUint8(), accepts an optional third argument. If the argument is omitted or is false, the value is written in big-endian format with the most significant byte first. If the argument is true, the value is written in little-endian format with the least significant byte first.
- Typed arrays and the DataView class give you all the tools you need to process binary data and enable you to write JavaScript programs that do things like decompressing ZIP files or extracting metadata from JPEG files.


## Pattern Matching with Regular Expressions

```js
let pattern = /s$/;
//Or
let pattern = new RegExp("s$");
```


- As we’ll see, regular expressions can also have one or more flag characters that affect how they work. Flags are specified following the second slash character in RegExp literals, or as a second string argument to the RegExp() constructor
```js
	let pattern = /s$/i;
```

![[Screen Shot 2023-04-12 at 8.08.09 PM.png]]![[Screen Shot 2023-04-12 at 8.08.27 PM.png]]
- A number of punctuation characters have special meanings in regular expressions. They are:
`^ $ . * + ? = ! : | \ / ( ) [ ] { }`
- The meanings of these characters are discussed in the sections that follow. Some of these characters have special meaning only within certain contexts of a regular expression and are treated literally in other contexts.
- A character class matches any one character that is contained within it. Thus, the regular expression /\[abc\]/ matches any one of the letters a, b, or c. Negated character classes can also be defined; these match any character except those contained within the brackets. A negated character class is specified by placing a caret (^) as the first character inside the left bracket.
- (And if you want to include an actual hyphen in your character class, simply make it the last character before the right bracket.)
```js
let a = /[abc]/
let b = /[^abc]/
let c = /[a-zA-Z0-9-]/
```
![[Screen Shot 2023-04-12 at 8.23.58 PM.png]]
 (Note that several of these character-class escape sequences match only ASCII characters and have not been extended to work with Unicode characters. You can, however, explicitly define your own Unicode character classes; for example, `/[\u0400-\u04FF]/` matches any one Cyrillic character.)
 - As you’ll see later, the `\b` escape has a special meaning. When used within a character class, however, it represents the backspace character. Thus, to represent a backspace character literally in a regular expression, use the character class with one element: `/[\b]/`.

#### Unicode Character Classes

- In ES2018, if a regular expression uses the `u flag`, then character classes `\p{...} `and its negation `\P{...}` are supported. (As of early 2020, this is implemented by Node, Chrome, Edge, and Safari, but not Firefox.) These character classes are based on properties defined by the Unicode standard, and the set of characters they represent may change as Unicode evolves.
- The `\d` character class matches only ASCII digits. If you want to match one decimal digit from any of the world’s writing systems, you can use `/\p{Decimal_Number}/u.`
- And if you want to match any one character that is not a decimal digit in any language, you can capitalize the p and write `\P{Decimal_Number}`. If you want to match any number-like character, including fractions and roman numerals, you can use `\p{Number}`. Note that “`Decimal_Number`” and “`Number`” are not specific to JavaScript or to regular expression grammar: it is the name of a category of characters defined by the Unicode standard.
```js
let a = `/[\p{Alphabetic}\p{Decimal_Number}\p{Mark}]/u`
```
- (Though to be fully compatible with the complexity of the world’s languages, we really need to add in the categories “Connector_Punctuation” and “Join_Control” as well.) As a final example, the `\p` syntax also allows us to define regular expressions that match characters from a particular alphabet or script:
```JS
let greekLetter = /\p{Script=Greek}/u;
let cyrillicLetter = /\p{Script=Cyrillic}/u;
```

#### Repetition

![[Screen Shot 2023-04-12 at 8.42.01 PM.png]]

#### Non-greedy repetition

- Simply follow the repetition character or characters with a question mark.
- Using non-greedy repetition may not always produce the results you expect. Consider the pattern `/a+b/`, which matches one or more a’s, followed by the letter b. When applied to the string “aaab”, it matches the entire string. Now let’s use the non-greedy version: `/a+?b/`. This should match the letter b preceded by the fewest number of a’s possible. When applied to the same string “aaab”, you might expect it to match only one a and the last letter b. In fact, however, this pattern matches the entire string, just like the greedy version of the pattern. This is because regular expression pattern matching is done by finding the first position in the string at which a match is possible. Since a match is possible starting at the first character of the string, shorter matches starting at subsequent characters are never even considered.

#### Alternation, grouping, and references

- The | character separates alternatives. For example,` /ab|cd|ef/` matches the string “ab” or the string “cd” or the string “ef”.
- Note that alternatives are considered left to right until a match is found. If the left alternative matches, the right alternative is ignored, even if it would have produced a “better” match. Thus, when the pattern `/a|ab/` is applied to the string “ab”, it matches only the first letter.
- `Parentheses`
- Parentheses have several purposes in regular expressions. One purpose is to group separate items into a single subexpression so that the items can be treated as a single unit by `|, *, +, ?, and so on. `For example,` /java(script)?/ `matches “java” followed by the optional “script”. And `/(ab|cd)+|ef/` matches either the string “ef” or one or more repetitions of either of the strings “ab” or “cd”.
- Another purpose of parentheses in regular expressions is to define subpatterns within the complete pattern **For example**, suppose you are looking for one or more lowercase letters followed by one or more digits. You might use the pattern `/[a-z]+ \d+/`. But suppose you only really **care about the digits at the end of each match**. If you put that part of the pattern in parentheses (`/[a-z]+(\d+)/`), you can extract the digits from any matches you find, as explained later.
- A related use of parenthesized subexpressions is to allow you to refer back to a subexpression later in the same regular expression. This is done by following a \ character by a digit or digits.
- The digits refer to the position of the parenthesized subexpression within the regular expression. For example, `\1 `refers back to the first subexpression, and `\3` refers to the third. Note that, because subexpressions can be nested within others, it is the position of the left parenthesis that is counted. In the following regular expression, for example, the nested subexpression `([Ss]cript)` is referred to as `\2`:
```js
let a = /([Jj]ava([Ss]cript)?)\sis\s(fun\w*)/
```
- A reference to a previous subexpression of a regular expression does not refer to the pattern for that subexpression but rather to the text that matched the pattern.
```js
let b = /['"][^'"]*['"]/ //can match 'sdfsd"
//Vs
let a = /(['"])[^'"]*\1/ //can't match 'adasda" but can match 'sdfsd' or "sdfsd"
```
- The `\1` matches whatever the first parenthesized subexpression matched. In this example, it enforces the constraint that the closing quote match the opening quote.
- (It is not legal to use a reference within a character class, so you cannot write:                                 `/(['"])[^\1]*\1/.)`

```js
let a = /([Jj]ava(?:[Ss]cript)?)\sis\s(fun\w*)/

//In this example, the subexpression
(?:[Ss]cript)
// is used simply for grouping, so the ? repetition character can be applied to the group. These modified parentheses do not produce a reference, so in this regular expression, \2 refers to the text matched by (fun\w*).
```
![[Screen Shot 2023-04-12 at 9.26.39 PM.png]]
#### Named Capture Groups

- ES2018 standardizes a new feature that can make regular expressions more selfdocumenting and easier to understand. This new feature is known as “named capture groups” and it allows us to associate a name with each left parenthesis in a regular expression so that we can refer to the matching text by name rather than by number. Equally important: using names allows someone reading the code to more easily understand the purpose of that portion of the regular expression. As of early 2020, this feature is implemented in Node, Chrome, Edge, and Safari, but not yet by Firefox.
```js
/(?<city>\w+) (?<state>[A-Z]{2}) (?<zipcode>\d{5})(?<zip9>-\d{4})?/
```
- If you want to refer back to a named capture group within a regular expression, you can do that by name as well. In the preceding example, we were able to use a regular expression “backreference” to write a RegExp that would match a single- or doublequoted string where the open and close quotes had to match.
```js
/(?<quote>['"])[^'"]*\k<quote>/
```

#### Specifying match position

- `\b `do not specify any characters to be used in a matched string; what they do specify, however, are legal positions at which a match can occur. Sometimes these elements are called `regular expression anchors `because they anchor the pattern to a specific position in the search string. The most commonly used anchor elements are `^`, which ties the pattern to the beginning of the string, and `$`, which anchors the pattern to the end of the string.
```js
/\bJava\b/
/\Bddd\B/
```
- `/\bJava\b/.` The element `\B` anchors the match to a location that is not a word boundary. Thus, the pattern `/\B[Ss]cript/ matches “JavaScript” and “postscript”`, but not `“script” or “Scripting`”.
- (?= and ) characters, it is a lookahead assertion, and it specifies that the enclosed characters must match, without actually matching them.
- For example, to match the name of a common programming language, but only if it is followed by a colon, you could use `/[Jj]ava([Ss]cript)?(?=\:)/`. This pattern matches the word “JavaScript” in “JavaScript: The Definitive Guide”.
- `?!`, it is a negative lookahead assertion, which specifies that the following characters must not match. 
```js
/Java(?! Script)([A-Z]\w*)/ matches “Java” followed by a capital letter and any number of additional ASCII word characters as long as “Java” is not followed by “Script”.
```
![[Screen Shot 2023-04-13 at 12.37.12 AM.png]]

#### Lookbehind Assertions

* ES2018 extends regular expression syntax to allow “lookbehind” assertions. These are like lookahead assertions but refer to text before the current match position. As of early 2020, these are implemented in Node, Chrome, and Edge, but not Firefox or Safari.
* Specify a positive lookbehind assertion with `(?<=...)` and a negative lookbehind assertion with `(?<!...)`.
```js
you could match a 5-digit zip code, but only when it follows a two-letter state abbreviation, like this:

/(?<= [A-Z]{2} )\d{5}/
AB56447 //match 56447
e12345 //not matched

And you could match a string of digits that is not preceded by a Unicode currency symbol with a negative lookbehind assertion like this:

/(?<![\p{Currency_Symbol}\d.])\d+(\.\d+)?/u
```

#### Flags

- The `g` flag indicates that the regular expression is “global”—that is, that we intend to use it to find all matches within a string rather than just finding the first match. This flag does not alter the way that pattern matching is done, but, as we’ll see later, it does alter the behavior of the String match() method and the RegExp exec() method in important ways.
- The `i` flag specifies that pattern matching should be case-insensitive.
- The `m` flag specifies that matching should be done in “multiline” mode. It says that the RegExp will be used with multiline strings and that the ^ and $ anchors should match both the beginning and end of the string and also the beginning and end of individual lines within the string.
- Like the `m` flag, the s flag is also useful when working with text that includes newlines. Normally, a “.” in a regular expression matches any character except a line terminator. When the s flag is used, however, “.” will match any character, including line terminators. The s flag was added to JavaScript in ES2018 and, as of early 2020, is supported in Node, Chrome, Edge, and Safari, but not Firefox.
- The `u` flag stands for Unicode, and it makes the regular expression match full Unicode codepoints rather than matching 16-bit values. This flag was introduced in ES6, and you should make a habit of using it on all regular expressions unless you have some reason not to. If you do not use this flag, then your RegExps will not work well with text that includes emoji and other characters (including many Chinese characters) that require more than 16 bits. Without the u flag, the “.” character matches any 1 UTF-16 16-bit value. With the flag, however, “.” matches one Unicode codepoint, including those that have more than 16 bits. Setting the u flag on a RegExp also allows you to use the new `\u{...}` escape sequence for Unicode character and also enables the `\p{...}` notation for Unicode character classes.
- The `y` flag indicates that the regular expression is “sticky” and should match at the beginning of a string or at the first character following the previous match. When used with a regular expression that is designed to find a single match, it effectively treats that regular expression as if it begins with ^ to anchor it to the beginning of the string. This flag is more useful with regular expressions that are used repeatedly to find all matches within a string. In this case, it causes special behavior of the String match() method and the RegExp exec() method to enforce that each subsequent match is anchored to the string position at which the last one ended.

## String Methods for Pattern Matching

```js
search()

The simplest is search(). This method takes a regular expression argument and returns either the character position of the start of the first matching substring or −1 if there is no match.

"JavaScript".search(/script/ui) // => 4
"Python".search(/script/ui) // => -1

If the argument to search() is not a regular expression, it is first converted to one by passing it to the RegExp constructor. search() does not support global searches; it ignores the g flag of its regular expression argument.
```

```js
replace()

The replace() method performs a search-and-replace operation. It takes a regular expression as its first argument and a replacement string as its second argument. It searches the string on which it is called for matches with the specified pattern. If the regular expression has the g flag set, the replace() method replaces all matches in the string with the replacement string; otherwise, it replaces only the first match it finds. If the first argument to replace() is a string rather than a regular expression, the method searches for that string literally rather than converting it to a regular expression with the RegExp() constructor, as search() does

text.replace(/javascript/gi, "JavaScript");

let quote = /"([^"]*)"/g;
'He said "stop"'.replace(quote, '«$1»') // => 'He said «stop»'
//Or
let quote = /"(?<quotedText>[^"]*)"/g;
'He said "stop"'.replace(quote, '«$<quotedText>»') // => 'He said «stop»'

//"str".replace(pattern, (matchedString, ...listOfSubStringGroup, index, inputString, namedGroupsObjs))
//Example
let pattern = /\d{2}(?<id>\w(?<sub_id>\w{2}))/
"e 58rty".replace(pattern, (matchedString, goupSubString_1, goupSubString_2, index, inputString, namedGroupsObjs) => {
	console.log(matchedString) // => '58rtyc'
	console.log(goupSubString_1) // => 'rty'
	console.log(goupSubString_2) // => 'ty'
	console.log(index) // => 2
	console.log(inputString) // => 'e 58rty'
	console.log(namedGroupsObjs) // => { id: 'rty', sub_id: 'ty' }
});
```

```js
match() //does not modify lastIndex r:!w

It takes a regular expression as its only argument (or converts its argument to a regular expression by passing it to the RegExp() constructor)

"7 plus 8 equals 15".match(/\d+/g) // => ["7", "8", "15"]

If the regular expression does not have the g flag set, match() does not do a global search; it simply searches for the first match. In this nonglobal case, match() still returns an array, but the array elements are completely different. Without the g flag, the first element of the returned array is the matching string, and any remaining elements are the substrings matching the parenthesized capturing groups of the regular expression.

// A very simple URL parsing RegExp
let url = /(\w+):\/\/([\w.]+)\/(\S*)/;
let text = "Visit my blog at http://www.example.com/~david";
let match = text.match(url);
let fullurl, protocol, host, path;
if (match !== null) {
	fullurl = match[0]; // fullurl == "http://www.example.com/~david"
	protocol = match[1]; // protocol == "http"
	host = match[2]; // host == "www.example.com"
	path = match[3]; // path == "~david"
}

If a RegExp has both the g and y flags set, then match() returns an array of matched strings, just as it does when g is set without y. But the first match must begin at the start of the string, and each subsequent match must begin at the character immediately following the previous match.

If the y flag is set without g, then match() tries to find a single match, and, by default, this match is constrained to the start of the string. You can change this default match start position, however, by setting the lastIndex property of the RegExp object at the index at which you want to match at. If a match is found, then this lastIndex will be automatically updated to the first character after the match, so if you call match() again, in this case, it will look for a subsequent match

let vowel = /[aeiou]/y; // Sticky vowel match
"test".match(vowel) // => null: "test" does not begin with a vowel 
vowel.lastIndex = 1; // Specify a different match position
"test".match(vowel)[0] // => "e": we found a vowel at position 1
vowel.lastIndex // => 2: lastIndex was automatically updated
"test".match(vowel) // => null: no vowel at position 2
vowel.lastIndex // => 0: lastIndex gets reset after failed match
```

```js
matchAll() //does not modify lastIndex r:!w

expects a RegExp with the g flag set. Instead of returning an array of matching substrings like match() does, however, it returns an iterator that yields the kind of match objects that match() returns when used with a non-global RegExp

You can set the lastIndex property of a RegExp object to tell matchAll() what index in the string to begin matching at. Unlike the other pattern-matching methods, however, matchAll() never modifies the lastIndex property of the RegExp you call it on, and this makes it much less likely to cause bugs in your code.


// One or more Unicode alphabetic characters between word boundaries
const words = /\b\p{Alphabetic}+\b/gu; // \p is not supported in Firefox yet 
const text = "This is a naïve test of the matchAll() method.";
for(let word of text.matchAll(words)) {
	console.log(`Found '${word[0]}' at index ${word.index}.`);
}
```

```js
split()

"1, 2, 3,\n4, 5".split(/\s*,\s*/) // => ["1", "2", "3", "4", "5"]

Surprisingly, if you call split() with a RegExp delimiter and the regular expression includes capturing groups, then the text that matches the capturing groups will be included in the returned array. For example:

const htmlTag = /<([^>]+)>/; // < followed by one or more non->, followed by > 
"Testing<br/>1,2,3".split(htmlTag) // => ["Testing", "br/", "1,2,3"]
```

#### The RegExp Class

```js
let zipcode = new RegExp("\\d{5}", "g");

// The RegExp() constructor is useful when a regular expression is being dynamically created and thus cannot be represented with the regular expression literal syntax

// Instead of passing a string as the first argument to RegExp(), you can also pass a RegExp object. This allows you to copy a regular expression and change its flags:
let exactMatch = /JavaScript/;
let caseInsensitive = new RegExp(exactMatch, "i");
```

RegExp objects have the following properties:
`source:` This read-only property is the source text of the regular expression: the characters that appear between the slashes in a RegExp literal.
`flags:` This read-only property is a string that specifies the set of letters that represent the flags for the RegExp.
`global:`A read-only boolean property that is true if the g flag is set.
`ignoreCass:`A read-only boolean property that is true if the i flag is set.
`multiline:`A read-only boolean property that is true if the m flag is set.
`dotAll:`A read-only boolean property that is true if the s flag is set.
`unicode:` A read-only boolean property that is true if the u flag is set.
`sticky:` A read-only boolean property that is true if the y flag is set. 
`lastIndex:` This property is a read/write integer. For patterns with the g or y flags, it specifies the character position at which the next search is to begin. It is used by the exec() and test() methods, described in the next two subsections.

```js
test() method //does modify lastIndex r:w

The test() method of the RegExp class is the simplest way to use a regular expression. It takes a single string argument and returns true if the string matches the pattern or false if it does not match.
test() works by simply calling the (much more complicated) exec() method

exec() method //does modify lastIndex r:w

- It takes a single string argument and looks for a match in that string.
- If no match is found, it returns null.
- If a match is found, however, it returns an array just like the array returned by the match() method for non-global searches. Element 0 of the array contains the string that matched the regular expression, and any subsequent array elements contain the substrings that matched any capturing groups.
- The returned array also has named properties: the index property contains the character position at which the match occurred, and the input property specifies the string that was searched, and the groups property, if defined, refers to an object that holds the substrings matching the any named capturing groups


- When exec() is called on a regular expression that has either the global g flag or the sticky y flag set, it consults the lastIndex property of the RegExp object to determine where to start looking for a match. (And if the y flag is set, it also constrains the match to begin at that position.)

- But each time exec() successfully finds a match, it updates the lastIndex property to the index of the character immediately after the matched text. If exec() fails to find a match, it resets lastIndex to 0. This special behavior allows you to call exec() repeatedly in order to loop through all the regular expression matches in a string.


let pattern = /Java/g;
let text = "JavaScript > Java";
let match;
while((match = pattern.exec(text)) !== null) {
	console.log(`Matched ${match[0]} at ${match.index}`);
	console.log(`Next search begins at ${pattern.lastIndex}`);
}

```

```js

let match, positions = [];
while((match = /<p>/g.exec(html)) !== null) {
	// POSSIBLE INFINITE LOOP positions.push(match.index);
}

This code does not do what we want it to. If the html string contains at least one <p> tag, then it will loop forever. The problem is that we use a RegExp literal in the while loop condition. For each iteration of the loop, we’re creating a new RegExp object with lastIndex set to 0, so exec() always begins at the start of the string, and if there is a match, it will keep matching over and over. The solution, of course, is to define the RegExp once, and save it to a variable so that we’re using the same RegExp object for each iteration of the loop.
```

```js
let dictionary = [ "apple", "book", "coffee" ];
let doubleLetterWords = [];
let doubleLetter = /(\w)\1/g;

for(let word of dictionary) {
	if (doubleLetter.test(word)) {
		doubleLetterWords.push(word);
	}
}
doubleLetterWords // => ["apple", "coffee"]: "book" is missing!

Because we set the g flag on the RegExp, the lastIndex property is changed after successful matches, and the test() method (which is based on exec()) starts searching for a match at the position specified by lastIndex. After matching the “pp” in “apple”, lastIndex is 3, and so we start searching the word “book” at position 3 and do not see the “oo” that it contains.
```
- The moral here is that lastIndex makes the RegExp API error prone. So be extra careful when using the g or y flags and looping. And in ES2020 and later, use the String matchAll() method instead of exec() to sidestep this problem since match All() does not modify lastIndex.


## Dates and Times

```JS
let now = new Date(); // The current time
let epoch = new Date(0); // Midnight, January 1st, 1970, GMT
let century = new Date(2100,// Year 2100
0, // January
1, // 1st
2, 3, 4, 5); // 02:03:04.005, local time


Note that when invoked with multiple numbers, the Date() constructor interprets them using whatever time zone the local computer is set to. If you want to specify a date and time in UTC (Universal Coordinated Time, aka GMT), then you can use the Date.UTC(). This static method takes the same arguments as the Date() constructor, interprets them in UTC, and returns a millisecond timestamp that you can pass to the Date() constructor:

let century = new Date(Date.UTC(2100, 0, 1));
let century = new Date("2100-01-01T00:00:00Z"); // An ISO format date

let d = new Date(); // Start with the current date
d.setFullYear(d.getFullYear() + 1); // Increment the year
d.setMonth(d.getMonth() + 3, d.getDate() + 14);

- To get or set the other fields of a Date, replace “FullYear” in the method name with
- “Month”, “Date”, “Hours”, “Minutes”, “Seconds”, or “Milliseconds”.
- Some of the date set methods allow you to set more than one field at a time. setFullYear() and .setUTCFullYear() also optionally allow you to set the month and day-of-month as well. And .setHours() and .setUTCHours() allow you to specify the minutes, seconds, and milliseconds fields in addition to the hours field.
```

- If you print a date (with console.log(century), for example), it will, by default, be printed in your local time zone. If you want to display a date in UTC, you should explicitly convert it to a string with` toUTCString() `or `toISOString()`.
```JS

// JavaScript represents dates internally as integers that specify the number of milliseconds since (or before) midnight on January 1, 1970, UTC time.

d.setTime(d.getTime() + 30000);

//These millisecond values are sometimes called timestamps


// The static Date.now() method returns the current time as a timestamp

let startTime = Date.now();
```

#### High-Resolution Timestamps

- The performance.now() function allows this: it also returns a millisecond-based timestamp, but the return value is not an integer, so it includes fractions of a millisecond. The value returned by perfor mance.now() is not an absolute timestamp like the Date.now() value is. Instead, it simply indicates how much time has elapsed since a web page was loaded or since the Node process started.
- The performance object is part of a larger Performance API that is not defined by the ECMAScript standard but is implemented by web browsers and by Node
```js
const { performance } = require("perf_hooks");
```

#### Formatting and Parsing Date Strings

```js
let d = new Date(2020, 0, 1, 17, 10, 30); // 5:10:30pm on New Year's Day 2020 
d.toString() // => "Wed Jan 01 2020 17:10:30 GMT-0800 (Pacific Standard Time)" 
d.toUTCString() // => "Thu, 02 Jan 2020 01:10:30 GMT"
d.toLocaleDateString() // => "1/1/2020": 'en-US' locale
d.toLocaleTimeString() // => "5:10:30 PM": 'en-US' locale
d.toISOString() // => "2020-01-02T01:10:30.000Z"

//full List
toString()
toUTCString()
toISOString() //The time is expressed in UTC, and this is indicated with the letter “Z”
toLocaleString()
toDateString()
toLocaleDateString()
toTimeString()
toLocaleTimeString()

```

## Error Classes

- One good reason to use an Error object is that, when you create an Error, it captures the state of the JavaScript stack, and if the exception is uncaught, the stack trace will be displayed with the error message, which will help you debug the issue
- Error objects have two properties: `message` and name`,` and a `toString() `method.
- Although it is not part of the ECMAScript standard, Node and all modern browsers also define a `stack property` on Error objects. The value of this property is a multiline string that contains a stack trace of the JavaScript call stack at the moment that the Error object was created
- In addition to the Error class, JavaScript defines a number of subclasses that it uses to signal particular types of errors defined by ECMAScript. These subclasses are `EvalError`, `RangeError`, `ReferenceError`, `SyntaxError`, `TypeError`, and `URIError`.

```js
class HTTPError extends Error {
	constructor(status, statusText, url) {
		super(`${status} ${statusText}: ${url}`);
		this.status = status;
		this.statusText = statusText;
		this.url = url;
	}
	get name() { return "HTTPError"; }
}

let error = new HTTPError(404, "Not Found", "http://example.com/");
error.status // => 404
error.message // => "404 Not Found: http://example.com/" 
error.name // => "HTTPError"

```

## JSON Serialization and Parsing

- This process of converting data structures into streams of bytes or characters is known as serialization (or marshaling or even pickling)
- JSON .... Comments are not allowed and property names must be enclosed in double quotes even when JavaScript would not require this.

```js
JavaScript supports JSON serialization and deserialization with the two functions JSON.stringify()
JSON.parse()

let o = {s: "", n: 0, a: [true, false, null]};
let s = JSON.stringify(o); // s == '{"s":"","n":0,"a":[true,false,null]}'
let copy = JSON.parse(s); // copy == {s: "", n: 0, a: [true, false, null]}
```

- JSON.stringify() also takes an optional third argument that we’ll discuss first
- then you should pass null as the second argument and pass a number or string as the third argument. This third argument tells JSON.stringify() that it should format the data on multiple indented lines. If the third argument is a number, then it will use that number of spaces for each indentation level. If the third argument is a string of whitespace (such as `'\t'`).
- If `JSON.stringify()` is asked to serialize a value that is not natively supported by the JSON format, it looks to see if that value has a `toJSON() method,` and if so, it calls that method and then stringifies the return value in place of the original value. Date objects implement toJSON(): it returns the same string that toISOString() method does.
- If you need to re-create Date objects (or modify the parsed object in any other way), you can pass a `“reviver”` function as the second argument to `JSON.parse()`.
- The return value of the reviver function becomes the new value of the named property. If it returns its second argument, the property will remain unchanged.` If it returns undefined, then the named property will be deleted from the object`

```js
let data = JSON.parse(text, function(key, value) {
	// Remove any values whose property name begins with an underscore
	if (key[0] === "_")
		return undefined;
	// If the value is a string in ISO 8601 date format convert it to a Date.
	if (typeof value === "string" &&
	/^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ$/.test(value)) {
		return new Date(value);
	}
	// Otherwise, return the value unchanged return value;
});
```

- JSON.stringify() also allows its output to be customized by passing an `array` or a `function` as the optional second argument.
- If an array of strings (or numbers—they are converted to strings) is passed instead as the second argument, these are used as the names of object properties (or array elements).
	- Any property whose name is not in the array will be omitted from stringification. Furthermore
	- the returned string will include properties in the same order that they appear in the array (which can be very useful when writing tests).
- The first argument to the replacer function is the object property name or array index of the value within that object, and the second argument is the value itself
	- If the replacer returns undefined or returns nothing at all, then that value (and its array element or object property) is omitted from the stringification.

```js
let text = JSON.stringify(address, ["city","state","country"]);
let json = JSON.stringify(o, (k, v) => v instanceof RegExp ? undefined : v);
```

## The Internationalization API

- The JavaScript internationalization API consists of the three classes Intl.NumberFormat, Intl.DateTimeFormat, and Intl.Collator that allow us to format numbers (including monetary amounts and percentages), dates, and times in locale-appropriate ways and to compare strings in locale-appropriate ways. These classes are not part of the ECMAScript standard but are defined as part of the ECMA402 standard and are wellsupported by web browsers. The Intl API is also supported in Node

#### Formatting Numbers

- The constructor takes two arguments. The first argument specifies the locale that the number should be formatted for and the second is an object that specifies more details about how the number should be formatted
- If the first argument is omitted or undefined, then the system locale (which we assume to be the user’s preferred locale) will be used. If the first argument is a string, it specifies a desired locale, such as "en-US" (English as used in the United States), "fr" (French)
- The first argument can also be an array of locale strings, and in this case, Intl.NumberFormat will choose the most specific one that is well supported.

`style` Specifies the kind of number formatting that is required. The default is "decimal". Specify "percent" to format a number as a percentage or specify "currency" to specify a number as an amount of money.
`currency` If style is "currency", then this property is required to specify the three-letter ISO currency code (such as "USD" for US dollars or "GBP" for British pounds) of the desired currency.
`currencyDisplay` If style is "currency", then this property specifies how the currency is displayed. The default value "symbol" uses a currency symbol if the currency has one. The value "code" uses the three-letter ISO code, and the value "name" spells out the name of the currency in long form.
`useGrouping`  Set this property to false if you do not want numbers to have thousands separators (or their locale-appropriate equivalents).
`minimumIntegerDigits` The minimum number of digits to use to display the integer part of the number. If the number has fewer digits than this, it will be padded on the left with zeros. The default value is 1, but you can use values as high as 21.
`minimumFractionDigits`, `maximumFractionDigits` These two properties control the formatting of the fractional part of the number. If a number has fewer fractional digits than the minimum, it will be padded with zeros on the right. If it has more than the maximum, then the fractional part will be rounded. Legal values for both properties are between 0 and 20. The default minimum is 0 and the default maximum is 3, except when formatting monetary amounts, when the length of the fractional part varies depending on the specified currency.
`minimumSignificantDigits`, `maximumSignificantDigits` These properties control the number of significant digits used when formatting a number, making them suitable when formatting scientific data, for example. If specified, these properties override the integer and fractional digit properties listed previously. Legal values are between 1 and 21.

```js
let euros = Intl.NumberFormat("es", {style: "currency", currency: "EUR"}); euros.format(10) // => "10,00 €": ten euros, Spanish formatting
let pounds = Intl.NumberFormat("en", {style: "currency", currency: "GBP"}); pounds.format(1000) // => "£1,000.00": One thousand pounds, English formatting



let data = [0.05, .75, 1];
let formatData = Intl.NumberFormat(undefined, {
	style: "percent",
	minimumFractionDigits: 1,
	maximumFractionDigits: 1
}).format;
data.map(formatData) // => ["5.0%", "75.0%", "100.0%"]: in en-US locale


let arabic = Intl.NumberFormat("ar", {useGrouping: false}).format; arabic(1234567890) // => "١٢٣٤٥٦٧٨٩٠"

let hindi = Intl.NumberFormat("hi-IN-u-nu-deva").format;
hindi(1234567890) // => "१,२३,४५,६७,८९०"

```

#### Formatting Dates and Times

- The Intl.DateTimeFormat class is a lot like the Intl.NumberFormat class. The Intl.DateTimeFormat() constructor takes the same two arguments that Intl.Num berFormat() does: a locale or array of locales and an object of formatting options. And the way you use an Intl.DateTimeFormat instance is by calling its format() method to convert a Date object to a string.
- The available options are the following. Only specify properties for date and time fields that you would like to appear in the formatted output.

`year` Use "numeric" for a full, four-digit year or "2-digit" for a two-digit abbreviation.
`month` Use "numeric" for a possibly short number like “1”, or "2-digit" for a numeric representation that always has two digits, like “01”. Use "long" for a full name like “January”, "short" for an abbreviated name like “Jan”, and "narrow" for a highly abbreviated name like “J” that is not guaranteed to be unique.
`day` Use "numeric" for a one- or two-digit number or "2-digit" for a two-digit number for the day-of-month.
`weekday` Use "long" for a full name like “Monday”, "short" for an abbreviated name like “Mon”, and "narrow" for a highly abbreviated name like “M” that is not guaranteed to be unique.
`era` This property specifies whether a date should be formatted with an era, such as CE or BCE. This may be useful if you are formatting dates from very long ago or if you are using a Japanese calendar. Legal values are "long", "short", and "narrow".
`hour, minute, second` These properties specify how you would like time displayed. Use "numeric" for a one- or two-digit field or "2-digit" to force single-digit numbers to be padded on the left with a 0.
`timeZone` This property specifies the desired time zone for which the date should be formatted. If omitted, the local time zone is used. Implementations always recognize “UTC” and may also recognize Internet Assigned Numbers Authority (IANA) time zone names, such as “America/Los_Angeles”.
`timeZoneName` This property specifies how the time zone should be displayed in a formatted date or time. Use "long" for a fully spelled-out time zone name and "short" for an abbreviated or numeric time zone.
`hour12` This boolean property specifies whether or not to use 12-hour time. The default is locale dependent, but you can override it with this property.
`hourCycle` This property allows you to specify whether midnight is written as 0 hours, 12 hours, or 24 hours. The default is locale dependent, but you can override the default with this property. Note that hour12 takes precedence over this property. Use the value "h11" to specify that midnight is 0 and the hour before midnight is 11pm. Use "h12" to specify that midnight is 12. Use "h23" to specify that midnight is 0 and the hour before midnight is 23. And use "h24" to specify that midnight is 24.

```js
let d = new Date("2020-01-02T13:14:15Z"); // January 2nd, 2020, 13:14:15 UTC
// With no options, we get a basic numeric date format
Intl.DateTimeFormat("en-US").format(d) // => "1/2/2020"
Intl.DateTimeFormat("fr-FR").format(d) // => "02/01/2020"
// Spelled out weekday and month
let opts = { weekday: "long", month: "long", year: "numeric", day: "numeric" }; Intl.DateTimeFormat("en-US", opts).format(d) // => "Thursday, January 2, 2020" 
Intl.DateTimeFormat("es-ES", opts).format(d) // => "jueves, 2 de enero de 2020"
// The time in New York, for a French-speaking Canadian
opts = { hour: "numeric", minute: "2-digit", timeZone: "America/New_York" }; Intl.DateTimeFormat("fr-CA", opts).format(d) // => "8 h 14"



let opts = { year: "numeric", era: "short" };
Intl.DateTimeFormat("en", opts).format(d) // => "2020 AD"
Intl.DateTimeFormat("en-u-ca-iso8601", opts).format(d) // => "2020 AD" 
Intl.DateTimeFormat("en-u-ca-hebrew", opts).format(d) // => "5780 AM"
Intl.DateTimeFormat("en-u-ca-buddhist", opts).format(d) // => "2563 BE" 
Intl.DateTimeFormat("en-u-ca-islamic", opts).format(d) // => "1441 AH" 
Intl.DateTimeFormat("en-u-ca-persian", opts).format(d) // => "1398 AP" 
Intl.DateTimeFormat("en-u-ca-indian", opts).format(d) // => "1941 Saka"
Intl.DateTimeFormat("en-u-ca-chinese", opts).format(d) // => "36 78" 
Intl.DateTimeFormat("en-u-ca-japanese", opts).format(d) // => "2 Reiwa"
```

#### Comparing Strings

- Things are not so simple in other languages. Spanish, for example treats ñ as a distinct letter that comes after n and before o. Lithuanian alphabetizes Y before J, and Welsh treats digraphs like CH and DD as single letters with CH coming after C and DD sorting after D.
- If you want to display strings to a user in an order that they will find natural, it is not enough use the sort() method on an array of strings. But if you create an Intl.Collator object, you can pass the compare() method of that object to the sort() method to perform locale-appropriate sorting of the strings. Intl.Collator objects can be configured so that the compare() method performs case-insensitive comparisons or even comparisons that only consider the base letter and ignore accents and other diacritics.
- Like Intl.NumberFormat() and Intl.DateTimeFormat(), the Intl.Collator() constructor takes two arguments. The first specifies a locale or an array of locales, and the second is an optional object whose properties specify exactly what kind of string comparison is to be done. The supported properties are these:

`usage` This property specifies how the collator object is to be used. The default value is "sort", but you can also specify "search". The idea is that, when sorting strings, you typically want a collator that differentiates as many strings as possible to produce a reliable ordering. But when comparing two strings, some locales may want a less strict comparison that ignores accents, for example.
`sensitivity` This property specifies whether the collator is sensitive to letter case and accents when comparing strings. The value "base" causes comparisons that ignore case and accents, considering only the base letter for each character. (Note, however, that some languages consider certain accented characters to be distinct base letters.) "accent" considers accents in comparisons but ignores case. "case" considers case and ignores accents. And "variant" performs strict comparisons that consider both case and accents. The default value for this property is "variant" when usage is "sort". If usage is "search", then the default sensitivity depends on the locale.
`ignorePunctuation` Set this property to true to ignore spaces and punctuation when comparing strings. With this property set to true, the strings “any one” and “anyone”, for example, will be considered equal.
`numeric` Set this property to true if the strings you are comparing are integers or contain integers and you want them to be sorted into numerical order instead of alphabetical order. With this option set, the string “Version 9” will be sorted before “Version 10”, for example.
`caseFirst` This property specifies which letter case should come first. If you specify "upper", then “A” will sort before “a”. And if you specify "lower", then “a” will sort before “A”. In either case, note that the upper- and lowercase variants of the same letter will be next to one another in sort order, which is different than Unicode lexicographic ordering (the default behavior of the Array sort() method) in which all ASCII uppercase letters come before all ASCII lowercase letters. The default for this property is locale dependent, and implementations may ignore this property and not allow you to override the case sort order.


```js
// A basic comparator for sorting in the user's locale.
// Never sort human-readable strings without passing something like this:
const collator = new Intl.Collator().compare;
["a", "z", "A", "Z"].sort(collator) // => ["a", "A", "z", "Z"]

// Filenames often include numbers, so we should sort those specially const 
filenameOrder = new Intl.Collator(undefined, { numeric: true }).compare; ["page10", "page9"].sort(filenameOrder) // => ["page9", "page10"]

// Find all strings that loosely match a target string
const fuzzyMatcher = new Intl.Collator(undefined, { sensitivity: "base", 
   ignorePunctuation: true
}).compare;
let strings = ["food", "fool", "Føø Bar"];
strings.findIndex(s => fuzzyMatcher(s, "foobar") === 0) // => 2


// Some locales have more than one possible collation order

// Before 1994, CH and LL were treated as separate letters in Spain const 
modernSpanish = Intl.Collator("es-ES").compare;
const traditionalSpanish = Intl.Collator("es-ES-u-co-trad").compare;
let palabras = ["luz", "llama", "como", "chico"];
palabras.sort(modernSpanish) // => ["chico", "como", "llama", "luz"]
palabras.sort(traditionalSpanish) // => ["como", "chico", "luz", "llama"]


```

## The Console API

- The Console API defines a number of useful functions in addition to console.log(). The API is not part of any ECMAScript standard, but it is supported by browsers and by Node and has been formally written up and standardized at [https:// console.spec.whatwg.org].
- The Console API defines the following functions

`console.log()`
This is the most well-known of the console functions. It converts its arguments to strings and outputs them to the console. It includes spaces between the arguments and starts a new line after outputting all arguments.
`console.debug(), console.info(), console.warn(), console.error()` These functions are almost identical to console.log(). In Node, con sole.error() sends its output to the stderr stream rather than the stdout stream, but the other functions are aliases of console.log(). In browsers, output messages generated by each of these functions may be prefixed by an icon that indicates its level or severity, and the developer console may also allow developers to filter console messages by level.
`console.assert()` If the first argument is truthy (i.e., if the assertion passes), then this function does nothing. But if the first argument is false or another falsy value, then the remaining arguments are printed as if they had been passed to console.error() with an “Assertion failed” prefix. Note that, unlike typical assert() functions, console.assert() does not throw an exception when an assertion fails.
`console.clear()` This function clears the console when that is possible. This works in browsers and in Node when Node is displaying its output to a terminal. If Node’s output has been redirected to a file or a pipe, however, then calling this function has no effect.
`console.table()` This function is a remarkably powerful but little-known feature for producing tabular output, and it is particularly useful in Node programs that need to produce output that summarizes data. console.table() attempts to display its argument in tabular form (although, if it can’t do that, it displays it using regular console.log() formatting). This works best when the argument is a relatively short array of objects, and all of the objects in the array have the same (relatively small) set of properties. In this case, each object in the array is formatted as a row of the table, and each property is a column of the table. You can also pass an array of property names as an optional second argument to specify the desired set of columns. If you pass an object instead of an array of objects, then the output will be a table with one column for property names and one column for property values. Or, if those property values are themselves objects, their property names will become columns in the table.
`console.trace()` This function logs its arguments like console.log() does, and, in addition, follows its output with a stack trace. In Node, the output goes to stderr instead of stdout.
`console.count()` This function takes a string argument and logs that string, followed by the number of times it has been called with that string. This can be useful when debugging an event handler, for example, if you need to keep track of how many times the event handler has been triggered.
`console.countReset()` This function takes a string argument and resets the counter for that string. 
`console.group()` This function prints its arguments to the console as if they had been passed to console.log(), then sets the internal state of the console so that all subsequent console messages (until the next console.groupEnd() call) will be indented relative to the message that it just printed. This allows a group of related messages to be visually grouped with indentation. In web browsers, the developer console typically allows grouped messages to be collapsed and expanded as a group. The arguments to console.group() are typically used to provide an explanatory name for the group.
`console.groupCollapsed()` This function works like console.group() except that in web browsers, the group will be “collapsed” by default and the messages it contains will be hidden unless the user clicks to expand the group. In Node, this function is a synonym for console.group().
`console.groupEnd()` This function takes no arguments. It produces no output of its own but ends the indentation and grouping caused by the most recent call to console.group() or console.groupCollapsed().
`console.time()` This function takes a single string argument, makes a note of the time it was called with that string, and produces no output.
`console.timeLog()` This function takes a string as its first argument. If that string had previously been passed to console.time(), then it prints that string followed by the elapsed time since the console.time() call. If there are any additional arguments to console.timeLog(), they are printed as if they had been passed to console.log().
`console.timeEnd()` This function takes a single string argument. If that argument had previously been passed to console.time(), then it prints that argument and the elapsed time. After calling console.timeEnd(), it is no longer legal to call console.time Log() without first calling console.time() again.

```js
const data = [
  { name: 'John', age: 28, city: 'New York' },
  { name: 'Jane', age: 32, city: 'Los Angeles' },
  { name: 'Bob', age: 45, city: 'Chicago' }
];

console.table(data);

// =>

| (index) |  name  |  age  |     city     |
|---------|--------|-------|--------------|
|    0    |  John  |  28   |   New York   |
|    1    |  Jane  |  32   |  Los Angeles |
|    2    |   Bob  |  45   |    Chicago   |

```

```js
console.count("fggdf")
console.count("fggdf")
console.count("fggdf")
console.count("fggdf")

// => 

fggdf: 1
fggdf: 2
fggdf: 3
fggdf: 4
```

```js
console.group("dssd")
console.log("dssd")
console.log("dssd")
console.log("dssd")
console.groupEnd()
```

```js
console.time("dd")
console.timeLog("dd")
console.timeEnd("dd")
// => 

dd: 0.057ms
dd: 3.745ms
```
---

- Console functions that print their arguments like console.log() have a little-known feature: if the first argument is a string that includes %s, %i, %d, %f, %o, %O, or %c.

`%o and %O`
The argument is treated as an object, and property names and values are displayed. (In web browsers, this display is typically interactive, and users can expand and collapse properties to explore a nested data structure.) %o and %O both display object details. The uppercase variant uses an implementationdependent output format that is judged to be most useful for software developers.
`%c`
In web browsers, the argument is interpreted as a string of CSS styles and used to style any text that follows (until the next %c sequence or the end of the string). In Node, the %c sequence and its corresponding argument are simply ignored.


```js
console.log("%c => %f", "color:red", 8.555) //=> 8.555 in red color
```


## URL APIs

- The URL class is not part of any ECMAScript standard, but it works in Node and all internet browsers other than Internet Explorer. It is standardized at https:// url.spec.whatwg.org.
- Create a URL object with the URL() constructor, passing an absolute URL string as the argument. Or pass a relative URL as the first argument and the absolute URL that it is relative to as the second argument. Once you have created the URL object, its various properties allow you to query unescaped versions of the various parts of the URL:

```js
let url = new URL("https://example.com:8000/path/name?q=term#fragment");
url.href // => "https://example.com:8000/path/name?q=term#fragment"
url.origin // => "https://example.com:8000"
url.protocol // => "https:"
url.host // => "example.com:8000"
url.hostname // => "example.com" 
url.port // => "8000"
url.pathname // => "/path/name"
url.search // => "?q=term"
url.hash // => "#fragment"
 
// Although it is not commonly used, URLs can include a username or a username and password, and the URL class can parse these URL components, too:

let url = new URL("ftp://admin:1337!@ftp.example.com/");
url.href // => "ftp://admin:1337!@ftp.example.com/"
url.origin // => "ftp://ftp.example.com"
url.username // => "admin" url.password // => "1337!"

```
- The origin property here is a simple combination of the URL protocol and host (including the port if one is specified). As such, it is a read-only property. But each of the other properties demonstrated in the previous example is read/write: you can set any of these properties to set the corresponding part of the URL:

```js
let url = new URL("https://example.com"); // Start with our server
url.pathname = "api/search"; // Add a path to an API endpoint
url.search = "q=test"; // Add a query parameter
url.toString() // => "https://example.com/api/search?q=test"

// One of the important features of the URL class is that it correctly adds punctuation and escapes special characters in URLs when that is needed:

let url = new URL("https://example.com"); 
url.pathname = "path with spaces";
url.search = "q=foo#bar";
url.pathname // => "/path%20with%20spaces"
url.search // => "?q=foo%23bar"
url.href // => "https://example.com/path%20with%20spaces?q=foo%23bar"


// URLSearchParams object, which has an API for getting, setting, adding, deleting, and sorting the parameters encoded into the query portion of the URL:


let url = new URL("https://example.com/search");
url.search // => "": no query yet
url.searchParams.append("q", "term"); // Add a search parameter
url.search // => "?q=term"
url.searchParams.set("q", "x"); // Change the value of this parameter 
url.search // => "?q=x"
url.searchParams.get("q") // => "x": query the parameter value
url.searchParams.has("q") // => true: there is a q parameter
url.searchParams.has("p") // => false: there is no p parameter
url.searchParams.append("opts", "1"); // Add another search parameter url.search
// => "?q=x&opts=1"
url.searchParams.append("opts", "&"); // Add another value for same name 
url.search // => "?q=x&opts=1&opts=%26": note escape
url.searchParams.get("opts") // => "1": the first value
url.searchParams.getAll("opts") // => ["1", "&"]: all values
url.searchParams.sort(); // Put params in alphabetical order
url.search // => "?opts=1&opts=%26&q=x"
url.searchParams.set("opts", "y"); // Change the opts param
url.search // => "?opts=y&q=x"
// searchParams is iterable
[...url.searchParams] // => [["opts", "y"], ["q", "x"]]
url.searchParams.delete("opts"); // Delete the opts param
url.search // => "?q=x"
url.href // => "https://example.com/search?q=x"


let url = new URL("http://example.com");
let params = new URLSearchParams();
params.append("q", "term");
params.append("opts", "exact");
params.toStrig() // => "q=term&opts=exact"
url.search = params;
url.href // => "http://example.com/?q=term&opts=exact"
```

- `encodeURI` is used to encode a complete URI, which includes the protocol, hostname, and path. It will not encode special characters that are part of the URI syntax, such as `:` `//` `?` `#` `&` `=` etc.
```js
const uri = "https://example.com/my page.html?name=John&age=30";
const encodedURI = encodeURI(uri);
console.log(encodedURI); // "https://example.com/my%20page.html?name=John&age=30"
```

- `encodeURIComponent`, on the other hand, is used to encode a part of a URI, such as a query parameter value or a fragment identifier. It encodes all special characters, including those that are part of the URI syntax.
```js
const name = "John Doe";
const encodedName = encodeURIComponent(name);
console.log(encodedName); // "John%20Doe"
```

- `decodeURI` is used to decode a complete URI, including the protocol, hostname, and path, that has been encoded using `encodeURI`. It will not decode special characters that are part of the URI syntax, such as `:` `//` `?` `#` `&` `=` etc.
```js
const encodedURI = "https://example.com/my%20page.html?name=John&age=30";
const decodedURI = decodeURI(encodedURI);
console.log(decodedURI); // "https://example.com/my page.html?name=John&age=30"
```

- `decodeURIComponent` is used to decode a part of a URI, such as a query parameter value or fragment identifier, that has been encoded using `encodeURIComponent`. It decodes all special characters, including those that are part of the URI syntax.
```js
const encodedName = "John%20Doe";
const decodedName = decodeURIComponent(encodedName);
console.log(decodedName); // "John Doe"
```

## Timers

- Since the earliest days of JavaScript, web browsers have defined two functions— setTimeout() and setInterval()—that allow programs to ask the browser to invoke a function after a specified amount of time has elapsed or to invoke the function repeatedly at a specified interval. These functions have never been standardized as part of the core language, but they work in all browsers and in Node
```js
setTimeout(() => { console.log("Ready..."); }, 1000);
setTimeout(() => { console.log("set..."); }, 2000);
setTimeout(() => { console.log("go!"); }, 3000);
```

- setInterval() takes the same two arguments as setTimeout() but invokes the function repeatedly every time the specified number of milliseconds (approximately) have elapsed.
- clearTimeout() to cancel the execution of a function registered with setTime out() (assuming it hasn’t been invoked yet) or to stop the repeating execution of a function registered with setInterval().
- Here is an example that demonstrates the use of setTimeout(), setInterval(), and clearInterval() to display a simple digital clock with the Console API:
```js
// Once a second: clear the console and print the current time
let clock = setInterval(() => {
	console.clear();
	console.log(new Date().toLocaleTimeString());
}, 1000);

// After 10 seconds: stop the repeating code above.
setTimeout(() => { clearInterval(clock); }, 10000);
```