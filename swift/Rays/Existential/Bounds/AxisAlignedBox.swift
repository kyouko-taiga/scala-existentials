/// The location and dimensions of a box (a.k.a. rectangular cuboid).
public struct AxisAlignedBox: Hashable {

  /// The box' origin (e.g., its front-bottom-left corner).
  public var origin: Vector3

  /// The box' dimensions.
  public var dimensions: Vector3

  /// Initializes a box with its origin and dimensions.
  public init(origin: Vector3, dimensions: Vector3) {
    self.origin = origin
    self.dimensions = dimensions
  }

  /// Initializes a box with an origin and a size, specified as individual values..
  ///
  /// - Parameters:
  ///   - x: The x-coordinate of the box' origin.
  ///   - y: The y-coordinate of the box' origin.
  ///   - z: The y-coordinate of the box' origin.
  ///   - width: The box' width.
  ///   - height: The box' height.
  ///   - depth: The box' depth.
  public init(x: Double, y: Double, z: Double, width: Double, height: Double, depth: Double) {
    self.origin = Vector3(x: x, y: y, z: z)
    self.dimensions = Vector3(x: width, y: height, z: depth)
  }

  /// Initializes a box centered at the specified coordinate.
  ///
  /// - Parameters:
  ///   - center: A point designating the box' center.
  ///   - dimensions: The box' dimensions.
  public init(centeredAt center: Vector3, dimensions: Vector3) {
    self.origin = Vector3(
      x: center.x - dimensions.x / 2.0,
      y: center.y - dimensions.y / 2.0,
      z: center.z - dimensions.z / 2.0)
    self.dimensions = dimensions
  }

  /// Initializes the minimum box that contains the specified coordinates.
  ///
  /// - Parameters:
  ///   - coordinates: The coordinates that the box should contain.
  public init?<S>(bounding coordinates: S) where S: Sequence, S.Element == Vector3 {
    var it = coordinates.makeIterator()
    guard var minPoint = it.next() else { return nil }
    var maxPoint = minPoint

    while let point = it.next() {
      if point.x < minPoint.x {
        minPoint.x = point.x
      } else if point.x > maxPoint.x {
        maxPoint.x = point.x
      }

      if point.y < minPoint.y {
        minPoint.y = point.y
      } else if point.y > maxPoint.y {
        maxPoint.y = point.y
      }

      if point.z < minPoint.z {
        minPoint.z = point.z
      } else if point.z > maxPoint.z {
        maxPoint.z = point.z
      }
    }

    self.init(origin: minPoint, dimensions: maxPoint - minPoint)
  }

  /// The box' smallest x-coordinate.
  public var minX: Double { (dimensions.x > 0.0) ? origin.x : (origin.x + dimensions.x) }

  /// The box' smallest y-coordinate.
  public var minY: Double { (dimensions.y > 0.0) ? origin.y : (origin.y + dimensions.y) }

  /// The box' smallest z-coordinate.
  public var minZ: Double { (dimensions.z > 0.0) ? origin.z : (origin.z + dimensions.z) }

  /// The box' greatest x-coordinate.
  public var maxX: Double { (dimensions.x > 0.0) ? (origin.x + dimensions.x) : origin.x }

  /// The box' greatest y-coordinate.
  public var maxY: Double { (dimensions.y > 0.0) ? (origin.y + dimensions.y) : origin.y }

  /// The box' greatest z-coordinate.
  public var maxZ: Double { (dimensions.z > 0.0) ? (origin.z + dimensions.z) : origin.z }

  /// The box' absolute dimension along the x-axis.
  public var width: Double { abs(dimensions.x) }

  /// The box' absolute dimension along the y-axis.
  public var height: Double { abs(dimensions.y) }

  /// The box' absolute dimension along the z-axis.
  public var depth: Double { abs(dimensions.z) }

  /// Returns the box whose coordinates are scaled by the given factors.
  ///
  /// All coordinates are scaled, meaning that the new box will not have the same if the this box'
  /// origin is not zero.
  ///
  ///     let b1 = AxisAlignedBox(
  ///       origin: Vector3(x: 0.2, y: 0.5, z: 0.8),
  ///       dimensions: Vector3(x: 0.5, y: 0.5, z: 0.5))
  ///     let b2 = b1.scaled(by: Vector3(x: 8.0, y: 6.0, z: 4.0))
  ///     print(b2.minX, b2.minY, b2.maxX, b2.maxX)
  ///     // Prints AxisAlignedBox(origin: (1.6, 3.0, 3.2), dimensions: (4.0, 3.0, 2.0))
  ///
  /// - Parameter factors: The scaling factors represented as a vector whose each component scales
  ///   the box' coordinates along the corresponding aixs.
  public func scaled(by factors: Vector3) -> AxisAlignedBox {
    .init(origin: origin * factors, dimensions: dimensions * factors)
  }

  /// A cube centered at the origin and having sides of lenght 1.
  public static let unit = AxisAlignedBox(centeredAt: .zero, dimensions: .unitScale)

}

extension AxisAlignedBox: CustomStringConvertible {

  public var description: String {
    "AxisAlignedBox(origin: \(origin), dimensions: \(dimensions))"
  }

}
