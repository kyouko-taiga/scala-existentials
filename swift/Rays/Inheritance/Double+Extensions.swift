extension Double {

  func isEqual(to other: Double, withTolerance tolerance: Double) -> Bool {
    abs(self - other) <= tolerance
  }

  static var defaultTolerance: Double { 0.001 }

}
