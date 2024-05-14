/// A 3x3 matrix.
public struct Matrix3 {

  /// The representation of a column of a 3x3 matrix.
  public typealias Column = (Double, Double, Double)

  /// The components of the matrix.
  ///
  /// The matrix is in column-major order. Contents are represented by 9 scalar values laid out
  /// contiguously in memory. Each consecutive set of 3 values is a column.
  public var columns: (Column, Column, Column)

  /// Initializes a 3x3 matrix with zeros.
  public init() {
    self.columns = ((0, 0, 0), (0, 0, 0), (0, 0, 0))
  }

  /// Initializes a 3x3 matrix with its components in column-major order.
  ///
  /// - Requires: `components` contains exactly 9 elements.
  public init<S: Sequence<Double>>(columnMajorComponents components: S) {
    self.init()
    withContiguousMutableStorage { (storage) in
      var s = components.makeIterator()
      for i in 0 ..< 9 { storage[i] = s.next()! }
      precondition(s.next() == nil)
    }
  }

  /// Accesses the component at given index.
  public subscript(i: Int) -> Double {
    get {
      precondition((0 <= i) && (i < 9), "index is out of range")
      return withContiguousStorage({ (cs) in cs[i] })
    }
    set {
      precondition((0 <= i) && (i < 9), "index is out of range")
      withContiguousMutableStorage({ (cs) in cs[i] = newValue })
    }
  }

  /// Accesses the component at given coordinates.
  public subscript(row: Int, column: Int) -> Double {
    get {
      withContiguousStorage({ (cs) in cs[row + 3 * column] })
    }
    set {
      withContiguousMutableStorage({ (cs) in cs[row + 3 * column] = newValue })
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
  public var transposed: Matrix3 {
    var m = Matrix3.zero
    for i in 0 ..< 3 {
      m[0,i] = self[i,0]
      m[1,i] = self[i,1]
      m[2,i] = self[i,2]
    }
    return m
  }

  /// A matrix whose all components are zero.
  static var zero: Matrix3 {
    .init()
  }

  /// A rotation matrix representing the identity.
  static var identity: Matrix3 {
    .init(columnMajorComponents: [1, 0, 0, 0, 1, 0, 0, 0, 1])
  }

}

extension Matrix3: Equatable {

  public static func == (l: Self, r: Self) -> Bool {
    l.withContiguousStorage({ (a) in
      r.withContiguousStorage({ (b) in
        for i in 0 ..< 9 { if a[i] != b[i] { return false } }
        return true
      })
    })
  }

}

extension Matrix3: Hashable {

  public func hash(into hasher: inout Hasher) {
    withContiguousStorage({ (cs) in
      for i in 0 ..< 9 { cs[i].hash(into: &hasher) }
    })
  }

}

extension Matrix3: CustomStringConvertible {

  public var description: String {
    withContiguousStorage({ (cs) in
      var result = "Matrix3["
      for i in stride(from: 0, to: 9, by: 3) {
        if i != 0 { result += ", " }
        let column = cs[i ..< (i + 3)].map(String.init(describing:)).joined(separator: ", ")
        result += "[\(column)]"
      }
      return result + "]"
    })
  }

}
