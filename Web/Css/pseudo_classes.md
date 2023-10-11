```css
ul li:nth-child(odd) {

}

li:last-child {

}

a:active {}
a:hover {}
a:visited {}
a:focus {}

:is(... rules)
:where(... rules)

rule:target {} //element that has the target selected `../../#target`

img[alt] {} slecting any image with alt attribute
img:not([alt]) {} 

ele::after {
	content : "blabla"
}
ele::befor {
	content : "blabla"
}

ele::first-letter {}
ele::first-line {}

ele:hover::before {

}

```

The `::marker` pseudo-element in CSS is used to style the marker (bullet or number) of list items in an ordered (e.g., `<ol>`) or unordered (e.g., `<ul>`) list. This pseudo-element allows you to apply custom styling to the markers themselves, including changing their color, size, or any other CSS properties you want to modify.

```css
ul::marker {
  color: red; /* Change the marker color to red */
  font-size: 20px; /* Increase the marker font size */
  content: "\2022"; /* Change the marker to a custom character (e.g., a bullet) 
}
```