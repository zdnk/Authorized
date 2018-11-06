import FluentSQLite
import Vapor

struct Post: SQLiteModel {
    var id: Int?
    var title: String
    let authorId: User.ID
}

extension Post: Migration { }

extension Post: Content { }

extension Post: Parameter { }
