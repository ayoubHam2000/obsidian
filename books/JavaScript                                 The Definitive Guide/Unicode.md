`Unicode`
- JavaScript programs are written using the Unicode character set, and you can use any
Unicode characters in strings and comments.

```js
let café = 1; // Define a variable using a Unicode character
caf\u00e9 // => 1; access the variable using an escape sequence
caf\u{E9} // => 1; another form of the same escape sequence

// The ver‐sion with curly braces was introduced in ES6
```

- If you use non-ASCII characters in your JavaScript programs, you must be aware that
Unicode allows more than one way of encoding the same character. The string “é,” for
example, can be encoded as the single Unicode character \\u00E9 or as a regular
ASCII “e” followed by the acute accent combining mark \\u0301. These two encodings
typically look exactly the same when displayed by a text editor

```js
const café = 1; // This constant is named "caf\u{e9}"
const café = 2; // This constant is different: "cafe\u{301}"
café // => 1: this constant has one value
café // => 2: this indistinguishable constant has a different value
```
