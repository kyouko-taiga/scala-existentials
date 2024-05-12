import Numerics

/// An angle.
///
/// This structure is intended to be used as a wrapper for angle values, rather than expressing it
/// as a raw double value. The advantage is that this dispels any possible confusion between values
/// given degrees or in radians.
public struct Angle {

  /// The angle's value, in radians.
  public var radians: Double

  /// Initialize an angle with its value in radians.
  public init(radians: Double) {
    self.radians = radians
  }

  /// Initialize an angle with its value in degrees.
  public init(degrees: Double) {
    self.radians = degrees * Double.pi / 180
  }

  /// The angle's value, in degrees.
  public var degrees: Double {
    get { radians * 180 / Double.pi }
    set { radians = newValue * Double.pi / 180 }
  }

  /// Returns this angle wrapped within the interval `[0, 2 * pi[`.
  public var wrapped: Angle {
    var r = radians
    if r < 0 {
      while r < 0 { r = r + 2 * Double.pi }
    } else {
      while r >= 2 * Double.pi { r = r - 2 * Double.pi }
    }
    return Angle(radians: r)
  }

}

extension Angle: Hashable {

  public func hash(into hasher: inout Hasher) {
    hasher.combine(wrapped.radians)
  }

  public static func == (lhs: Angle, rhs: Angle) -> Bool {
    lhs.wrapped.radians == rhs.wrapped.radians
  }

}

extension Angle: Comparable {

  public static func < (lhs: Angle, rhs: Angle) -> Bool {
    lhs.wrapped.radians < rhs.wrapped.radians
  }

}

extension Angle: AdditiveArithmetic {

  public static func + (lhs: Angle, rhs: Angle) -> Angle {
    .init(radians: lhs.radians + rhs.radians)
  }

  public static func += (lhs: inout Angle, rhs: Angle) {
    lhs.radians += rhs.radians
  }

  public static func - (lhs: Angle, rhs: Angle) -> Angle {
    .init(radians: lhs.radians - rhs.radians)
  }

  public static func -= (lhs: inout Angle, rhs: Angle) {
    lhs.radians -= rhs.radians
  }

  /// Returns the additive inverse of an angle.
  public static prefix func - (operand: Angle) -> Angle {
    .init(radians: -operand.radians)
  }

  /// Returns the multiplication of an angle by a scalar.
  public static func * (lhs: Angle, rhs: Double) -> Angle {
    .init(radians: lhs.radians * rhs)
  }

  /// Returns the division of an angle by a scalar.
  public static func / (lhs: Angle, rhs: Double) -> Angle {
    .init(radians: lhs.radians / rhs)
  }

  public static let zero = Angle(radians: 0.0)

}
