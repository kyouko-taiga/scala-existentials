package rays.inheritance.scenes

import rays.inheritance.algorithms.partitioningIndex
import rays.inheritance.math.{Quaternion, Ray, Vector3}
import scala.collection.mutable

/** A collection of objects to render organized in a tree.
  *
  * A scene is the root of a node hierarchy representing various objects with their models and
  * coordinates. While a scene is not itself a node, it can be assigned as a node's presentation.
  * In that case, note that its contents is considered isolated from that of other scene. Hence,
  * the contents of a scene can never collide with the contents of another.
  *
  * @param nodes The nodes in the scene.
  * @param relationships The relationships between the nodes in the scene.
  */
final class Scene private (
    val nodes: Vector[Node],
    val relationships: Map[Node, Scene.NodeRelationships]
):

  /** Returns a copy of `this` in which `n` has been added as a child of `p`.
    *
    * `n` must not be contained in `this` and `p` (if given) must.
    */
  def adding(n: Node, p: Option[Node] = None): Scene =
    require(!nodes.contains(n))
    val newNodes = nodes :+ n
    val newRelationships = p match
      case Some(q) =>
        require(p.map((q) => nodes.contains(q)).getOrElse(true))
        relationships ++ List(
          n -> Scene.NodeRelationships(Some(q), List()),
          q -> relationships(q).addingChild(n))
      case None =>
        relationships + (n -> Scene.NodeRelationships(None, List()))
    new Scene(newNodes, newRelationships)


  extension [T](self: Vector[T])
    def -(e: T): Vector[T] = self.filter((a) => a != e)

  /** Returns a copy of `this` in which `n` and its children have been removed. */
  def removing(n: Node): Scene =
    def loop(
        children: List[Node], ns: Vector[Node], rs: Map[Node, Scene.NodeRelationships]
    ): (Vector[Node], Map[Node, Scene.NodeRelationships]) =
      children match
        case (h :: t) =>
          val cs = rs(h).children
          loop(cs ++ t, ns - h, rs - h)
        case Nil =>
          (ns, rs)
    var (ns, rs) = loop(relationships(n).children, nodes, relationships)

    rs(n).parent match
      case Some(p) =>
        new Scene(ns - n, rs + (p -> rs(p).removingChild(n)))
      case None =>
        new Scene(ns - n, rs)

  /** Calls `visit` on each ancestor of `n` from innermost to outermost. */
  def forEachAncestor(n: Node)(visit: Node => Unit): Unit =
    def loop(m: Option[Node]): Unit =
      m match
        case Some(p) => visit(p); loop(relationships(p).parent)
        case None => ()
    loop(relationships(n).parent)

  /** Returns the parent of `n`, if any. */
  def parent(n: Node): Option[Node] =
    relationships(n).parent

  /** Returns the children of `n`. */
  def children(n: Node): List[Node] =
    relationships(n).children

  /** Returns the translation of `n` in the coordinate space of this scene. */
  def translation(n: Node): Vector3 =
    var p = n.translation
    forEachAncestor(n)((a) => p += a.translation)
    p

  /** Returns the rotation of `n` in the coordinate space of this scene. */
  def rotation(n: Node): Quaternion =
    var r = n.rotation
    forEachAncestor(n)((a) => r *= a.rotation)
    r

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
    for n <- nodes if (n.collisionMask & mask) != 0 do
      n.shape match
        case Some(s) =>
          // Adjust the ray to the transformation of the node.
          val r = ray
            .translatedBy(-translation(n))
            .rotatedBy(rotation(n).inverted)

          s.collisionDistance(r, cullingIsEnabled) match
            case Some(d) =>
              val i = results.partitioningIndex((a) => a(1) < d)
              results.insert(i, (n, d))
            case None => ()

        case None => ()  // Nothing to do if the node has no collision shape.
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
    new Scene(Vector(), Map())

end Scene
