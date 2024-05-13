import XCTest
@testable import RaysExistential

class RunTests: XCTestCase {
    func testRun192() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 192), 1)
    }

    func testRun193() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 193), 2)
    }

    func testRun256() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 256), 2)
    }

    func testRun512() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 512), 12)
    }

    func testRun525() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 525), 13)
    }

    func testRun550() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 550), 14)
    }

    func testRun575() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 575), 15)
    }

    func testRun587() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 587), 15)
    }

    func testRun592() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 592), 15)
    }

    func testRun596() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 596), 15)
    }

    func testRun597() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 597), 16)
    }

    func testRun598() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 598), 16)
    }

    func testRun600() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 600), 16)
    }

    func testRun700() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 700), 21)
    }

    func testRun768() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 768), 26)
    }

    func testRun1024() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 1024), 49)
    }

    func testRun2048() {
        XCTAssertEqual(RaysExistential.run(shapeCount: 2048), 155)
    }
}
