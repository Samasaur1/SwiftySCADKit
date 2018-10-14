import XCTest

extension SwiftySCADKitTests {
    static let __allTests = [
        ("testExample", testExample),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftySCADKitTests.__allTests),
    ]
}
#endif
