import XCTest
@testable import Rays

class RandomTests: XCTestCase {
    func testNextUInt() {
        var random = Rays.Random(seed: 0xACE1)
        XCTAssertEqual(random.nextUInt64(), 12688341390083949198)
        XCTAssertEqual(random.nextUInt64(), 5684655011191448823)
    }
    
    func testNextDoubleBetweenZeroAndOne() {
        var random = Rays.Random(seed: 0xACE1)
        XCTAssertEqual(random.nextDoubleBetween(min: 0.0, max: 1.0), 0.37775111511306003, accuracy: 1e-15)
        XCTAssertEqual(random.nextDoubleBetween(min: 0.0, max: 1.0), 0.24697609510468316, accuracy: 1e-15)
    }

    func testNextDoubleBetweenZeroAndFortyTwo() {
        var random = Rays.Random(seed: 0xACE1)
        XCTAssertEqual(random.nextDoubleBetween(min: 0.0, max: 42.0), 15.865546834748521, accuracy: 1e-15)
        XCTAssertEqual(random.nextDoubleBetween(min: 0.0, max: 42.0), 10.372995994396693, accuracy: 1e-15)
    }

    func testNextDoubleBetweenNegativeTwoAndTwo() {
        var random = Rays.Random(seed: 0xACE1)
        XCTAssertEqual(random.nextDoubleBetween(min: -2.0, max: 2.0), -0.48899553954775987, accuracy: 1e-15)
        XCTAssertEqual(random.nextDoubleBetween(min: -2.0, max: 2.0), -1.0120956195812674, accuracy: 1e-15)
    }

}
