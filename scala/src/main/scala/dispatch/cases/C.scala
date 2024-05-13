package dispatch.cases

import lcg.Random

import java.lang.Long.remainderUnsigned

sealed trait C:
  def f(): Double =
    this match
      case c: C1 => c.x + 1.0
      case c: C2 => c.x + 2.0
      case c: C3 => c.x + 3.0
      case c: C4 => c.x + 4.0
      case c: C5 => c.x + 5.0
      case c: C6 => c.x + 6.0
      case c: C7 => c.x + 7.0
      case c: C8 => c.x + 8.0
      case c: C9 => c.x + 9.0
      case c: C10 => c.x + 10.0
      case c: C11 => c.x + 11.0
      case c: C12 => c.x + 12.0
      case c: C13 => c.x + 13.0
      case c: C14 => c.x + 14.0
      case c: C15 => c.x + 15.0
      case c: C16 => c.x + 16.0
      case c: C17 => c.x + 17.0
      case c: C18 => c.x + 18.0
      case c: C19 => c.x + 19.0
      case c: C20 => c.x + 20.0
      case c: C21 => c.x + 21.0
      case c: C22 => c.x + 22.0
      case c: C23 => c.x + 23.0
      case c: C24 => c.x + 24.0
      case c: C25 => c.x + 25.0
      case c: C26 => c.x + 26.0
      case c: C27 => c.x + 27.0
      case c: C28 => c.x + 28.0
      case c: C29 => c.x + 29.0
      case c: C30 => c.x + 30.0
      case c: C31 => c.x + 31.0
      case c: C32 => c.x + 32.0

final class C1(val x: Double) extends C
final class C2(val x: Double) extends C
final class C3(val x: Double) extends C
final class C4(val x: Double) extends C
final class C5(val x: Double) extends C
final class C6(val x: Double) extends C
final class C7(val x: Double) extends C
final class C8(val x: Double) extends C
final class C9(val x: Double) extends C
final class C10(val x: Double) extends C
final class C11(val x: Double) extends C
final class C12(val x: Double) extends C
final class C13(val x: Double) extends C
final class C14(val x: Double) extends C
final class C15(val x: Double) extends C
final class C16(val x: Double) extends C
final class C17(val x: Double) extends C
final class C18(val x: Double) extends C
final class C19(val x: Double) extends C
final class C20(val x: Double) extends C
final class C21(val x: Double) extends C
final class C22(val x: Double) extends C
final class C23(val x: Double) extends C
final class C24(val x: Double) extends C
final class C25(val x: Double) extends C
final class C26(val x: Double) extends C
final class C27(val x: Double) extends C
final class C28(val x: Double) extends C
final class C29(val x: Double) extends C
final class C30(val x: Double) extends C
final class C31(val x: Double) extends C
final class C32(val x: Double) extends C

def randomC(classesCount: Int = 32)(using random: Random) =
  val i = remainderUnsigned(random.nextLong(), classesCount)
  val randomDouble = random.nextDoubleBetween(1, 10)
  i match
    case 0 => new C1(randomDouble)
    case 1 => new C2(randomDouble)
    case 2 => new C3(randomDouble)
    case 3 => new C4(randomDouble)
    case 4 => new C5(randomDouble)
    case 5 => new C6(randomDouble)
    case 6 => new C7(randomDouble)
    case 7 => new C8(randomDouble)
    case 8 => new C9(randomDouble)
    case 9 => new C10(randomDouble)
    case 10 => new C11(randomDouble)
    case 11 => new C12(randomDouble)
    case 12 => new C13(randomDouble)
    case 13 => new C14(randomDouble)
    case 14 => new C15(randomDouble)
    case 15 => new C16(randomDouble)
    case 16 => new C17(randomDouble)
    case 17 => new C18(randomDouble)
    case 18 => new C19(randomDouble)
    case 19 => new C20(randomDouble)
    case 20 => new C21(randomDouble)
    case 21 => new C22(randomDouble)
    case 22 => new C23(randomDouble)
    case 23 => new C24(randomDouble)
    case 24 => new C25(randomDouble)
    case 25 => new C26(randomDouble)
    case 26 => new C27(randomDouble)
    case 27 => new C28(randomDouble)
    case 28 => new C29(randomDouble)
    case 29 => new C30(randomDouble)
    case 30 => new C31(randomDouble)
    case 31 => new C32(randomDouble)
    case n => throw new RuntimeException("Invalid C type index: " + n)
