![[Screen Shot 2023-03-18 at 2.58.24 PM.png]]![[Screen Shot 2023-03-18 at 2.58.36 PM.png]]

- All Objects are converted to true even an empty array
## Conversions and Equality

=== “strict equality operator,” ===, does not consider its operands to be equal if they are not of the same type

== 
```js
null == undefined // => true: These two values are treated as equal.
"0" == 0 // => true: String converts to a number before comparing.
0 == false // => true: Boolean converts to number before comparing.
"0" == false  // => true: Both operands convert to 0 before comparing!
```
## Explicit Conversions


The simplest way to perform an explicit type conversion is to use the `Boolean(), Num ber(), and String() functions`
The `toString()` method defined by the Number class accepts an optional argument that specifies a radix, or base, for the conversion

## Conversion

- The simplest way to perform an explicit type conversion is to use the `Boolean(), Number(), and String() functions`
- Global Function `parseInt(), parseFloat()`
- The `toString()` method defined by the Number class accepts an optional argument that specifies a radix, or base, for the conversion
- The JavaScript specification defines three fundamental algorithms for converting objects to primitive values:
	- prefer-string
	- prefer-number
	- no-preference (user defined)

- The + operator in JavaScript performs numeric addition and string concatenation. If either of its operands is an object, JavaScript converts them to primitive values using the` no-preference algorithm`. Once it has two primitive values, it checks their types. If either argument `is a string`, it converts the other to a string and concatenates the strings. Otherwise, it converts both arguments `to numbers` and adds them.
- The == and != operators perform equality and inequality testing in a loose way that allows type conversions. If one operand is an object and the other is a primitive value, these operators convert the object to primitive using the `no-preference `algorithm and then compare the two primitive values
-  Finally, the relational operators <, <=, >, and >= compare the order of their operands and can be used to compare both numbers and strings. If either operand is an object, it is converted to a primitive value using the `prefer-number algorithm`. Note, however, that unlike the object-to-number conversion
- The `prefer-string algorithm` first tries the `toString() method`. If the method is defined and returns a primitive value, then JavaScript uses that primitive value (even if it is not a string!). If toString() does not exist or if it returns an object, then JavaScript tries the `valueOf()` method. If that method exists and returns a primitive value, then JavaScript uses that value. Otherwise, the conversion fails with a TypeError.
- The `prefer-number algorithm` works like the prefer-string algorithm, except that it tries `valueOf() first and toString() second.`
- The `no-preference algorithm` depends on the class of the object being converted. If the object is a **Date object, then JavaScript uses the prefer-string algorithm**. `For any other object, JavaScript uses the prefer-number algorithm`

## ConversionCode
```js
Boolean(null)
String(4)
Number("0")

let n = 10
let sn = n.toString(16)

let n = 123456.789
n.toFixed(0) // => "123457"
n.toFixed(2) // => "123456.79"
n.toFixed(5)  // => "123456.78900"
n.toExponential(1)  // => "1.2e+5"
n.toExponential(3) // => "1.235e+5"
n.toPrecision(4) // => "1.235e+5"
n.toPrecision(7) // => "123456.8"
n.toPrecision(10) // => "123456.7890"

parseInt("3 blind mice") // => 3
parseFloat(" 3.14 meters") // => 3.14
parseInt("-12.34") // => -12
parseInt("0xFF") //255
parseInt("0xff") //255
parseInt("-0XFF"//-255
parseFloat(".1") //0.1
parseInt("0.1") // 0
parseInt(".1")  //=> NaN: integers can't start with "."
parseFloat("$72.47") //=> NaN: numbers can't start with "$"

parseInt("11", 2) // => 3: (1*2 + 1)
parseInt("ff", 16) // => 255: (15*16 + 15)
parseInt("zz", 36) // => 1295: (35*36 + 35)
parseInt("077", 8) // => 63: (7*8 + 7)
parseInt("077", 10) // => 77: (7*10 + 7)
```

