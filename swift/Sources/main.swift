/// The bounds of the world in which the simulation occurs.
let worldBounds = AxisAlignedBox(origin: .zero, dimensions: .init(x: 100, y: 100, z: 100))

/// Returns a random collision shape that fits in a unit box centered at the origin.
func randomCollisionShape() -> any CollisionShape {
  switch Int.random(in: 0 ..< 3) {
  case 0:
    return Box.unit
  case 1:
    return Sphere.unit
  case 2:
    return Triangle(
      a: .random(in: .unit), b: .random(in: .unit), c: .random(in: .unit))
  default:
    fatalError()
  }
}

func main() {
  // Creates an empty world.
  var world = Scene()

  // Add random objects to the world.
  for _ in 0 ..< 1000 {
    var n = Node()
    n.translation = .random(in: worldBounds)
    n.shape = randomCollisionShape()
    world.add(n)
  }

  // Shoot rays at all objects from the origin to find those that are (partially) occluded.
  var nodes = Set(world.nodeIdentities)
  var occluded: [Scene.NodeIdentifier] = []

  while let n = nodes.popFirst() {
    let s = world[n].shape!
    let r = Ray(
      origin: .zero,
      direction: (world.translation(of: n) + s.centroid).normalized)
    let collisions = world.shoot(r, withCulling: false)
    for (m, _) in collisions {
      world[m].collisionMask = .zero
      nodes.remove(m)
    }
    occluded.append(contentsOf: collisions.dropFirst().map(\.node))
  }

  print(occluded.count)
}

main()
