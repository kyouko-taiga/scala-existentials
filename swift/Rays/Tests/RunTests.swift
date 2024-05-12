import XCTest
@testable import RaysExistential

class RunTests: XCTestCase {
    func testRun256() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 256), 2)
    }

    func testRun512() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 512), 12)
    }

    func testRun768() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 768), 26)
    }
}
