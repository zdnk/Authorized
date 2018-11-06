import FluentSQLite
import Vapor
import Authorized
import Authentication

struct User: SQLiteModel {
    
    enum Role: String, SQLiteEnumType {
        
        static func reflectDecoded() throws -> (User.Role, User.Role) {
            return (.regular, .moderator)
        }
        
        case regular
        case moderator
    }
    
    var id: Int?
    let username: String
    var role: Role
    
}

extension User: Authorizable, Authenticatable {}

extension User: Migration { }
