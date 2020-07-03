import XCTest
@testable import SwiftySCADKit

final class SwiftySCADKitTests: XCTestCase {
    func testExample() {
        dump(SomeSCAD().skad)
        print(parse(skad: SomeSCAD().skad))
    }
}
