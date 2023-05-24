https://www.youtube.com/watch?v=2-crBg6wpp0&t=26279s
https://github.com/john-smilga/react-course-v3

[[react_tableOfContent]]



[[01-fundamentals]]
[[02-TUTORIAL]]

```js
@Names
 * jsx
 * css
 * back to js {}
 * React.Fragment
 * props
 * children in props
 * key prop
 * events
	 * event object (e)
	 * preventDefault
 * vite
 * useState
 * useEffect
 * fetch data (fetch, axios)
 * formData
 * useRef
 * Custom Hooks
 * Context -> createContext/useContext
 * useReducer
 * Performance
	 * Lower State
	 * memo, useCallBack
	 * useTransition
	 * lazy and Suspense
 * -


@Commands
	* npx create-react-app@latest nameOfTheApp
	* npm create vite@latest

@Libraries
	* axios
	* vanila js

@Globla_libraries

@vscode extension
	* auto rename tag
	* prettier
	* ES7+React
	* spell checker
	* glean


```


## Memo

In React, a memo is a higher-order component (HOC) or a hook that is used to optimize the performance of functional components by preventing unnecessary re-renders. It is primarily used in scenarios where a component's props or state changes frequently but the output of the component remains the same.

When a component is wrapped with the `memo` HOC or `useMemo` hook, React performs a shallow comparison between the previous and current props of the component. If the props haven't changed, React skips the re-rendering process, thus saving valuable computation time.

```js
import React, { memo } from 'react';

const MyComponent = memo(({ prop1, prop2 }) => {
  // Component logic and JSX rendering
  return (
    <div>
      <p>{prop1}</p>
      <p>{prop2}</p>
    </div>
  );
});

export default MyComponent;

```

## useCallback

`useCallback` is a hook in React that is used to memoize a function, similar to how `memo` memoizes a component. It's useful when you want to prevent unnecessary re-creations of a function, particularly in scenarios where the function is passed as a prop to child components.

The `useCallback` hook takes two arguments: the function you want to memoize and an array of dependencies. It returns a memoized version of the function that only changes if any of the dependencies in the array change. If none of the dependencies change, `useCallback` returns the previously memoized function.

```js
import React, { useCallback } from 'react';

const MyComponent = () => {
  const handleClick = useCallback(() => {
    // Handle click logic
    console.log('Button clicked');
  }, []);

  return (
    <div>
      <button onClick={handleClick}>Click Me</button>
    </div>
  );
};

export default MyComponent;

```

## useTransition

`useTransition` is a hook introduced in React version 18 that allows you to add smooth transitions to your application when updating the state. It helps to create a smoother user experience by indicating that a state change is in progress and allowing the UI to remain responsive during the transition.

The `useTransition` hook returns an array with two elements: a boolean value and a function. The boolean value (`isPending`) represents whether a transition is currently in progress, while the function (`startTransition`) is used to initiate a transition.

```js
import React, { useState, useTransition } from 'react';

const MyComponent = () => {
  const [count, setCount] = useState(0);
  const [isPending, startTransition] = useTransition();

  const handleClick = () => {
    startTransition(() => {
      setCount(count + 1);
    });
  };

  return (
    <div>
      <p>Count: {count}</p>
      <button disabled={isPending} onClick={handleClick}>
        Increment
      </button>
    </div>
  );
};

export default MyComponent;

```


## lazy, and Suspence

`lazy` and `Suspense` are two features introduced in React that help with code splitting and lazy loading of components. They are primarily used to optimize the initial loading time of your application by splitting the bundle into smaller chunks and loading components on-demand.

`lazy` is a function that allows you to dynamically import a component. It enables you to split your code into separate bundles, which are loaded asynchronously when needed. By doing so, you can reduce the size of the initial bundle, leading to faster loading times. Here's an example of how to use `lazy`:

```js
import React, { lazy, Suspense } from 'react';

const MyLazyComponent = lazy(() => import('./MyLazyComponent'));

const MyComponent = () => (
  <div>
    <Suspense fallback={<div>Loading...</div>}>
      <MyLazyComponent />
    </Suspense>
  </div>
);

export default MyComponent;

```

In this example, the `lazy` function is used to dynamically import the `MyLazyComponent` from the `'./MyLazyComponent'` module. The `Suspense` component is then used to wrap the lazy-loaded component. The `fallback` prop of `Suspense` specifies what to render while the lazy-loaded component is being fetched.

With this setup, when `MyComponent` is rendered, the `MyLazyComponent` is not loaded immediately. Instead, it is loaded asynchronously in the background. During the loading process, the fallback UI specified in `Suspense` is rendered. Once the lazy-loaded component is available, React renders it.

By using `lazy` and `Suspense`, you can split your code into smaller chunks and load components on-demand, improving the initial loading time of your application.

It's important to note that the `lazy` function can only be used with default exports and not with named exports. Additionally, code splitting with `lazy` and `Suspense` requires a module bundler that supports dynamic imports, such as Webpack.

It's worth mentioning that `Suspense` is not limited to code splitting with `lazy` components. It can also be used with other asynchronous operations like data fetching to provide a loading state for those operations.