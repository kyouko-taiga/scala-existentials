package rays.scenes

import rays.algorithms.partitioningIndex
import rays.math.{Quaternion, Ray, Vector3}
import scala.collection.mutable

/** A collection of objects to render organized in a tree.
  *
  * A scene is the root of a node hierarchy representing various objects with their models and
  * coordinates. While a scene is not itself a node, it can be assigned as a node's presentation.
  * In that case, note that its contents is considered isolated from that of another scene. Hence,
  * the contents of a scene can never collide with the contents of another.
  *
  * @param nodes The nodes in the scene.
  * @param relationships The relationships between the nodes in the scene.
  */
final class Scene private (
    val nodes: Set[Node],
    val relationships: Map[Node, Scene.NodeRelationships]
):

  /** Returns a copy of `this` in which `n` has been added as a child of `p`.
    *
    * `n` must not be contained in `this` and `p` (if given) must.
    */
  def adding(n: Node, p: Option[Node] = None): Scene =
    require(!nodes.contains(n))
    val newParentR =
      n -> Scene.NodeRelationships(p, List())
    val updatedChildR = p.map: q =>
      require(nodes.contains(q))
      q -> relationships(q).addingChild(n)
    new Scene(nodes + n, relationships + newParentR ++ updatedChildR)

  /** Returns a copy of `this` in which `n` and its children have been removed. */
  def removing(n: Node): Scene =
    val updatedParentR = parent(n).map: p =>
      p -> relationships(p).removingChild(n)
    val ds = descendants(n)
    new Scene(nodes -- ds - n, relationships -- ds ++ updatedParentR)

  /** Ancestor of `n` from innermost to outermost. */
  def ancestors(n: Node): Seq[Node] = parent(n) match
    case Some(p) => p +: ancestors(p)
    case None => Seq()

  def descendants(n: Node): Seq[Node] =
    val cs = children(n)
    cs ++ cs.flatMap(descendants)

  /** Returns the parent of `n`, if any. */
  def parent(n: Node): Option[Node] =
    relationships(n).parent

  /** Returns the children of `n`. */
  def children(n: Node): List[Node] =
    relationships(n).children

  /** Returns the translation of `n` in the coordinate space of this scene. */
  def translation(n: Node): Vector3 =
    ancestors(n).foldLeft(n.translation)(_ + _.translation)

  /** Returns the rotation of `n` in the coordinate space of this scene. */
  def rotation(n: Node): Quaternion =
    ancestors(n).foldLeft(n.rotation)(_ + _.rotation)

  /** Returns the nodes whose shapes collide with `ray` along with the distance from `ray`'s origin
    * to the collision, from shortest to farthest.
    *
    * @param ray The ray with which a collision will be tested.
    * @param cullingIsEnabled On side-shapes, specifies whether face culling is enabled, in which
    * @param mask: A mask for filtering the nodes considered for collision.
    *  case a collision will not be detected unless the ray hits the front of the shape.
    */
  def shoot(
    ray: Ray, mask: Scene.CollisionMask = -1, cullingIsEnabled: Boolean = true
  ): IndexedSeq[(Node, Double)] =
    val results = mutable.ArrayBuffer[(Node, Double)]()
    for
      n <- nodes if (n.collisionMask & mask) != 0
      s <- n.shape
      // Adjust the ray to the transformation of the node.
      r = ray
        .translatedBy(-translation(n))
        .rotatedBy(rotation(n).inverted)
      d <- s.collisionDistance(r, cullingIsEnabled)
      i = results.partitioningIndex(_._2 < d)
    do results.insert(i, n -> d)
    results.toIndexedSeq

object Scene:

  /** A mask for ignoring collisions. */
  type CollisionMask = Long

  /** The relationships of a node in the hierarchy.
    *
    * @param parent The parent of the node, if any.
    * @param children The children of the node.
    */
  final case class NodeRelationships(parent: Option[Node], children: List[Node]):

    /** Returns a copy of `this` in which `c` has been added as a child. */
    def addingChild(c: Node): NodeRelationships =
      NodeRelationships(parent, c +: children)

    /** Returns a copy of `this` in which `c` has been removed from the children. */
    def removingChild(c: Node): NodeRelationships =
      NodeRelationships(parent, children.filter((d) => c != d))

  end NodeRelationships

  /** Creates an empty scene. */
  def apply(): Scene =
    new Scene(Set(), Map())

end Scene
