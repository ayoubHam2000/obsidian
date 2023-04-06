![[Screen Shot 2023-03-18 at 6.06.13 PM.png]]![[Screen Shot 2023-03-18 at 6.06.20 PM.png]]

- Precedence and Associativity
- Operators with higher precedence (nearer the top of the table) are performed before those with lower precedence (nearer to the bottom).
- When new operators are added to JavaScript, they do not always fit naturally into this precedence scheme. `The ?? operator` (§4.13.2) is shown in the table as lower precedence than || and &&, but, in fact, its precedence relative to those operators is not defined, and `ES2020 requires you to explicitly use parentheses if you mix ?? with either || or &&. Similarly, the new ** `exponentiation operator does not have a well defined precedence relative to the unary negation operator, and you must use parentheses when combining negation with exponentiation.
- While the modulo operator is typically used with integer operands, it also works for floating-point values. For example, 6.5 % 2.1 evaluates to 0.2.
- unary operators all have high precedence and are all right-associative
- These operators convert their operands to numbers, if necessary, and then coerce the numeric values to 32-bit integers by dropping any fractional part and any bits beyond the 32nd. The shift operators require a right-side operand between 0 and 31. After converting this operand to an unsigned 32-bit integer, they drop any bits beyond the 5th, which yields a number in the appropriate range.
- Surprisingly, NaN, Infinity, and -Infinity all convert to 0 when used as operands of these bitwise operators.
- All of these bitwise operators except >>> can be used with regular number operands or with BigInt (see §3.2.5) operands.
- applying the ~ operator to a value is equivalent to changing its sign and subtracting 1.
- >> : .... in order to preserve the sign of the result. If the first operand is positive, the result has zeros placed in the high bits; if the first operand is negative, the result has ones placed in the high bits.
- −1 >> 4 evaluates to −1, but −1 >>> 4 evaluates to 0x0FFFFFFF, −1 >> 4 evaluates to −1, but −1 >>> 4 evaluates to 0x0FFFFFFF,

```js
//?? 
//ES2020 when you want to select the first defined operand rather than the first truthy operand

let max = maxWidth || preferences.maxWidth || 500;

//The problem with this idiomatic use is that zero, the empty string, and false are all falsy values that may be perfectly valid in some circumstances. In this code example, if maxWidth is zero, that value will be ignored. But if we change the || operator to ??, we end up with an expression where zero is a valid value

let max = maxWidth ?? preferences.maxWidth ?? 500;
```

```js
// typeof 
// Its value is a string that specifies the type of the operand
// Note that typeof returns “object” if the operand value is null. If you want to distinguish null from objects, you’ll have to explicitly test for this special-case value.
```

```js
//delete
// delete is a unary operator that attempts to delete the object property or array element specified as its operand.

let o = { x: 1, y: 2}; // Start with an object
delete o.x; // Delete one of its properties 
"x" in o // => false

let a = [1, 2, 3]
delete a[2] // Delete the last element of the array
2 in a // => false: array element 2 doesn't exist anymore
a.length // => 3: note that array length doesn't change, though

//Note that a deleted property or array element is not merely set to the undefined value. When a property is deleted, the property ceases to exist. Attempting to read a nonexistent property returns undefined

// delete expects its operand to be an lvalue. If it is not an lvalue, the operator takes no action and returns true. Otherwise, delete attempts to delete the specified lvalue. delete returns true if it successfully deletes the specified lvalue. Not all properties can be deleted, however: non-configurable properties (§14.1) are immune from deletion.

//Strict mode also specifies that delete raises a TypeError if asked to delete any non-configurable (i.e., nondeleteable) property.

let o = {x: 1, y: 2};
delete o.x; // Delete one of the object properties; returns true.
typeof o.x; // Property does not exist; returns "undefined".
delete o.x; // Delete a nonexistent property; returns true.
delete 1; // This makes no sense, but it just returns true.
delete o; // Can't delete a variable; returns false, or SyntaxError in strict mode.
delete Object.prototype; // Undeletable property: returns false, or TypeError in strict mode.
```

```js
//await

// await was introduced in ES2017 as a way to make asynchronous programming more natural in JavaScript.
// however, await expects a Promise object (representing an asynchronous computation) as its sole operand,
```

```js
//void
// it evaluates its operand, then discards the value and returns undefined

let counter = 0;
const increment = () => void counter++;
increment() // => undefined
counter // => 1
```

```js
//comma operator
//It evaluates its left operand, evaluates its right operand, and then returns the value of the right operand.

i = (j = 5, u = 6)
//i = 6
```