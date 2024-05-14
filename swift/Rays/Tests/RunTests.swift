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

    for (shapeCount, expectedOutput) in testCases {
      var worldExistential = RaysExistential.initialWorld(shapeCount: shapeCount)
      XCTAssertEqual(RaysExistential.run(world: &worldExistential), expectedOutput, "Failed for input \(shapeCount)")

      var worldInheritance = RaysInheritance.initialWorld(shapeCount: shapeCount)
      XCTAssertEqual(RaysInheritance.run(world: &worldInheritance), expectedOutput, "Failed for input \(shapeCount)")
    }
  }
}
