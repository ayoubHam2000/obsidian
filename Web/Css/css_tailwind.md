
## Install tailwind in Vite project

```
https://tailwindcss.com/docs/guides/vite

npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

>> copy these lines into tailwind.config.js

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}


>> index.css

@tailwind base;
@tailwind components;
@tailwind utilities;


```

## Vscode extentions

```json

  "tailwindCSS.includeLanguages": {
      "javascript": "javascript",
      "javascriptreact": "javascriptreact",
      "typescript": "typescript",
      "typescriptreact": "typescriptreact",
  },

  "inlineFold.regexFlags": "g",
  "inlineFold.regexGroup": "2",
  "inlineFold.unfoldedOpacity": 0.9,
  "inlineFold.maskChar": "…",
  "inlineFold.supportedLanguages": ["javascriptreact", "typescriptreact", "html", "tsx", "typescript", "javascript"],
  "inlineFold.unfoldOnLineSelect": true,
  "inlineFold.autoFold": true,
  "inlineFold.regex": "(class|className)=['\"]([a-zA-Z0-9-\\s]+)(?=['\"])",


  "editor.quickSuggestions": {
    "strings": true
  }
```


## Tailwind

```css
.sizes
	h-10
	w-10
	w-2/4 ->50%
	w-1/6
	w-1/5
	w-1/12
	w-screen
	w-min
	w-max
	w-fit
	w-full

.margin-and-padding
	p-5 //padding
	p-auto
	p-[20px]
	m-{size} (margin)
	mt-{size} (margin-top)
	mr-{size} (margin-right)
	mb-{size} (margin-bottom)
	ml-{size} (margin-left)
	mx-{size} (horizontal margin)
	my-{size} (vertical margin)
	ms-{size} (inline-start margin)
	me-{size} (inline-end margin)

.text
	.sizes
		text-xs
		text-sm
		text-base
		text-lg
		text-xl
		text-2xl
		text-9xl
		text-xl/6 -> font size with line height
	.other
		text-center
		text-red-500

.font
	font-thin
	font-extralight
	font-light
	font-normal
	font-medium
	font-semibold
	font-bold
	font-extrabold
	font-black
	.style
	italic
	not-italic
	.fontFamilly
	font-sans
	font-serif
	font-mono

.Responsive Design
	sm min-width : 640px
	md 768px
	lg 1024px
	xl 1280px
	2xl 1536px

.Pseudo-classes
	https://tailwindcss.com/docs/hover-focus-and-other-states#quick-reference
	hover:bg-red-500 hover:text-[#447789]
	focus:bg-red-500
	active:bg-red-800
	first:pt-50
	visited
	target
	checked
	valid
	invalid
	in-range
	out-of-range
	
	last:pt-50
	odd:bg-white
	even:bg-slate-50
	disabled:bg-slate-50
	invalid:border-pink-500
	group-hover
	group-hover/edit
	group-[selector]:block
	after
	befor
	placeholder
	selection //Style the active text selection
	marker //Style the counters or bullets in lists
	first-letter
	first-line
	dark //dark mode
	portrait
	landscape
	open //add styles when a <details> or <dialog> element is in an
	  open state
	
font
	font-mono
	font-extrabold


z-40 // z-index 40;
visible
invisible
collapse
bg-red-500


border-violet-500
border-2
rounded-md
rounded-full

https://tailwindcss.com/docs/overflow

static //default
relative
absolute
sticky
fixed
	top-0
	end-0
	left-0
	right-0
	inset-0 //like padding

flex
	justify-center
	justify-between
	space-x-2

grid
	grid-cols-5
	gap-2
```

## Custom class

```css

@layer components {
	.custom-class {
		@apply m-10 absolute t-0
	}
}

```