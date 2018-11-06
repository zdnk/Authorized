import FluentSQLite
import Vapor

struct Post: SQLiteModel {
    var id: Int?
    var title: String
    var content: String
    let authorId: User.ID
}

extension Post: Migration { }

extension Post: Content { }

extension Post: Parameter { }

extension Post {
    
    struct Input: Content {
        
        let title: String
        let content: String
        
    }
    
    static func from(input: Input, author: User) throws -> Post {
        return Post(
            id: nil,
            title: input.title,
            content: input.content,
            authorId: try author.requireID()
        )
    }
    
}
