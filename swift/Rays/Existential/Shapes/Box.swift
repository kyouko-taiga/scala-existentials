/// A rectangular cuboid centered at the origin.
public struct Box: Hashable {

  /// The dimensions of the box.
  public var dimensions: Vector3

  /// Initializes a box with its dimensions.
  public init(dimensions: Vector3) {
    self.dimensions = dimensions
  }

  /// Initializes a box with its dimensions specified as individual values.
  public init(width: Double, height: Double, depth: Double) {
    self.dimensions = .init(x: width, y: height, z: depth)
  }

  /// The box' absolute dimension along the x-axis.
  public var width: Double { abs(dimensions.x) }

  /// The box' absolute dimension along the y-axis.
  public var height: Double { abs(dimensions.y) }

  /// The box' absolute dimension along the z-axis.
  public var depth: Double { abs(dimensions.z) }

  /// The minimum point of the box.
  public var min: Vector3 { .init(x: -width * 0.5, y: -height * 0.5, z: -depth * 0.5) }

  /// The maximum point of the box.
  public var max: Vector3 { -min }

  /// Returns the box with its coordinates scaled by the given factors.
  public func scaled(by factors: Vector3) -> Box {
    .init(dimensions: dimensions * factors)
  }

  /// A box having sides of lenght 1.
  public static var unit = Box(dimensions: .unitScale)

}

extension Box: CollisionShape {

  public var origin: Vector3 {
    .zero
  }

  public var centroid: Vector3 {
    .zero
  }

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {

    // Barnes-Tavian's "slab method".

    let tmin = (min - ray.origin) / ray.direction
    let tmax = (max - ray.origin) / ray.direction

    let t = tmin.combined(with: tmax, applying: Swift.min)
    let n = Swift.max(Swift.max(t.x, t.y), t.z)

    let u = tmax.combined(with: tmax, applying: Swift.max)
    let f = Swift.min(Swift.min(u.x, u.y), u.z)

    return (n < f) ? n : nil
  }

}

extension Box: CustomStringConvertible {

  public var description: String {
    "Box(dimensions: \(dimensions))"
  }

}

