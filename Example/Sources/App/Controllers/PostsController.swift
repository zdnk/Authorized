import Vapor

final class PostsController {

    func index(_ req: Request) throws -> Future<[Post]> {
        return try req.authorize(User.self, Post.self, .list)
            .flatMap { _ in
                return Post.query(on: req).all()
            }
    }

    func create(_ req: Request) throws -> Future<Post> {
        let user = try req.requireAuthenticated(User.self)
        
        return try req.authorize(user, Post.self, .create)
            .flatMap { _ in
                return try req.content.decode(Post.Input.self)
            }
            .map { input in
                return try Post.from(input: input, author: user)
            }
            // Authorize can be called even here as in `delete` example below
            .flatMap { post in
                return post.save(on: req)
            }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Post.self)
            .authorize(.delete, as: User.self, on: req)
            .flatMap { todo in
                return todo.delete(on: req)
            }.transform(to: .ok)
    }
    
}
