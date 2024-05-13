package rays

import lcg.Random

class RandomTests extends munit.FunSuite:
  val testCases = Map(
    192 -> 1,
    193 -> 2,
    256 -> 2,
    512 -> 12,
    525 -> 13,
    550 -> 14,
    575 -> 15,
    587 -> 15,
    592 -> 15,
    596 -> 15,
    597 -> 16,
    598 -> 16,
    600 -> 16,
    700 -> 21,
    768 -> 26,
    1024 -> 49,
    2048 -> 155
  )

  for (shapeCount, expected) <- testCases do
    test(s"runExistential($shapeCount)"):
      val world = existential.initialWorld(shapeCount)
      assertEquals(existential.run(world), expected)
    test(s"runInheritance($shapeCount)"):
      val world = inheritance.initialWorld(shapeCount)
      assertEquals(inheritance.run(world), expected)
