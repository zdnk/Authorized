import FluentSQLite
import Vapor
import Authorized
import Authentication

struct User: SQLiteModel {
    
    var id: Int?
    let username: String
    
}

extension User: Authorizable, Authenticatable {}

extension User: Migration { }
