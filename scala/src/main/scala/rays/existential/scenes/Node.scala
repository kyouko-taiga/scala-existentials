package rays.existential.scenes

import rays.existential.math.{Quaternion, Vector3}
import rays.existential.shapes.CollisionShape

/** An object to render as part of a scene.
  *
  * Transformations and rotations apply to the scenes presentation and shape. Scaling cannot be
  * applied on a node because that could invalidate collision shapes represented by an idealized
  * mathematical object, such as a sphere. Instead, scaling should be applied on presentations.
  */
final class Node(_translation: Vector3, _shape: Option[CollisionShape]):

  /** The presentation of the node, if any. */
  val presentation: Option[Node.Presentation] = None

  /** The collision shape of the node, if any. */
  val shape: Option[CollisionShape] = _shape

  /** A mask for determining whether collision involving this node should be considered. */
  var collisionMask: Scene.CollisionMask = -1

  /** The translation of the node, relative to its parent coordinate space. */
  val translation: Vector3 = _translation

  /** The rotation of the node, relative to its parent coordinate space. */
  val rotation: Quaternion = Quaternion.identity

object Node:

  /// The presentation of a node.
  type Presentation = Scene

end Node
