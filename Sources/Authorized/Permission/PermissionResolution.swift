import Foundation

public enum PermissionResolution {
    
    case allow
    case deny
    
    public var isAllow: Bool {
        return self == .allow
    }
    
    public var isDeny: Bool {
        return self == .deny
    }
    
}
