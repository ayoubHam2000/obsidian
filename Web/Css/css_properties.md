- padding
- margin [top, right, bottom, left]
	- margin-top
	- margin-bottom
	- margin-right
	- margin-left
	- margin-inline
- font-size
- border 2px dashed red
	- border-top-[style, width, color]
	- border-left-[style, width, color]
	- border-right-[style, width, color]
	- border-bottom-[style, width, color]
	- border-radius
- outline 5px solid purple -> doesn't calculated
	- outline-offset -20px
- width
	- min-with
- height
	- max-height
- opacity
- background `background-repeat, background-position, backgroung-img, another background ... `
	- background-color
	- background-image `url..., linear-gradient(1-color, 2-clr, ...)`
		- `linear-gradient(45deg, red 0 50%, blue 50% 100%);`
		- `radial-gradient()`
		- you can have both of utl and linear-gradient
		- in this case all the background-xxx will have the first value for the first bg-img and second for the second bg-img ...
	- background-repeat `no-repeat, repeat, repeat-y, repeat-x, `
	- background-size : `cover, contain, `
	- background-position
- display `block inline inline-block none`
- float `right left`
- overflow `auto flow-root`
- z-index 1
- scroll-behavior : smooth

## text settings

- text-decoration : `underline, overline, line-through`
- text-transform : `capitalized, lowercase, uppercase`
- text-align : `left, justify, right`
- text-shadow : offset-x | offset-y | blur-radius | color
	- `1px 1px 1px #fff`
- text-indent
- line-height
- letter-spacing
- word-spacing
- font-weight : `bolder, lighter, 100-900+`
- font-style : `italic, oblique`
- font-familly : `serif, sans-serif, monospace, arial`
	it can has multi value, it can have a value with space in it like 'Courier New'
	if the system doesn't have the font the next value is chosen
	google style sheet -> https://fonts.google.com/
      you can use `link in the html, @import inside the css`


## a

```css
a {
   text-decoration : none
   cursor : pointer
}

a:visited -> visited link
a:hover, a:focus
a:active -> after clicking
hover should comme after visited because of the priority 

```

## ol

```css
ol, ul {
   list-style-type : [decimal, lower-alpha, decimal-leading-zero, disc, upper-roman];
   list-style-position : [outside, inside]; //property used to control the positioning of the marker or bullet point in a list item
   padding : 0;
   list-style-image : url('path_to_an_image');
   list-style : [type -> image -> position]
}

// you can add properties to ol in the html like, reverse start="3"

```

## column

``` css
.column {
    column-count : 4;
    column-width : 100px;
    column : 4 100px;
    column-rule : 2px solid #555555
    column-gap: 3re;
}

.column h2 {
	mrgin-top : 0;
	padding : 1rem;
	break-inside: avoid; //prevent breaking the element one part in one column and the other inside another column.
}

.column .quote {
	column-span : all; //take the size of all elements
}

.nowrap {
	white-space: nowrap; 
	The `white-space` property in CSS is used to control how white space (spaces, tabs, and line breaks) inside an element is handled. The `nowrap` value is used to prevent text from wrapping to the next line within an element, making it all appear on a single line.
}

```

## Position 

```css
The `position: absolute;` CSS property is used to position an element within its nearest positioned ancestor. When you apply `position: absolute;` to an element, it is taken out of the normal document flow, and its position is determined relative to the nearest ancestor that has a `position` property other than `static` (such as `relative`, `absolute`, or `fixed`).


The `position: sticky;` CSS property is used to create elements that "stick" to a specific position on the screen when the user scrolls. It's a hybrid between `position: relative;` and `position: fixed;` in that it acts as a relatively positioned element until a certain scroll point is reached, after which it becomes fixed in place. Once the user scrolls past another defined point, it resumes being relatively positioned.


ele {
	position: [absolute, fixed, relative, sticky];
	top: 0px;
	right : 0px;
	left : 0px;
	bottom : 0px;

}


```

## flex box

```css
.container {
	max-width: 800px;
	min-height: 400px;
	margin-inline: auto;
	border: 1px solid #000;
	display: flex;
	gap: 1rem;
	justify-content: [end, start, center, space-evenly, space-around, space-between]
	align-items: [flex-start, flex-end, center] //vertiacally or horizontally depending on flex-direction;
	flex-direction: [column, row, row-reverse, column-reverse]
	flex-wrap : [wrap, wrap-reverse]; //handle-overflow
	flex-flow : [->flex-direction, ->flex-wrap]
	align-content : [flex-end, flex-start, center, space-between, space-around, space-evenly]
}

.box {
	min-width: 100px;
	height: 100px;
	background-color: #000;
	color: #fff;
//center content
	display: flex;
	justify-content: center;
	align-items: center;

	flex-grow : 1;
	flex-shrink: 1;
	flex-basis : 100px;
	flex: [->flex-grow, ->flex-shrink, ->flex-basis]
	
}

.box .an_item {
	order : [4, -1];
	align-self : [like align-items]
}

//flexboxfroggy

.box:nth-child(2) {
flex-grow : 2;
flex-shrink: 2;
}


The `flex-grow` CSS property is used within a flexbox container to specify how much an individual flex item should grow relative to other items within the same container when there is extra space available along the main axis. It's part of the CSS Flexbox layout module.

The `flex-basis` CSS property is used within a flex container to set the initial size of a flex item along the main axis before any remaining space is distributed among the items. It determines the ideal size of the item before considering factors like `flex-grow` and `flex-shrink`.

```


## grid


```css

.container  {
	display : grid;
	grid-auto-flow : [row, column];
	
	grid-template-columns : [nbr.fr ..., repeat(4, 1fr 2fr)] // to represent three columns in each row for example : 1fr 2fr 2fr;
	grid-template-columns : 100px 3em 40%;
	grid-template-rows : 100px 3em 40%;
	//Or
	grid-template : 50% 50% / repeat(3, 2fr);
	
	grid-auto-rows : [200px, minmax(150px, auto), 100px auto 300px];
	grid-template-areas : "hd hd hd hd" "mn mn mn mn" "ft ft ft ft"
	
	row-gap : 1em;
	column-gap : 1em;
	gap : [->row, ->column]
}

.header {
	grid-area : "hd";
}

.sidebar {
	grid-area : "sb";
}

.footer {
	grid-area : "ft";
}

.box:first-child {
	background-color : #111111;
	
	grid-column-start : 1;
	grid-column-end : 4;
	grid-row-start : 1;
	grid-row-end : 2;
	//also
	grid-column : 1 / 4;
	grid-row : 3 / 4;
	//also
	grid-area : 1 / 3 / 4 / 4 //grid-row-start, grid-column-start, grid-row-end, followed by grid-column-end.

	//change the order
	order : [1, -1]; //all the item have order 0

	//center content
	display: grid;
	justify-content : center;
	align-content : center;
	place-content : [-> justify-content, -> align-content]
}

```

4h:42min

![[vlcsnap-2023-09-06-15h56m10s771.png]]
## Media Queries

```css
<meta name='viewport' content='with=device-width, intial-scale=1.0' />
initial for using media

Syntax:

@media media type and (condition: breakpoint) and ... {
	//css rules
}

example

condition: breakpoint -> [
		min-width : 500px,
		orientation : landscape
		min-ascpect-retio : 16/9
		...
	]

@media screen and (min-width: 500px) {
	
}

@media (prefers-color-schema : dark) {

}

```

[[Breakpoints]]

min(100%, 350px)
calc(33% - 1rem)


## Variables

```css
:root {
	--BGCOLOR : #554477;
	__OTHER : 1px solid var(--BGCOLOR)
}

element {
	background-color : var(--BGCOLOR);
}

you_change_the_value_for_specific_class {
	--BGCOLOR : #77d566;
}

@media (prefers-color-schema : dark) {
	:root {
		--BGCOLOR : #555788;
	}
}


```

## Function

```
rgb
hsl
var
radial-gradient
linier-gradient
calc
min
max
minmax
repeat
clamp(1.75rem, 3vh, 2.25rem)

ele {
	filter : brightness(150%)
	filter : hue-rotate(180deg)
}

```

## Animation

```css

ele {
	transform : translateX(50%);
	transform : translateY(50%);
	transform : translate(50%, 50%);
	transform : rotateX(180deg);
	transform : rotateY(180deg);
	transform : rotateZ(180deg) or rotate(180deg);
	transform : scaleX(120%);
	transform : scaleY(120%);
	transform : scale(50%, 50%);
	transform : skewX(50deg);
	transform : skewY(50deg);
	transform : skew(50deg, 50deg);
}

ele:hover {
	transition-duration : 2s;
	transition-delay : 2s;
	transition-property : background-color, transform;
	background-color : #778899;
	transform : rotate(180deg);
	transition-timing-function : [ease, linear,]

	//also
	transition : all duration transition-timing-function delay;
}


//===============

.animate {
	animation-name : slide;
	animation-duration : 5s;
	animation-timing-function : ease-in-out;
	animation-delay : 1s;
	animation-iteration-count : 2;
	animation-direction : normal;
	animation-fill-mode : forwards;
	//Or
	animation : 5s ease-in-out 1s 2 normal forwards slide;
}

@keyframes slide {
	0% {
		transform : translateX(0)
	}

	33% {
		transform : translateX(600px) rotate(180deg);
	}
	
	66% {
		transform : translateX(-600px) rotate(-180deg);
	}
	
	100% {
		transform : translate(0);
		background-color : #558896;
	}
}

```