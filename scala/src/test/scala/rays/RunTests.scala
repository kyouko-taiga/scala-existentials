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

  for (name, run) <- List(("Existential", rays.existential.run), ("Inheritance", rays.inheritance.run)) do
    for (size, expected) <- testCases do
      test(s"run$name($size)"):
        assertEquals(run(size), expected)
