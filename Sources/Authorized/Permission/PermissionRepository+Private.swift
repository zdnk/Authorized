import Foundation

extension PermissionRepository {
    
    internal func addIfExists(_ id: String, in collection: Collection, to output: inout [Permission]) {
        if let permission = collection[id] {
            output.append(permission)
        }
    }
    
}
