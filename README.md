# Authorized

Vapor 3 package to define permissions and authorize authenticated users to do actions on resources.

## Usage

### Define resources and actions

### Write your policy definitions

### Register the policies

You need to register the service in your `configure.swift`.

```swift
// Initialize configuration - needs to be mutable (var)
var permissionConfig = PermissionsConfig()

// Add policies to the configuration
permissionConfig.add(policy: PostPolicy())

// Now register the configuration to the services
try services.register(permissionConfig)
```

### Authorize actions in your controllers 

## API

### Extensions

There are several extensions available on Vapors and Swift NIOs types to help you easily authorize users and actions on resources.

#### `Request`

```swift
extension Request {

    public func authorize<A, R>(_: A.Type, _ resource: R, _ action: R.Action) throws -> Future<R> where A : Authenticatable, A : Authorizable, R : Resource

    public func authorize<A, R>(_ user: A, _ resource: R, _ action: R.Action) throws -> Future<R> where A : Authorizable, R : Resource

    public func authorize<A, R>(_: A.Type, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A : Authenticatable, A : Authorizable, R : Resource

    public func authorize<A, R>(_ user: A, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A : Authorizable, R : Resource

}
```

#### `Future<T: Resource>`

```swift
extension EventLoopFuture where T : Resource {

    public func authorize<A>(_ action: T.Action, as user: A, on container: Container) -> Future<T> where A : Authorizable

    public func authorize<A>(_ action: T.Action, as user: A.Type, on request: Request) -> Future<T> where A : Authenticatable, A : Authorizable

}
```
#### `Authorizable`

```swift
extension Authorizable {

    public func can<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Bool> where R : Resource

    public func authorize<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Void> where R : Resource

    public func can<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<Bool> where R : Resource

    public func authorize<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<R> where R : Resource

}
```
