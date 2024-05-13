package rays.existential

import lcg.Random

@main def Main(size: Int): Unit =
  val res = run(size)
  println(s"Occluded $res objects.")
