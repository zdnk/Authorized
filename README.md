# 🔐 Authorized

Vapor 3 package to define permissions and authorize authenticated users to do actions on resources.

## Installation

### Swift Package Manager

Add the package to your dependencies in `Package.swift`

```swift
.package(url: "https://github.com/zdnk/Authorized.git", .branch("master"))
```

and in Terminal run `swift package resolve`.

If you are using Xcode for development: `swift package generate-xcodeproj`.

## Usage

Everything begins with:
```swift
import Authorized
```

### Define resources and actions (or extend models)

```swift
struct Post: Resource { // Probably also conforms to Fluent.Model

    enum Action: ResourceAction {
        case create
        case delete
    }

    var id: Int?
    let authorId: User.ID

}
```

### Define user (or extend existing)

```swift
struct User: Authorizable { // Probably also conforms to Fluent.Model and Authenticatable

    var id: Int?
    let username: String

}
```

### Write policies

```swift
struct PostPolicy: ResourcePolicy {

    typealias Model = Post

    // This function is required to return the policy configuration.
    // Think of it as a mapping of actions to functions
    func definition() -> ResourcePolicyDefinition<Post> {
        var config = ResourcePolicyDefinition<Post>()
        config.action(.create, to: self.create)
        config.action(.delete, to: self.delete)
        return config
    }

    // Define functions that will resolve the permission

    func create(as user: User, on container: Container) -> Future<PermissionResolution> {
        // Allow everyone to create Posts
        return container.future(.allow)
    }

    func delete(post: Post, as user: User, on container: Container) -> Future<PermissionResolution> {
        // Allow only authors of the post to delete them
        let result = post.authorId == user.id
        return container.future(result ? .allow : .deny)
    }

}
```

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

One possible way can be like the example below, for more options, please check the API section.

```swift
/// DELETE /posts/{id}
func delete(_ req: Request) -> Future<HTTPStatus> {
    return req.parameters.next(Post.self)
        // Check if there is someone authenticated of type User,
        // and verify if this specific User has permission
        // to remove this specific Post
        .authorize(.delete, as: User.self, on: req) // returns Future<Post>
        .flatMap { post in
            return post.delete(on: req)
        }
        .transform(to: HTTPStatus.noContent)
}
```

or

```swift
/// DELETE /posts/{id}
func delete(_ req: Request) -> Future<HTTPStatus> {
    let user = try self.requireAuthenticated(User.self)
    
    return req.parameters.next(Post.self)
        .authorize(.delete, as: user, on: req) // returns Future<Post>
        .flatMap { post in
            return post.delete(on: req)
        }
        .transform(to: HTTPStatus.noContent)
}
```

In both examples we are using Vapors `Authentication` library so the `User` needs to conform to `Authenticatable`.

## API

### Extensions

There are several extensions available on Vapors and Swift NIOs types to help you easily authorize users and actions on resources.

#### `Request` from Vapor

```swift
extension Request {

    public func authorize<A, R>(_: A.Type, _ resource: R, _ action: R.Action) throws -> Future<R> where A : Authenticatable, A : Authorizable, R : Resource

    public func authorize<A, R>(_ user: A, _ resource: R, _ action: R.Action) throws -> Future<R> where A : Authorizable, R : Resource

    public func authorize<A, R>(_: A.Type, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A : Authenticatable, A : Authorizable, R : Resource

    public func authorize<A, R>(_ user: A, _ resource: R.Type, _ action: R.Action) throws -> Future<Void> where A : Authorizable, R : Resource

}
```

#### `Future<T: Resource>` from Swift NIO

```swift
extension EventLoopFuture where T : Resource {

    public func authorize<A>(_ action: T.Action, as user: A, on container: Container) -> Future<T> where A : Authorizable

    public func authorize<A>(_ action: T.Action, as user: A.Type, on request: Request) -> Future<T> where A : Authenticatable, A : Authorizable

}
```
#### `Authorizable` from Authorized

```swift
extension Authorizable {

    public func can<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Bool> where R : Resource

    public func authorize<R>(_: R.Type, _ action: R.Action, on container: Container) throws -> Future<Void> where R : Resource

    public func can<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<Bool> where R : Resource

    public func authorize<R>(_ resource: R, _ action: R.Action, on container: Container) throws -> Future<R> where R : Resource

}
```
