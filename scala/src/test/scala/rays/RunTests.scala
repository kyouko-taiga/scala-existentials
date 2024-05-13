package rays

import lcg.Random

class RandomTests extends munit.FunSuite {
  test("run(192)") {
    assertEquals(run(192), 1)
  }

  test("run(193)") {
    assertEquals(run(193), 2)
  }

  test("run(256)") {
    assertEquals(run(256), 2)
  }

  test("run(512)") {
    assertEquals(run(512), 12)
  }

  test("run(768)") {
    assertEquals(run(768), 26) // failing
  }
}
