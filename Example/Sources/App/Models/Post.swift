import FluentSQLite
import Vapor

struct Post: SQLiteModel {
    var id: Int?
    var title: String
    var content: String
    var category: String
    let authorId: User.ID
}

extension Post: Migration { }

extension Post: Content { }

extension Post: Parameter { }

extension Post {
    
    struct Input: Content {
        
        let title: String
        let content: String
        let category: String
        
    }
    
    static func from(input: Input, author: User) throws -> Post {
        return Post(
            id: nil,
            title: input.title,
            content: input.content,
            category: input.category,
            authorId: try author.requireID()
        )
    }
    
}
