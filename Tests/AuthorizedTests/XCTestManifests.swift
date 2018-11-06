import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PermissionManagerTests.allTests),
        testCase(PRequestTests.allTests),
    ]
}
#endif
