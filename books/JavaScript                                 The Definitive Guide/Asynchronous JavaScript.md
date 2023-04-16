

Resolving, Promises, and Chaining Promises are concepts related to asynchronous programming in JavaScript.

- `Event`: In the context of programming, events refer to actions or occurrences that happen within an application or on a web page. These can include user interactions such as clicks, keystrokes, and mouse movements, or system events such as the loading of a web page, the completion of an asynchronous operation, or the receipt of a message from a server.
	
-   `Callback`: In JavaScript, a callback is a function that is passed as an argument to another function and is intended to be called by that function when a specific event or action occurs. The purpose of a callback is to allow asynchronous operations to be handled in a more flexible and manageable way.
	
-   `Promise`: A Promise is an object that represents a value that may not be available yet but will be at some point in the future. The state of a Promise can be one of three possible values: Pending, Fulfilled (resolved), or Rejected (failed). `Promises` provide a way to handle asynchronous operations in JavaScript. They allow you to start a task that will run asynchronously and then attach callbacks to handle the results when they become available. This is done by creating a new Promise object and passing a function (the executor) that defines the asynchronous task to be performed.
	
-   `Resolving`: . When a Promise is resolved, it means that the value it represents has been successfully retrieved.
    
-   `Chaining Promises`: Promises can be chained together to create more complex sequences of asynchronous operations. This is done by attaching multiple "then" methods to a Promise object, each of which returns a new Promise that represents the result of the previous operation. This allows you to create a sequence of asynchronous operations that depend on each other, without having to write nested callbacks.
    

Here is an example of how to use Promises to load data from a server and then manipulate it:

```js
fetch('https://example.com/data.json')
  .then(response => response.json()) // Parse the JSON data
  .catch(HandleError).
  .then(data => data.map(item => item.name))
  .then(names => console.log(names)) // Log the list of names
  .catch(error => console.error(error)) // Handle any errors that occurred
  .finally(() => {console.log('Promise settled'); });

```

- In practice, it is rare to see two functions passed to then(). There is a better and more idiomatic way of handling errors when working with Promises
- Remember that the callback you pass to .catch() will only be invoked if the callback at a previous stage throws an error. If the callback returns normally, then the .catch() callback will be skipped, and the return value of the previous callback will become the input to the next .then() callback. 
- Also remember that .catch() callbacks are not just for reporting errors, but for handling and recovering from errors. Once an error has been passed to a .catch() callback, it stops propagating down the Promise chain. A .catch() callback can throw a new error, but if it returns normally, than that return value is used to resolve and/or fulfill the associated Promise, and the error stops propagating.
```js

getJSON("/api/user/profile").then(displayUserProfile).catch(handleProfileError);
```

- The `.catch()` method of a Promise is simply a shorthand way to call `.then() `with null as the first argument and an error-handling callback as the second argument. Given any Promise p and a callback c, the following two lines are equivalent:
- Like .then() and .catch(), `.finally()` returns a new Promise object. 
- The return value of a .finally() callback is generally ignored, and the Promise returned by .finally() will typically resolve or reject with the same value that the Promise that .finally() was invoked on resolves or rejects with. 
- If a .finally() callback throws an exception, then the Promise returned by .finally() will reject with that value.

```js
p.then(null, c);
p.catch(c);
```


---
```js
fetch(theURL) // task 1; returns promise 1
.then(callback1) // task 2; returns promise 2
.then(callback2); // task 3; returns promise 3
```

Let’s walk through this code in detail:
1. On the first line, fetch() is invoked with a URL. It initiates an HTTP GET request for that URL and returns a `Promise`. We’ll call this HTTP request `“task 1”` and we’ll call the Promise `“promise 1”`.
2. On the second line, we invoke the `then()` method of` promise 1`, passing the call back1 function that we want to be invoked when promise 1 is fulfilled. The `then()` method stores our callback somewhere, then returns a `new Promise`. We’ll call the new Promise returned at this step `“promise 2”`, and we’ll say that `“task 2”` begins when callback1 is invoked.
3. On the third line, we invoke the then() method of promise 2, passing the call back2 function we want invoked when promise 2 is fulfilled. This `then()` method remembers our callback and returns yet another Promise. We’ll say that “task 3” begins when callback2 is invoked. We can call this latest Promise “promise 3”, but we don’t really need a name for it because we won’t be using it at all.
4. The previous three steps all happen synchronously when the expression is first executed. Now we have an asynchronous pause while the HTTP request initiated in step 1 is sent out across the internet.
5. Eventually, the HTTP response starts to arrive. The asynchronous part of the `fetch()` call wraps the HTTP status and headers in a Response object and fulfills promise 1 with that Response object as the value.
6. When promise 1 is fulfilled, its value (the Response object) is passed to our call back1() function, and task 2 begins. The job of this task, given a Response object as input, is to obtain the response body as a JSON object.
7. Let’s assume that task 2 completes normally and is able to parse the body of the HTTP response to produce a JSON object. This JSON object is used to fulfill promise 2.
8. The value that fulfills promise 2 becomes the input to task 3 when it is passed to the callback2() function. This third task now displays the data to the user in some unspecified way. When task 3 is complete (assuming it completes normally), then promise 3 will be fulfilled. But because we never did anything with promise 3, nothing happens when that Promise settles, and the chain of asynchronous computation ends at this point.

---
```js
function c1(response) {
	let p4 = response.json()
	return p4
}

function c2(profile) {
	displayUserProfile(profile)
}

let p1 = fetch("/api/user/profile"); 
let p2 = p1.then(c1);
let p3 = p2.then(c2);
```

- In order for Promise chains to work usefully, the output of task 2 must become the input to task 3. And in the example we’re considering here, the input to task 3 is the body of the URL that was fetched, parsed as a JSON object. But, as we’ve just discussed, the return value of callback c1 is not a JSON object, but Promise p4 for that JSON object. This seems like a contradiction, but it is not: when p1 is fulfilled, c1 is invoked, and task 2 begins. And when p2 is fulfilled, c2 is invoked, and task 3 begins. But just because task 2 begins when c1 is invoked, it does not mean that task 2 must end when c1 returns. Promises are about managing asynchronous tasks, after all, and if task 2 is asynchronous (which it is, in this case), then that task will not be complete by the time the callback returns.
- We are now ready to discuss the final detail that you need to understand to really master Promises. When you pass a callback c to the then() method, then() returns a Promise p and arranges to asynchronously invoke c at some later time. The callback performs some computation and returns a value v. When the callback returns, p is resolved with the value v. When a Promise is resolved with a value that is not itself a Promise, it is immediately fulfilled with that value. So if c returns a non-Promise, that return value becomes the value of p, p is fulfilled and we are done. But if the return value v is itself a Promise, then p is resolved but not yet fulfilled. At this stage, p cannot settle until the Promise v settles. If v is fulfilled, then p will be fulfilled to the same value. If v is rejected, then p will be rejected for the same reason.
![[Screen Shot 2023-04-15 at 3.48.04 AM.png]]
---
Now suppose that transient network load issues are causing this to fail about 1% of the time. A simple solution might be to retry the query with a .catch() call:

```js
queryDatabase()
	.catch(e => wait(500).then(queryDatabase)) // On failure, wait and retry 
	.then(displayTable)
	.catch(displayDatabaseError);
```

If the hypothetical failures are truly random, then adding this one line of code should reduce your error rate from 1% to .01%.

---
## Returning from a Promise Callback

* Let’s return one last time to the earlier URL-fetching example, and consider the c1 callback that we passed to the first .then() invocation. Notice that there are three ways that c1 can terminate. It can return normally with the Promise returned by the .json() call. This causes p2 to be resolved, but whether that Promise is fulfilled or rejected depends on what happens with the newly returned Promise. c1 can also return normally with the value null, which causes p2 to be fulfilled immediately. Finally, c1 can terminate by throwing an error, which causes p2 to be rejected. These are the three possible outcomes for a Promise.
* In a Promise chain, the value returned (or thrown) at one stage of the chain becomes the input to the next stage of the chain, so it is critical to get this right. In practice, forgetting to return a value from a callback function is actually a common source of Promise-related bugs, and this is exacerbated by JavaScript’s arrow function shortcut syntax. Consider this line of code that we saw earlier:
```js
.catch(e => wait(500).then(queryDatabase))
```

```js
.catch(e => { wait(500).then(queryDatabase) })
```

- By adding the curly braces, we no longer get the automatic return. This function now returns undefined instead of returning a Promise, which means that the next stage in this Promise chain will be invoked with undefined as its input rather than the result of the retried query. It is a subtle error that may not be easy to debug.


## Promises in Parallel

- The function `Promise.all()` can do this. Promise.all() takes an array of Promise objects as its input and returns a Promise. The returned Promise will be `rejected` if any of the input Promises are `rejected`. Otherwise, it will be `fulfilled` with an array of the fulfillment values of each of the input `Promises`

```js
// We start with an array of URLs
const urls = [ /* zero or more URLs here */ ];
// And convert it to an array of Promise objects
promises = urls.map(url => fetch(url).then(r => r.text()));
// Now get a Promise to run all those Promises in parallel
Promise.all(promises)
	.then(bodies => { /* do something with the array of strings */})
	.catch(e => console.error(e));
```

- In ES2020, Promise.allSettled() takes an array of input Promises and returns a Promise, just like Promise.all() does. But Promise.allSettled() never rejects the returned Promise, and it does not fulfill that Promise until all of the input Promises have settled. The Promise resolves to an array of objects, with one object for each input Promise. Each of these returned objects has a status property set to “fulfilled” or “rejected.” If the status is “fulfilled”, then the object will also have a value property that gives the fulfillment value. And if the status is “rejected”, then the object will also have a reason property that gives the error or rejection value of the corresponding Promise
```js
Promise.allSettled([Promise.resolve(1), Promise.reject(2), 3]).then(
	results => {
		results[0] // => { status: "fulfilled", value: 1 }
		results[1] // => { status: "rejected", reason: 2 }
		results[2] // => { status: "fulfilled", value: 3 }
	}
);
```

- Occasionally, you may want to run a number of Promises at once but may only care about the value of the first one to fulfill. In that case, you can use `Promise.race()` instead of Promise.all(). `It returns a Promise that is fulfilled or rejected when the first of the Promises in the input array is fulfilled or rejected.` (Or, if there are any non-Promise values in the input array, it simply returns the first of those.)
```js
Promise.race([promise1, promise2]).then(result => {
  console.log(result); // 'promise2 resolved'
}).catch(error => {
  console.log(error);
});
```

## Making Promises

#### Promises based on other Promises

```js
function getJSON(url) {
	return fetch(url).then(response => response.json());
}

function getHighScore() {
	return getJSON("/api/user/profile").then(profile => profile.highScore);
}
```

#### Promises from scratch

```js
function wait(duration) {
	// Create and return a new Promise
	return new Promise((resolve, reject) => {
		// These control the Promise 
		// If the argument is invalid, reject the Promise
		if (duration < 0) {
			reject(new Error("Time travel not yet implemented"));
		} // Otherwise, wait asynchronously and then resolve the Promise.
		// setTimeout will invoke resolve() with no arguments, which means
		// that the Promise will fulfill with the undefined value. 
		setTimeout(resolve, duration);
	});
}
```

```js
const http = require("http");

function getJSON(url) {
	// Create and return a new Promise
	return new Promise((resolve, reject) => { // Start an HTTP GET request for the specified URL 


		request = http.get(url, response => { // called when response starts 
			// Reject the Promise if the HTTP status is wrong
			if (response.statusCode !== 200) {
				reject(new Error(`HTTP status ${response.statusCode}`));
				response.resume(); // so we don't leak memory
			}
			// And reject if the response headers are wrong
			else if (response.headers["content-type"] !== "application/json") { 
				reject(new Error("Invalid content-type"));
				response.resume(); // don't leak memory
			} else {
				// Otherwise, register events to read the body of the response
				let body = "";
				response.setEncoding("utf-8");
				response.on("data", chunk => { body += chunk; });
				response.on("end", () => {
					// When the response body is complete,try to parse it
					try {
						let parsed = JSON.parse(body);
						// If it parsed successfully, fulfill the Promise
						resolve(parsed);
					} catch(e) {
						// If parsing failed, reject the Promise
						reject(e);
					}	
				});
			}
		});


		// We also reject the Promise if the request fails before we // even get a response (such as when the network is down)
		request.on("error", error => { 
			reject(error);
		});
	});
}
```


## Promises in Sequence ??


## async and await

- The `await` keyword takes a Promise and turns it back into a return value or a thrown exception. Given a Promise object p, the expression await p waits until p settles. If p fulfills, then the value of await p is the fulfillment value of p. On the other hand, if p is rejected, then the await p expression throws the rejection value of p. We don’t usually use await with a variable that holds a Promise; instead, we use it before the invocation of a function that returns a Promise

```js
let response = await fetch("/api/user/profile");
let profile = await response.json();
```

- It is critical to understand right away that the await keyword does not cause your program to block and literally do nothing until the specified Promise settles. The code remains asynchronous, and the await simply disguises this fact. This means that any code that uses await is itself asynchronous.

---

- Because any code that uses await is asynchronous, there is one critical rule: `you can only use the await keyword within functions that have been declared with the async keyword.` Here’s a version of the getHighScore() function from earlier in the chapter, rewritten to use async and await.
```js
async function getHighScore() {
	let response = await fetch("/api/user/profile");
	let profile = await response.json(); return profile.highScore;
}
```

- Declaring a function `async` means that the return value of the function will be a Promise even if no Promise-related code appears in the body of the function
- You can use the `async` keyword with any kind of function. It works with the function keyword as a statement or as an expression. It works with arrow functions and with the method shortcut form in classes and object literals. (See Chapter 8 for more about the various ways to write functions.)

#### Awaiting Multiple Promises

```js
let value1 = await getJSON(url1);
let value2 = await getJSON(url2);


// => 
let [value1, value2] = await Promise.all([getJSON(url1), getJSON(url2)]);
```


## The for/await Loop

```js
const fs = require("fs");
async function parseFile(filename) {
	let stream = fs.createReadStream(filename, { encoding: "utf-8"});
	for await (let chunk of stream) {
		parseChunk(chunk); // Assume parseChunk() is defined elsewhere
	} 
}


for(const promise of promises) {
	response = await promise;
	handle(response);
}

// <=>

for await (const response of promises) {
	handle(response);
}

```


## Asynchronous Iterators And Asynchronous Generators

- Let’s review some terminology from Chapter 12. An iterable object is one that can be used with a for/of loop. It defines a method with the symbolic name Symbol.itera tor. This method returns an iterator object. The iterator object has a next() method, which can be called repeatedly to obtain the values of the iterable object. The next() method of the iterator object returns iteration result objects. The iteration result object has a value property and/or a done property.
- Asynchronous iterators are quite similar to regular iterators, but there are two important differences. First, an asynchronously iterable object implements a method with the symbolic name `Symbol.asyncIterator` instead of `Symbol.iterator`. (As we saw earlier, `for/await` is compatible with regular iterable objects but it prefers asynchronously iterable objects, and tries the Symbol.asyncIterator method before it tries the Symbol.iterator method.) Second, the next() method of an asynchronous iterator returns a Promise that resolves to an iterator result object instead of returning an iterator result object directly.

```js
async function* clock(interval, max=Infinity) {
	for(let count = 1; count <= max; count++) { // regular for loop await 
		elapsedTime(interval); // wait for time to pass
		yield count; 
	}
}

// A test function that uses the async generator with for/await 
async function test() {
	// Async so we can use for/await
	for await (let tick of clock(300, 100)) { // Loop 100 times every 300ms 
		console.log(tick);
	}
}


//clock using iterator

function clock(interval, max=Infinity) {
	// A Promise-ified version of setTimeout that we can use await with.
	// Note that this takes an absolute time instead of an interval.
	function until(time) {
		return new Promise(resolve => setTimeout(resolve, time - Date.now()));
	}
	// Return an asynchronously iterable object
	return {
		startTime: Date.now(), // Remember when we started
		
		count: 1, // Remember which iteration we're on
		
		async next() { // The next() method makes this an iterator 
			if (this.count > max) { // Are we done?
				return { done: true }; // Iteration result indicating done
			}
			// Figure out when the next iteration should begin,
			let targetTime = this.startTime + this.count * interval; 
			// wait until that time, 
			await until(targetTime);
			// and return the count value in an iteration result object.
			return { value: this.count++ };
		},
		// This method means that this iterator object is also an iterable. 
		[Symbol.asyncIterator]() { return this; }
	};
}

```