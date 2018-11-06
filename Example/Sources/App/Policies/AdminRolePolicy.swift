import Vapor
import Authorized

struct AdminRolePolicy: Policy {
    
    func configure(in config: PermissionDefining) throws {
        config.before { (_, _, anyUser, container) -> EventLoopFuture<PermissionResolution?> in
            guard let user = anyUser as? User else {
                return container.future(nil)
            }
            
            if user.role == .admin {
                // Admins can do anything!
                return container.future(.allow)
            }
            
            return container.future(nil)
        }
        
    }
    
}
