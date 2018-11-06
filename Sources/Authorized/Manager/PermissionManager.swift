import Vapor

open class PermissionManager: PermissionVerifying {

    internal typealias BeforeClosure = (Any, Any, Any, Container) throws -> Future<PermissionResolution?>
    
    internal var repository: PermissionRepository
    internal var beforeClosures: [BeforeClosure] = []
    
    public required init(repository: PermissionRepository) {
        self.repository = repository
    }
    
    public convenience init() {
        self.init(repository: PermissionRepository())
    }
    
    open func allowed<R, A>(_ target: ResourceTarget<R>, _ action: R.Action, as user: A, on container: Container) -> Future<Bool> where R : Resource, A : Authorizable {
        
        var beforeFutures: [Future<PermissionResolution?>] = []
        
        do {
            try beforeClosures.forEach { closure in
                let future = try closure(target, action, user, container)
                beforeFutures.append(future)
            }
        } catch {
            return container.future(false)
        }
        
        return beforeFutures
            .flatten(on: container)
            .map { results -> PermissionResolution? in
                if results.contains(.deny) {
                    return .deny
                }
                
                if results.contains(.allow) {
                    return .allow
                }
                
                return nil
            }
            .flatMap { result -> Future<PermissionResolution> in
                if let result = result {
                    return container.future(result)
                }
                
                let permissions = self.permissions(
                    action: action.actionIdentifier,
                    resource: R.resourceIdentifier,
                    user: user,
                    instance: target.isInstance
                )
                
                return self.resolve(
                    permissions,
                    target: target,
                    user: user,
                    on: container
                )
            }
            .map { resolution -> Bool in
                return resolution.isAllow
            }
    }
    
}
