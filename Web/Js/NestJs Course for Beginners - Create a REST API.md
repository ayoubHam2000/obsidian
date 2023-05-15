## NestJs

NestJS is a popular open-source Node.js framework that is used to build scalable, efficient, and maintainable server-side applications. It is built with TypeScript and leverages modern JavaScript features such as decorators and async/await.

NestJS provides a modular architecture that is highly testable and easy to maintain. It is heavily inspired by Angular, which means that it uses a similar dependency injection system and component-based structure.

NestJS also provides out-of-the-box support for a variety of databases, including MongoDB, MySQL, and PostgreSQL, and it can be easily extended to support other databases as well.

One of the key features of NestJS is its support for WebSockets and real-time applications. It also provides a built-in GraphQL module that makes it easy to build GraphQL APIs.

Overall, NestJS is a powerful and versatile framework that is suitable for a wide range of server-side applications.

## Why NestJs

There are several reasons why developers might choose to use NestJS for building their server-side applications:

1.  TypeScript: NestJS is built with TypeScript, which brings several benefits such as static typing, better code readability, and easier maintenance.
    
2.  Modular architecture: NestJS provides a modular architecture that makes it easy to organize code and keep it maintainable as the application grows in complexity.
    
3.  Dependency injection: NestJS uses a dependency injection system that allows developers to easily manage dependencies and make their code more testable and reusable.
    
4.  Extensibility: NestJS is highly extensible, which means that developers can easily add new functionality and integrate with other libraries and services.
    
5.  Built-in support for WebSockets and GraphQL: NestJS provides built-in support for WebSockets and GraphQL, which makes it easier to build real-time applications and APIs.
    
6.  Community support: NestJS has a large and active community that provides support, documentation, and contributions to the framework.

## Install And setup

```
npm install -g @nestjs/cli
nest new project-name

to run 

npm run start:dev

```


- generate a module
```
nest g module module_name

nest g service prisma --no-spec

```



## decorator

In programming, a decorator is a language feature that allows you to add behavior or metadata to a class, method, property, or parameter at runtime, without modifying the original code.

In TypeScript and JavaScript, decorators are implemented as functions that can be applied to target objects using the `@decorator` syntax. When a decorator is applied to a target object, it typically modifies the object in some way, such as adding new properties or methods, or wrapping the object in a new wrapper object.

Decorators are commonly used in many modern web frameworks and libraries, including `Angular`, `NestJS`, and `React`, to add additional functionality to components or services. For example, in `NestJS`, decorators are used to mark classes and methods as controllers or providers, to define HTTP routes, to inject dependencies, and more.

Here's an example of how to define and use a simple decorator in TypeScript:
```ts
function log(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;

  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${propertyKey} with arguments: ${args}`);
    return originalMethod.apply(this, args);
  };

  return descriptor;
}

class MyClass {
  @log
  myMethod(arg1: string, arg2: number) {
    console.log(`Inside myMethod with arguments: ${arg1}, ${arg2}`);
  }
}

const obj = new MyClass();
obj.myMethod('hello', 42);

```


## Prisma ORM

```
npm install prisma --save-dev
npm install @prisma/client --save-dev
npx prisma init

npx prisma migrate dev



create, filter the result 
credential code

```

## 

//decorator in nest @Body, @Req, @Injectable, @Controller, @Module, @Global
//Module
//dependcies injection
//controllers ans service providres
//prisma
//dto
//class-validator class-transformer
//argon2 hash
//seassions or JWT | nest js jwt 


```
lib

npm install @nestjs/config

npm install --save @nestjs/passport passport passport-local
npm install --save @nestjs/jwt passport-jwt
npm install --save-dev @types/passport-jwt 

```