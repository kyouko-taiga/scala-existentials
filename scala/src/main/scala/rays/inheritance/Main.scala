package rays.inheritance

import lcg.Random

@main def Main(size: Int): Unit =
  val res = run(initialWorld(size))
  println(s"Occluded $res objects.")
