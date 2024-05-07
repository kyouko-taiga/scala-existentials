package rays

import rays.bounds.AxisAlignedBox
import rays.math.{Ray, Vector3}
import rays.scenes.{Node, Scene}
import rays.shapes.{Box, CollisionShape, Sphere, Triangle}

import scala.util.Random

/** The bounds of the world in which the simulation occurs. */
val worldBounds = AxisAlignedBox(Vector3.zero, Vector3(100, 100, 100))

/** Returns a random collision shape that fits in a unit box centered at the origin. */
def randomCollisionShape(using g: Random): CollisionShape =
  g.between(0, 3) match
    case 0 =>
      Box.unit
    case 1 =>
      Sphere.unit
    case 2 =>
      Triangle(
        Vector3.randomIn(AxisAlignedBox.unit),
        Vector3.randomIn(AxisAlignedBox.unit),
        Vector3.randomIn(AxisAlignedBox.unit))
    case n =>
      throw new RuntimeException("unreachable")

def run(size: Int)(using Random): Int =
  // Create an empty world.
  var world = Scene()

  // Add random objects to the world.
  for _ <- 0 until size do
    val n = Node()
    n.translation = Vector3.randomIn(worldBounds)
    n.shape = Some(randomCollisionShape)
    world = world.adding(n)

  // Shoot rays at all objects from the origin to find those that are (partially) occluded.
  var nodes = world.nodes
  var occluded = List[Node]()

  while !nodes.isEmpty do
    val n = nodes.head
    nodes = nodes.drop(1)

    val s = n.shape.get
    val r = Ray(Vector3.zero, (world.translation(n) + s.centroid).normalized)
    val collisions = world.shoot(r, -1, false)
    for (m, _) <- collisions do
      n.collisionMask = 0
      world = world.removing(m)
    occluded ++= collisions.drop(1).map((c) => c(0))

  occluded.length

@main def Main(size: Int): Unit =
  val res = run(size)(using Random())
  println(s"Occluded $res objects.")
