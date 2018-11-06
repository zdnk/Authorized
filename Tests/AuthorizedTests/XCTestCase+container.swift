import XCTest
import Vapor
import Authentication
@testable import Authorized

extension XCTestCase {

    internal func container() throws -> Container {
        var services = Services.default()
        services.register(
            PermissionManager(),
            as: PermissionVerifying.self
        )
        try services.register(AuthenticationProvider())
        let worker = EmbeddedEventLoop()
        
        return BasicContainer(
            config: Config.default(),
            environment: .testing,
            services: services,
            on: worker
        )
    }
    
}
