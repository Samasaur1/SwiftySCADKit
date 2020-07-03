import XCTest
@testable import SwiftySCADKit

final class SwiftySCADKitTests: XCTestCase {
    func testExample() {
        dump(skad(of: Test()))
        print(parse(scad: Test()))
    }
}
