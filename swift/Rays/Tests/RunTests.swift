import XCTest
@testable import RaysExistential
@testable import RaysInheritance

class RunTests: XCTestCase {
  func test() {
    continueAfterFailure = true

    let testCases = [
      192: 1,
      193: 2,
      256: 2,
      512: 12,
      525: 13,
      550: 14,
      575: 15,
      587: 15,
      592: 15,
      596: 15,
      597: 16,
      598: 16,
      600: 16,
      700: 21,
      768: 26,
      1024: 49,
      2048: 155
    ]

    for (input, expectedOutput) in testCases {
      XCTAssertEqual(RaysExistential.run(shapeCount: input), expectedOutput, "Failed for input \(input)")
      XCTAssertEqual(RaysInheritance.run(shapeCount: input), expectedOutput, "Failed for input \(input)")
    }
  }
}
