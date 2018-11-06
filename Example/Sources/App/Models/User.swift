import FluentSQLite
import Vapor

struct User: SQLiteModel {
    
    var id: Int?
    let username: String
    
}

extension User: Migration { }
