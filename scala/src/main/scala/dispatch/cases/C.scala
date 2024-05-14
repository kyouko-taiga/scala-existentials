package dispatch.cases

import java.lang.Long.remainderUnsigned

sealed trait C:
  def f(): Double =
    this match
      case c: C1 => c.x +  401.0
      case c: C2 => c.x +  402.0
      case c: C3 => c.x +  403.0
      case c: C4 => c.x +  404.0
      case c: C5 => c.x +  405.0
      case c: C6 => c.x +  406.0
      case c: C7 => c.x +  407.0
      case c: C8 => c.x +  408.0
      case c: C9 => c.x +  409.0
      case c: C10 => c.x + 410.0
      case c: C11 => c.x + 411.0
      case c: C12 => c.x + 412.0
      case c: C13 => c.x + 413.0
      case c: C14 => c.x + 414.0
      case c: C15 => c.x + 415.0
      case c: C16 => c.x + 416.0
      case c: C17 => c.x + 417.0
      case c: C18 => c.x + 418.0
      case c: C19 => c.x + 419.0
      case c: C20 => c.x + 420.0
      case c: C21 => c.x + 421.0
      case c: C22 => c.x + 422.0
      case c: C23 => c.x + 423.0
      case c: C24 => c.x + 424.0
      case c: C25 => c.x + 425.0
      case c: C26 => c.x + 426.0
      case c: C27 => c.x + 427.0
      case c: C28 => c.x + 428.0
      case c: C29 => c.x + 429.0
      case c: C30 => c.x + 430.0
      case c: C31 => c.x + 431.0
      case c: C32 => c.x + 432.0

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

def randomC(classesIndex: Int, value: Double) =
  classesIndex match
    case 0 => new C1(value)
    case 1 => new C2(value)
    case 2 => new C3(value)
    case 3 => new C4(value)
    case 4 => new C5(value)
    case 5 => new C6(value)
    case 6 => new C7(value)
    case 7 => new C8(value)
    case 8 => new C9(value)
    case 9 => new C10(value)
    case 10 => new C11(value)
    case 11 => new C12(value)
    case 12 => new C13(value)
    case 13 => new C14(value)
    case 14 => new C15(value)
    case 15 => new C16(value)
    case 16 => new C17(value)
    case 17 => new C18(value)
    case 18 => new C19(value)
    case 19 => new C20(value)
    case 20 => new C21(value)
    case 21 => new C22(value)
    case 22 => new C23(value)
    case 23 => new C24(value)
    case 24 => new C25(value)
    case 25 => new C26(value)
    case 26 => new C27(value)
    case 27 => new C28(value)
    case 28 => new C29(value)
    case 29 => new C30(value)
    case 30 => new C31(value)
    case 31 => new C32(value)
    case n => throw new RuntimeException("Invalid C type index: " + n)
