import Vapor

final class PostsController {

    func index(_ req: Request) throws -> Future<[Post]> {
        return Post.query(on: req).all()
    }

    func create(_ req: Request) throws -> Future<Post> {
        return try req.content.decode(Post.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Post.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}
