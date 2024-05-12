/// A 4x4 matrix.
public struct Matrix4 {

  /// The representation of a column of a 4x4 matrix.
  public typealias Column = (Double, Double, Double, Double)

  /// The components of the matrix.
  ///
  /// The matrix is in column-major order. Contents are represented by 16 scalar values laid out
  /// contiguously in memory. Each consecutive set of 4 values is a column.
  public var columns: (Column, Column, Column, Column)

  /// Initializes a 4x4 matrix with zeros.
  public init() {
    self.columns = ((0, 0, 0, 0), (0, 0, 0, 0), (0, 0, 0, 0), (0, 0, 0, 0))
  }

  /// Initializes a rotation matrix.
  public init(rotation: Quaternion) {
    self = rotation.transform
  }

  /// Initializes a 4x4 matrix with its components in column-major order.
  ///
  /// - Requires: `components` contains exactly 16 elements.
  public init<S: Sequence<Double>>(columnMajorComponents components: S) {
    self.init()
    withContiguousMutableStorage { (storage) in
      var s = components.makeIterator()
      for i in 0 ..< 16 { storage[i] = s.next()! }
      precondition(s.next() == nil)
    }
  }

  /// Accesses the component at given index.
  public subscript(i: Int) -> Double {
    get {
      precondition((0 <= i) && (i < 16), "index is out of range")
      return withContiguousStorage({ (cs) in cs[i] })
    }
    set {
      precondition((0 <= i) && (i < 16), "index is out of range")
      withContiguousMutableStorage({ (cs) in cs[i] = newValue })
    }
  }

  /// Accesses the component at given coordinates.
  public subscript(row: Int, column: Int) -> Double {
    get {
      withContiguousStorage({ (cs) in cs[row + 4 * column] })
    }
    set {
      withContiguousMutableStorage({ (cs) in cs[row + 4 * column] = newValue })
    }
  }

  /// Calls `action` on the contiguous storage of the matrix.
  public func withContiguousStorage<T>(
    _ action: (UnsafeBufferPointer<Double>) throws -> T
  ) rethrows -> T {
    try withUnsafeBytes(of: columns, { (bytes) in
      try action(bytes.assumingMemoryBound(to: Double.self))
    })
  }

  /// Calls `action` on the contiguous storage of the matrix.
  public mutating func withContiguousMutableStorage<T>(
    _ action: (UnsafeMutableBufferPointer<Double>) throws -> T
  ) rethrows -> T {
    try withUnsafeMutableBytes(of: &columns, { (bytes) in
      try action(bytes.assumingMemoryBound(to: Double.self))
    })
  }

  /// This matrix, transposed.
  public var transposed: Matrix4 {
    var m = Matrix4.zero
    for i in 0 ..< 4 {
      m[0,i] = self[i,0]
      m[1,i] = self[i,1]
      m[2,i] = self[i,2]
      m[3,i] = self[i,3]
    }
    return m
  }

  /// Returns the transformation of a vector by a matrix.
  public static func * (v: Vector3, m: Matrix4) -> Vector3 {
    let iw = 1.0 / (m[3,0] * v.x + m[3,1] * v.y + m[3,2] * v.z + m[3,3])
    return .init(
      x: (m[0,0] * v.x + m[0,1] * v.y + m[0,2] * v.z + m[0,3]) * iw,
      y: (m[1,0] * v.x + m[1,1] * v.y + m[1,2] * v.z + m[1,3]) * iw,
      z: (m[2,0] * v.x + m[2,1] * v.y + m[2,2] * v.z + m[2,3]) * iw)
  }

  /// A matrix whose all components are zero.
  static var zero: Matrix4 {
    .init()
  }

  /// A rotation matrix representing the identity.
  static var identity: Matrix4 {
    .init(columnMajorComponents: [
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    ])
  }

}

extension Matrix4: Equatable {

  public static func == (l: Self, r: Self) -> Bool {
    l.withContiguousStorage({ (a) in
      r.withContiguousStorage({ (b) in
        for i in 0 ..< 16 { if a[i] != b[i] { return false } }
        return true
      })
    })
  }

}

extension Matrix4: Hashable {

  public func hash(into hasher: inout Hasher) {
    withContiguousStorage({ (cs) in
      for i in 0 ..< 16 { cs[i].hash(into: &hasher) }
    })
  }

}

extension Matrix4: CustomStringConvertible {

  public var description: String {
    withContiguousStorage({ (cs) in
      var result = "Matrix4("
      for i in stride(from: 0, to: 16, by: 4) {
        if i != 0 { result += ", " }
        let column = cs[i ..< (i + 4)].map(String.init(describing:)).joined(separator: ", ")
        result += "[\(column)]"
      }
      return result + ")"
    })
  }

}
