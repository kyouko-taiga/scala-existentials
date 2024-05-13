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

  test("run(525)") {
    assertEquals(run(525), 13)
  }

  test("run(550)") {
    assertEquals(run(550), 14)
  }

  test("run(575)") {
    assertEquals(run(575), 15)
  }

  test("run(587)") {
    assertEquals(run(587), 15)
  }

  test("run(592)") {
    assertEquals(run(592), 15)
  }

  test("run(596)") {
    assertEquals(run(596), 15)
  }

  test("run(597)") {
    assertEquals(run(597), 16)
  }

  test("run(598)") {
    assertEquals(run(598), 16)
  }

  test("run(600)") {
    assertEquals(run(600), 16)
  }

  test("run(700)") {
    assertEquals(run(700), 21)
  }

  test("run(768)") {
    assertEquals(run(768), 26)
  }

  test("run(1024)") {
    assertEquals(run(1024), 49)
  }

  test("run(2048)") {
    assertEquals(run(2048), 155)
  }

}
