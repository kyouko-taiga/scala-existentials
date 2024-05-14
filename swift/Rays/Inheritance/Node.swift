/// An object to render as part of a scene.
///
/// Transformations and rotations apply to the scenes presentation and shape. Scaling cannot be
/// applied on a node because that could invalidate collision shapes represented by an idealized
/// mathematical object, such as a sphere. Instead, scaling should be applied on presentations.
public struct Node {

  /// The presentation of a node.
  public typealias Presentation = Scene

  /// The presentation of the node, if any.
  public var presentation: Presentation?

  /// The collision shape of the node, if any.
  public var shape: (any CollisionShape)?

  /// A mask for determining whether collision involving this node should be considered.
  public var collisionMask: Scene.CollisionMask = .max

  /// The translation of the node, relative to its parent coordinate space.
  public var translation: Vector3 = .zero

  /// The rotation of the node, relative to its parent coordinate space.
  public var rotation: Quaternion = .identity

  /// Initializes a node with the given presentation and shape.
  public init(presentation: Presentation? = nil, shape: (any CollisionShape)? = nil) {
    self.presentation = presentation
    self.shape = shape
  }

}
