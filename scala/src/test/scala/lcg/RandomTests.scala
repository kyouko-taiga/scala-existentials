package lcg

import java.lang.Long.toUnsignedString

class RandomTests extends munit.FunSuite {
  test("nextLong()") {
    val random = new Random(0xACE1)
    assertEquals(toUnsignedString(random.nextLong()), "12688341390083949198")
    assertEquals(toUnsignedString(random.nextLong()), "5684655011191448823")
  }

  test("nextDoubleBetween(0, 1)") {
    val random = new Random(0xACE1)
    assertEquals(random.nextDoubleBetween(0.0, 1.0), 0.37775111511306003)
    assertEquals(random.nextDoubleBetween(0.0, 1.0), 0.24697609510468316)
  }

  test("nextDoubleBetween(0, 42)") {
    val random = new Random(0xACE1)
    assertEquals(random.nextDoubleBetween(0.0, 42.0), 15.865546834748521)
    assertEquals(random.nextDoubleBetween(0.0, 42.0), 10.372995994396693)
  }

  test("nextDoubleBetween(-2, 2)") {
    val random = new Random(0xACE1)
    assertEquals(random.nextDoubleBetween(-2.0, 2.0), -0.48899553954775987)
    assertEquals(random.nextDoubleBetween(-2.0, 2.0), -1.0120956195812674)
  }
}
