`Optional Semicolons`
- JavaScript treats a line break as a semicolon if the next nonspace character cannot be interpreted as a continuation of the current statement.
- In general, if a statement begins with `(, [, /, +, or -,` there is a chance that it could be
interpreted as a continuation of the statement before.
```js
// These statement termination rules lead to some surprising cases. This code looks like two separate statements separated with a newline

let y = x + f
(a+b).toString()
```

- `return, throw, yield, break, and continue` These statements often stand alone, but they are sometimes followed by an identifier or expression. If a line break appears after any ofthese words (before any other tokens), `JavaScript will always interpret that line break as a semicolon.`
- the general rule that JavaScript interprets line breaks as semicolons when it cannot parse the second line as a continuation of the statement on the first line.