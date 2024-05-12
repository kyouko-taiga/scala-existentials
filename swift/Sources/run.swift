/// The bounds of the world in which the simulation occurs.
let worldBounds = AxisAlignedBox(origin: .zero, dimensions: .init(x: 100, y: 100, z: 100))

/// Returns a random collision shape that fits in a unit box centered at the origin.
func randomCollisionShape(rand: inout Random) -> any CollisionShape {
  switch rand.nextUInt64() % 3 {
  case 0:
    return Box.unit
  case 1:
    return Sphere.unit
  case 2:
    return Triangle(
      a: .random(rand: &rand, in: .unit), b: .random(rand: &rand, in: .unit), c: .random(rand: &rand, in: .unit))
  default:
    fatalError()
  }
}

public func run(shapeCount: Int) -> Int {
  // Creates an empty world.
  var world = Scene()
  var rand = Random(seed: 0xACE1)

  // Add random objects to the world.
  for _ in 0 ..< shapeCount {
    var n = Node()
    n.translation = .random(rand: &rand, in: worldBounds)
    n.shape = randomCollisionShape(rand: &rand)
    world.add(n)
  }

  // Shoot rays at all objects from the origin to find those that are (partially) occluded.
  var nodes = Set(world.nodeIdentities)
  var occluded: [Scene.NodeIdentifier] = []

  for n in world.nodeIdentities {
    if !nodes.contains(n) { continue }
    //print("Node: \(world[n].translation)")
    let s = world[n].shape!
    let r = Ray(
      origin: .zero,
      direction: (world.translation(of: n) + s.centroid).normalized)
    //print("Ray: \(r)")
    let collisions = world.shoot(r, withCulling: false)
    for (m, _) in collisions {
      world[m].collisionMask = .zero
      nodes.remove(m)
    }
    //print(collisions)
    occluded.append(contentsOf: collisions.dropFirst().map(\.node))
  }

  return occluded.count
}
