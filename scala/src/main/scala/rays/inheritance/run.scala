package rays.inheritance

import rays.inheritance.bounds.AxisAlignedBox
import rays.inheritance.math.{Ray, Vector3}
import rays.inheritance.scenes.{Node, Scene}
import rays.inheritance.shapes.{Box, CollisionShape, Sphere, Triangle}

import lcg.Random

import java.lang.Long.remainderUnsigned

/** The bounds of the world in which the simulation occurs. */
val worldBounds = AxisAlignedBox(Vector3.zero, Vector3(100, 100, 100))

/** Returns a random collision shape that fits in a unit box centered at the origin. */
def randomCollisionShape(using g: Random): CollisionShape =
  remainderUnsigned(g.nextLong(), 3) match
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
      throw new RuntimeException("unreachable: " + n)

def initialWorld(size: Int): Scene =
  given Random = Random(0xACE1)

  // Create an empty world.
  var world = Scene()

  // Add random objects to the world.
  for _ <- 0 until size do
    val n = Node(Vector3.randomIn(worldBounds), Some(randomCollisionShape))
    world = world.adding(n)

  world

def run(world: Scene): Int =
  // Shoot rays at all objects from the origin to find those that are (partially) occluded.
  var nodes = Set.from(world.nodes)
  var occludedCount: Int = 0

  for n <- world.nodes if nodes(n) do
    //println(s"Node: ${n.translation}")
    val s = n.shape.get
    val r = Ray(Vector3.zero, (world.translation(n) + s.centroid).normalized)
    //println(s"Ray: $r")
    val collisions = world.shoot(r, -1, false)
    for (m, _) <- collisions do
      m.collisionMask = 0
      nodes -= m
    occludedCount += collisions.length - 1

  occludedCount
