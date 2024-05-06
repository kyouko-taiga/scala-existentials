package rays.scenes

/** A collection of objects to render organized in a tree.
  *
  * A scene is the root of a node hierarchy representing various objects with their models and
  * coordinates. While a scene is not itself a node, it can be assigned as a node's presentation.
  * In that case, note that its contents is considered isolated from that of other scene. Hence,
  * the contents of a scene can never collide with the contents of another.
  */
final class Scene:

  /** The nodes in the scene. */
  val nodes: Set[Node] = Set()

  /** The relationships between the nodes in the scene. */
  val relationships: Map[Node, Scene.NodeRelationships] = Map()

  /** Returns a scene in which `n` has been added as a child of `p`.
    *
    * `n` must not be contained in `this` and `p` (if given) must.
    */
  def adding(n: Node, p: Option[Node] = None): Scene =
    require(!nodes.contains(n))

    val newNodes = nodes + n
    val newRelationships = p match
      case Some(q) =>
        require(p.map((q) => nodes.contains(q)).getOrElse(true))
        relationships + (
          n -> Scene.NodeRelationships(Some(q), List()),
          q -> relationships(q).addingChild(n))
      case None =>
        relationships + (n -> Scene.NodeRelationships(None, List()))

    this

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

  end NodeRelationships

end Scene
