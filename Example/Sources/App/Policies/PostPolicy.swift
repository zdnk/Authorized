import Vapor
import Authorized

extension Post: Resource {
    
    enum Action: String, ResourceAction {
        case list
        case create
        case delete
    }
    
}

struct PostPolicy: ResourcePolicy {
    
    func rules() -> ResourceRules<Post> {
        var rules = ResourceRules<Post>()
        rules.add(self.list, for: .list)
        rules.add(self.create, for: .create)
        rules.add(self.delete, for: .delete)
        return rules
    }
    
    func list(as user: User, on container: Container) -> Future<PermissionResolution> {
        return container.future(.allow)
    }
    
    func create(post: Post, as user: User, on container: Container) -> Future<PermissionResolution> {
        // Deny regular users to create posts in "top" category
        if user.role == .regular && post.category.lowercased() == "top" {
            return container.future(.deny)
        }
        
        return container.future(.allow)
    }
    
    func delete(post: Post, as user: User, on container: Container) throws -> Future<PermissionResolution> {
        // Allow moderators to delete any post
        if user.role == .moderator {
            return container.future(.allow)
        }
        
        let allowed = try post.authorId == user.requireID()
        return container.future(allowed ? .allow : .deny)
    }
    
}
