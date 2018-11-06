import Vapor
import Authorized

struct AdminRolePolicy: Policy {
    
    func configure(in config: PermissionDefining) throws {
        config.before { (context) -> EventLoopFuture<PermissionResolution?> in
            guard let user = context.user as? User else {
                return context.container.future(nil)
            }
            
            if user.role == .admin {
                // Admins can do anything!
                return context.container.future(.allow)
            }
            
            return context.container.future(nil)
        }
        
    }
    
}
