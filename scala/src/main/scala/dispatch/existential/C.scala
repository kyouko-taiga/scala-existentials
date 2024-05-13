package dispatch.existential

import lcg.Random

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
  type Self = C1
  extension (s: C1) def f(): Double = s.x + 1.0

given C2 is C:
  type Self = C2
  extension (s: C2) def f(): Double = s.x + 2.0

given C3 is C:
  type Self = C3
  extension (s: C3) def f(): Double = s.x + 3.0

given C4 is C:
  type Self = C4
  extension (s: C4) def f(): Double = s.x + 4.0

given C5 is C:
  type Self = C5
  extension (s: C5) def f(): Double = s.x + 5.0

given C6 is C:
  type Self = C6
  extension (s: C6) def f(): Double = s.x + 6.0

given C7 is C:
  type Self = C7
  extension (s: C7) def f(): Double = s.x + 7.0

given C8 is C:
  type Self = C8
  extension (s: C8) def f(): Double = s.x + 8.0

given C9 is C:
  type Self = C9
  extension (s: C9) def f(): Double = s.x + 9.0

given C10 is C:
  type Self = C10
  extension (s: C10) def f(): Double = s.x + 10.0

given C11 is C:
  type Self = C11
  extension (s: C11) def f(): Double = s.x + 11.0

given C12 is C:
  type Self = C12
  extension (s: C12) def f(): Double = s.x + 12.0

given C13 is C:
  type Self = C13
  extension (s: C13) def f(): Double = s.x + 13.0

given C14 is C:
  type Self = C14
  extension (s: C14) def f(): Double = s.x + 14.0

given C15 is C:
  type Self = C15
  extension (s: C15) def f(): Double = s.x + 15.0

given C16 is C:
  type Self = C16
  extension (s: C16) def f(): Double = s.x + 16.0

given C17 is C:
  type Self = C17
  extension (s: C17) def f(): Double = s.x + 17.0

given C18 is C:
  type Self = C18
  extension (s: C18) def f(): Double = s.x + 18.0

given C19 is C:
  type Self = C19
  extension (s: C19) def f(): Double = s.x + 19.0

given C20 is C:
  type Self = C20
  extension (s: C20) def f(): Double = s.x + 21.0

given C21 is C:
  type Self = C21
  extension (s: C21) def f(): Double = s.x + 21.0

given C22 is C:
  type Self = C22
  extension (s: C22) def f(): Double = s.x + 22.0

given C23 is C:
  type Self = C23
  extension (s: C23) def f(): Double = s.x + 23.0

given C24 is C:
  type Self = C24
  extension (s: C24) def f(): Double = s.x + 24.0

given C25 is C:
  type Self = C25
  extension (s: C25) def f(): Double = s.x + 25.0

given C26 is C:
  type Self = C26
  extension (s: C26) def f(): Double = s.x + 26.0

given C27 is C:
  type Self = C27
  extension (s: C27) def f(): Double = s.x + 27.0

given C28 is C:
  type Self = C28
  extension (s: C28) def f(): Double = s.x + 28.0

given C29 is C:
  type Self = C29
  extension (s: C29) def f(): Double = s.x + 29.0

given C30 is C:
  type Self = C30
  extension (s: C30) def f(): Double = s.x + 30.0

given C31 is C:
  type Self = C31
  extension (s: C31) def f(): Double = s.x + 31.0

given C32 is C:
  type Self = C32
  extension (s: C32) def f(): Double = s.x + 32.0

def randomContainingC(classesCount: Int = 32)(using random: Random): Containing[C] =
  val i = remainderUnsigned(random.nextLong(), classesCount)
  val randomDouble = random.nextDoubleBetween(1, 10)
  i match
    case 0 => Containing(C1(randomDouble))
    case 1 => Containing(C2(randomDouble))
    case 2 => Containing(C3(randomDouble))
    case 3 => Containing(C4(randomDouble))
    case 4 => Containing(C5(randomDouble))
    case 5 => Containing(C6(randomDouble))
    case 6 => Containing(C7(randomDouble))
    case 7 => Containing(C8(randomDouble))
    case 8 => Containing(C9(randomDouble))
    case 9 => Containing(C10(randomDouble))
    case 10 => Containing(C11(randomDouble))
    case 11 => Containing(C12(randomDouble))
    case 12 => Containing(C13(randomDouble))
    case 13 => Containing(C14(randomDouble))
    case 14 => Containing(C15(randomDouble))
    case 15 => Containing(C16(randomDouble))
    case 16 => Containing(C17(randomDouble))
    case 17 => Containing(C18(randomDouble))
    case 18 => Containing(C19(randomDouble))
    case 19 => Containing(C20(randomDouble))
    case 20 => Containing(C21(randomDouble))
    case 21 => Containing(C22(randomDouble))
    case 22 => Containing(C23(randomDouble))
    case 23 => Containing(C24(randomDouble))
    case 24 => Containing(C25(randomDouble))
    case 25 => Containing(C26(randomDouble))
    case 26 => Containing(C27(randomDouble))
    case 27 => Containing(C28(randomDouble))
    case 28 => Containing(C29(randomDouble))
    case 29 => Containing(C30(randomDouble))
    case 30 => Containing(C31(randomDouble))
    case 31 => Containing(C32(randomDouble))
    case n => throw new RuntimeException("Invalid C type index: " + n)
