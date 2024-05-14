package dispatch.existential

import java.lang.Long.remainderUnsigned

trait C extends TmpPredef.TypeClass:
  type Self
  extension (s: Self)
    def f(): Double

final class C1(val x: Double)
final class C2(val x: Double)
final class C3(val x: Double)
final class C4(val x: Double)
final class C5(val x: Double)
final class C6(val x: Double)
final class C7(val x: Double)
final class C8(val x: Double)
final class C9(val x: Double)
final class C10(val x: Double)
final class C11(val x: Double)
final class C12(val x: Double)
final class C13(val x: Double)
final class C14(val x: Double)
final class C15(val x: Double)
final class C16(val x: Double)
final class C17(val x: Double)
final class C18(val x: Double)
final class C19(val x: Double)
final class C20(val x: Double)
final class C21(val x: Double)
final class C22(val x: Double)
final class C23(val x: Double)
final class C24(val x: Double)
final class C25(val x: Double)
final class C26(val x: Double)
final class C27(val x: Double)
final class C28(val x: Double)
final class C29(val x: Double)
final class C30(val x: Double)
final class C31(val x: Double)
final class C32(val x: Double)

given C1 is C:
  extension (s: C1) def f(): Double = s.x + 401.0

given C2 is C:
  extension (s: C2) def f(): Double = s.x + 402.0

given C3 is C:
  extension (s: C3) def f(): Double = s.x + 403.0

given C4 is C:
  extension (s: C4) def f(): Double = s.x + 404.0

given C5 is C:
  extension (s: C5) def f(): Double = s.x + 405.0

given C6 is C:
  extension (s: C6) def f(): Double = s.x + 406.0

given C7 is C:
  extension (s: C7) def f(): Double = s.x + 407.0

given C8 is C:
  extension (s: C8) def f(): Double = s.x + 408.0

given C9 is C:
  extension (s: C9) def f(): Double = s.x + 409.0

given C10 is C:
  extension (s: C10) def f(): Double = s.x + 410.0

given C11 is C:
  extension (s: C11) def f(): Double = s.x + 411.0

given C12 is C:
  extension (s: C12) def f(): Double = s.x + 412.0

given C13 is C:
  extension (s: C13) def f(): Double = s.x + 413.0

given C14 is C:
  extension (s: C14) def f(): Double = s.x + 414.0

given C15 is C:
  extension (s: C15) def f(): Double = s.x + 415.0

given C16 is C:
  extension (s: C16) def f(): Double = s.x + 416.0

given C17 is C:
  extension (s: C17) def f(): Double = s.x + 417.0

given C18 is C:
  extension (s: C18) def f(): Double = s.x + 418.0

given C19 is C:
  extension (s: C19) def f(): Double = s.x + 419.0

given C20 is C:
  extension (s: C20) def f(): Double = s.x + 421.0

given C21 is C:
  extension (s: C21) def f(): Double = s.x + 421.0

given C22 is C:
  extension (s: C22) def f(): Double = s.x + 422.0

given C23 is C:
  extension (s: C23) def f(): Double = s.x + 423.0

given C24 is C:
  extension (s: C24) def f(): Double = s.x + 424.0

given C25 is C:
  extension (s: C25) def f(): Double = s.x + 425.0

given C26 is C:
  extension (s: C26) def f(): Double = s.x + 426.0

given C27 is C:
  extension (s: C27) def f(): Double = s.x + 427.0

given C28 is C:
  extension (s: C28) def f(): Double = s.x + 428.0

given C29 is C:
  extension (s: C29) def f(): Double = s.x + 429.0

given C30 is C:
  extension (s: C30) def f(): Double = s.x + 430.0

given C31 is C:
  extension (s: C31) def f(): Double = s.x + 431.0

given C32 is C:
  extension (s: C32) def f(): Double = s.x + 432.0

def randomContainingC(classesIndex: Int, value: Double): Containing[C] =
  classesIndex match
    case 0 => Containing(C1(value))
    case 1 => Containing(C2(value))
    case 2 => Containing(C3(value))
    case 3 => Containing(C4(value))
    case 4 => Containing(C5(value))
    case 5 => Containing(C6(value))
    case 6 => Containing(C7(value))
    case 7 => Containing(C8(value))
    case 8 => Containing(C9(value))
    case 9 => Containing(C10(value))
    case 10 => Containing(C11(value))
    case 11 => Containing(C12(value))
    case 12 => Containing(C13(value))
    case 13 => Containing(C14(value))
    case 14 => Containing(C15(value))
    case 15 => Containing(C16(value))
    case 16 => Containing(C17(value))
    case 17 => Containing(C18(value))
    case 18 => Containing(C19(value))
    case 19 => Containing(C20(value))
    case 20 => Containing(C21(value))
    case 21 => Containing(C22(value))
    case 22 => Containing(C23(value))
    case 23 => Containing(C24(value))
    case 24 => Containing(C25(value))
    case 25 => Containing(C26(value))
    case 26 => Containing(C27(value))
    case 27 => Containing(C28(value))
    case 28 => Containing(C29(value))
    case 29 => Containing(C30(value))
    case 30 => Containing(C31(value))
    case 31 => Containing(C32(value))
    case n => throw new RuntimeException("Invalid C type index: " + n)
