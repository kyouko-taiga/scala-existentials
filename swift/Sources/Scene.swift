/// A collection of objects to render organized in a tree.
///
/// A scene is the root of a node hierarchy representing various objects with their models and
/// coordinates. While a scene is not itself a node, it can be assigned as a node's presentation.
/// In that case, note that its contents is considered isolated from that of other scene. Hence,
/// the contents of a scene can never collide with the contents of another.
public struct Scene {

  /// A mask for ignoring collisions.
  public typealias CollisionMask = UInt64

  /// The identifier of a node in the scene.
  public struct NodeIdentifier: Hashable {

    /// The raw value of the identifier.
    fileprivate let rawValue: StableArray<NodeEntry>.Index

  }

  /// The description of a node contained in a scene hierarchy.
  public struct NodeEntry {

    /// The value of the node.
    public var value: Node

    /// The relationships of a node.
    private var links: [NodeIdentifier]

    /// `true` if the node has a parent.
    public let hasParent: Bool

    /// Initializes an instance with a node's value, its parent, and its children.
    fileprivate init<S: Sequence<NodeIdentifier>>(
      value: Node, parent: NodeIdentifier?, children: S
    ) {
      self.value = value
      if let p = parent {
        self.links = [p]
        self.hasParent = true
      } else {
        self.links = []
        self.hasParent = false
      }
      self.links.append(contentsOf: children)
    }

    /// The parent of the node, if any.
    fileprivate var parent: NodeIdentifier? {
      hasParent ? links[0] : nil
    }

    /// The children of the node.
    fileprivate var children: ArraySlice<NodeIdentifier> {
      hasParent ? links[1...] : links[...]
    }

    /// Adds a child to the node.
    fileprivate mutating func addChild(_ c: NodeIdentifier) {
      links.append(c)
    }

    /// Removes a child from the node.
    fileprivate mutating func removeChild(_ c: NodeIdentifier) {
      links.remove(at: links.firstIndex(of: c)!)
    }

  }

  /// The nodes in the scene, in no particular order.
  private var nodes: StableArray<NodeEntry> = []

  /// Initializes an empty scene.
  public init() {}

  /// Accesses the node at the given index.
  public subscript(n: NodeIdentifier) -> Node {
    _read { yield nodes[n.rawValue].value }
    _modify { yield &nodes[n.rawValue].value }
  }

  /// Returns the identifiers of all the nodes in the scene.
  public var nodeIdentities: some Collection<NodeIdentifier> {
    nodes.indices.lazy.map(NodeIdentifier.init(rawValue:))
  }

  /// Adds `n` to the scene as a child of `p` and returns its index.
  @discardableResult
  public mutating func add(_ n: Node, childOf p: NodeIdentifier? = nil) -> NodeIdentifier {
    if let q = p { precondition(nodes.isActiveIndex(q.rawValue)) }
    let i = NodeIdentifier(rawValue: nodes.endIndex)
    nodes.append(.init(value: n, parent: p, children: []))
    return i
  }

  /// Removes `n` from the scene, along with all its children.
  public mutating func remove(_ n: NodeIdentifier) {
    var children = Array(nodes[n.rawValue].children)
    while let c = children.popLast() {
      children.append(contentsOf: nodes[c.rawValue].children)
      nodes.remove(at: c.rawValue)
    }

    if let p = parent(of: n) { nodes[p.rawValue].removeChild(p) }
    nodes.remove(at: n.rawValue)
  }

  /// Calls `visit` on each ancestor of `n` from innermost to outermost.
  public func forEachAncestor(
    of n: NodeIdentifier, _ visit: (NodeIdentifier) throws -> Void
  ) rethrows {
    var m = nodes[n.rawValue].parent
    while let p = m {
      try visit(p)
      m = nodes[p.rawValue].parent
    }
  }

  /// Returns the parent of `n`, if any.
  public func parent(of n: NodeIdentifier) -> NodeIdentifier? {
    nodes[n.rawValue].parent
  }

  /// Returns the children of `n`.
  public func children(of n: NodeIdentifier) -> ArraySlice<NodeIdentifier> {
    nodes[n.rawValue].children
  }

  /// Returns the translation of `n` in the coordinate space of this scene.
  public func translation(of n: NodeIdentifier) -> Vector3 {
    var p = self[n].translation
    forEachAncestor(of: n, { (a) in p += self[n].translation })
    return p
  }

  /// Returns the rotation of `n` in the coordinate space of this scene.
  public func rotation(of n: NodeIdentifier) -> Quaternion {
    var r = self[n].rotation
    forEachAncestor(of: n, { (a) in r *= self[n].rotation })
    return r
  }

  /// Returns the nodes whose shapes collide with `ray` along with the distance from `ray`'s origin
  /// to the collision, from shortest to farthest.
  ///
  /// - Parameters:
  ///   - ray: The ray with which a collision will be tested.
  ///   - mask: A mask for filtering the nodes considered for collision.
  ///   - cullingIsEnabled: On side-shapes, specifies whether face culling is enabled, in which
  ///     case a collision will not be detected unless the ray hits the front of the shape.
  public func shoot(
    _ ray: Ray,
    mask: CollisionMask = .max,
    withCulling cullingIsEnabled: Bool = true
  ) -> [(node: NodeIdentifier, distance: Double)] {
    var results: [(node: NodeIdentifier, distance: Double)] = []
    for n in nodeIdentities where (self[n].collisionMask & mask != 0) {
      // Nothing to do if the node has no collision shape.
      guard let s = self[n].shape else { continue }

      // Adjust the ray to the transformation of the node.
      let r = ray
        .translated(by: -translation(of: n))
        .rotated(by: rotation(of: n).inverted)

      if let d = s.collisionDistance(from: r, withCulling: cullingIsEnabled) {
        let i = results.partitioningIndex(where: { (a) in a.distance < d })
        results.insert((n, d), at: i)
      }
    }
    return results
  }

}

extension Scene.NodeIdentifier: CustomStringConvertible {

  public var description: String {
    "Node(\(rawValue))"
  }

}
