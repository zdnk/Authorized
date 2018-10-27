import XCTest

import AuthorizationTests

var tests = [XCTestCaseEntry]()
tests += AuthorizationTests.allTests()
XCTMain(tests)