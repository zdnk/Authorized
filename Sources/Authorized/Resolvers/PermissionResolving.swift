import Foundation
import Vapor

public protocol PermissionResolving {
    
    func resolve<R, U>(target: ResourceTarget<R>, user: U, on: Container) throws -> Future<PermissionResolution> where R: Resource, U: Authorizable
    
}
