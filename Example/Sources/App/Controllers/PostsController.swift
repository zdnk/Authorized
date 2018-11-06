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
        
        return try req.content.decode(Post.self)
            .authorize(.create, as: user, on: req)
            .flatMap { todo in
                return todo.save(on: req)
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
