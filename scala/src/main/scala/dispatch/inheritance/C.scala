package dispatch.inheritance

import lcg.Random

import java.lang.Long.remainderUnsigned

abstract class C:
  def f(): Double

final class C1(val x: Double) extends C:
  def f(): Double = x + 401.0

final class C2(val x: Double) extends C:
  def f(): Double = x + 402.0

final class C3(val x: Double) extends C:
  def f(): Double = x + 403.0

final class C4(val x: Double) extends C:
  def f(): Double = x + 404.0

final class C5(val x: Double) extends C:
  def f(): Double = x + 405.0

final class C6(val x: Double) extends C:
  def f(): Double = x + 406.0

final class C7(val x: Double) extends C:
  def f(): Double = x + 407.0

final class C8(val x: Double) extends C:
  def f(): Double = x + 408.0

final class C9(val x: Double) extends C:
  def f(): Double = x + 409.0

final class C10(val x: Double) extends C:
  def f(): Double = x + 410.0

final class C11(val x: Double) extends C:
  def f(): Double = x + 411.0

final class C12(val x: Double) extends C:
  def f(): Double = x + 412.0

final class C13(val x: Double) extends C:
  def f(): Double = x + 413.0

final class C14(val x: Double) extends C:
  def f(): Double = x + 414.0

final class C15(val x: Double) extends C:
  def f(): Double = x + 415.0

final class C16(val x: Double) extends C:
  def f(): Double = x + 416.0

final class C17(val x: Double) extends C:
  def f(): Double = x + 417.0

final class C18(val x: Double) extends C:
  def f(): Double = x + 418.0

final class C19(val x: Double) extends C:
  def f(): Double = x + 419.0

final class C20(val x: Double) extends C:
  def f(): Double = x + 421.0

final class C21(val x: Double) extends C:
  def f(): Double = x + 421.0

final class C22(val x: Double) extends C:
  def f(): Double = x + 422.0

final class C23(val x: Double) extends C:
  def f(): Double = x + 423.0

final class C24(val x: Double) extends C:
  def f(): Double = x + 424.0

final class C25(val x: Double) extends C:
  def f(): Double = x + 425.0

final class C26(val x: Double) extends C:
  def f(): Double = x + 426.0

final class C27(val x: Double) extends C:
  def f(): Double = x + 427.0

final class C28(val x: Double) extends C:
  def f(): Double = x + 428.0

final class C29(val x: Double) extends C:
  def f(): Double = x + 429.0

final class C30(val x: Double) extends C:
  def f(): Double = x + 430.0

final class C31(val x: Double) extends C:
  def f(): Double = x + 431.0

final class C32(val x: Double) extends C:
  def f(): Double = x + 432.0

def randomC(classesCount: Int)(using random: scala.util.Random) =
  val i = random.nextInt(classesCount)
  val randomDouble = random.nextDouble()
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
