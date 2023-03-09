JavaScript types can be divided into two categories: `primitive types` and `object types`.
### Primitives

- number (20, 0xff, 0o399, 0b10101),
	- `(20, 0xff, 0o399, 0b10101)`
	- `([digits][.digits][(E|e)[(+|-)]digits])` 2.33E-10
	- 1_000_000 0xff_ff
	- 10n //ES2020 BIG Int
- boolean
- string
- special values as null and undefined
- Symbol

### object

any type that is not primitive 

- global object,
- Map,
- Set,
- array,
- RegExp,
- Date,
- Error
- functions
- classes
---

- Technically, it is only JavaScript objects that have methods. But numbers, strings, boolean, and symbol values behave as if they have methods. In JavaScript, `null and undefined` are the only values that methods cannot be invoked on.
- JavaScript’s object types are `mutable` and its primitive types are `immutable`.
- JavaScript `represents numbers using the 64-bit floating-point` format defined by the `IEEE 754 standard`,which means it can represent num‐bers as large as ±1.7976931348623157 × 10^308 and as small as ±5 × 10^−324.
- JavaScript uses a 64-bit floating-point format to represent numbers, which is the same as the IEEE 754 standard for floating-point arithmetic. This format allocates 1 bit for the sign of the number, 11 bits for the exponent, and 52 bits for the mantissa (also known as the significand).
- 52 bits allocated for the mantissa, which means that it can represent numbers up to 2^53 - 1 accurately.
- The JavaScript number format allows you to exactly represent all integers between
±2^253 -1, inclusive. If you use
integer values larger than this, you may lose precision in the trailing digits.
- array indexing and the bitwise are performed with 32-bit integers.
- ES2016 adds ** for expo‐ nentiation
- Arithmetic in JavaScript does not raise errors in cases of overflow,
	underflow, or division by zero.
	(Overflow) -> Infinity or -Infinity.
	(Underflow) -> 0 or -0
	n / 0 -> Infinity
	0 / 0 -> NaN
	Infinity / Infinity -> NaN
- The not-a-number value has one unusual feature in JavaScript: it does not compare
equal to any other value, including itself. This means that you can’t write `x=== NaN to determine whether the value of a variable x is NaN. Instead, you must write x != x or Number.isNaN(x).`
