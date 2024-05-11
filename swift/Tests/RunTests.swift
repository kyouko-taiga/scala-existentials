import XCTest
@testable import Rays

class RunTests: XCTestCase {
    func testRun256() {
        XCTAssertEqual(Rays.run(shapeCount: 256), 2)
    }

    func testRun512() {
        XCTAssertEqual(Rays.run(shapeCount: 512), 12)
    }

    func testRun768() {
        XCTAssertEqual(Rays.run(shapeCount: 768), 26)
    }
}
