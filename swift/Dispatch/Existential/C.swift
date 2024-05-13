import Lcg

public protocol C {
  func f() -> Double
}

struct C1 {
  let x: Double
}
extension C1: C {
  func f() -> Double { return x + 1.0 }
}

struct C2 {
  let x: Double
}
extension C2: C {
  func f() -> Double { return x + 2.0 }
}

struct C3 {
  let x: Double
}
extension C3: C {
  func f() -> Double { return x + 3.0 }
}

struct C4 {
  let x: Double
}
extension C4: C {
  func f() -> Double { return x + 4.0 }
}

struct C5 {
  let x: Double
}
extension C5: C {
  func f() -> Double { return x + 5.0 }
}

struct C6 {
  let x: Double
}
extension C6: C {
  func f() -> Double { return x + 6.0 }
}

struct C7 {
  let x: Double
}
extension C7: C {
  func f() -> Double { return x + 7.0 }
}

struct C8 {
  let x: Double
}
extension C8: C {
  func f() -> Double { return x + 8.0 }
}

struct C9 {
  let x: Double
}
extension C9: C {
  func f() -> Double { return x + 9.0 }
}

struct C10 {
  let x: Double
}
extension C10: C {
  func f() -> Double { return x + 10.0 }
}

struct C11 {
  let x: Double
}
extension C11: C {
  func f() -> Double { return x + 11.0 }
}

struct C12 {
  let x: Double
}
extension C12: C {
  func f() -> Double { return x + 12.0 }
}

struct C13 {
  let x: Double
}
extension C13: C {
  func f() -> Double { return x + 13.0 }
}

struct C14 {
  let x: Double
}
extension C14: C {
  func f() -> Double { return x + 14.0 }
}

struct C15 {
  let x: Double
}
extension C15: C {
  func f() -> Double { return x + 15.0 }
}

struct C16 {
  let x: Double
}
extension C16: C {
  func f() -> Double { return x + 16.0 }
}

struct C17 {
  let x: Double
}
extension C17: C {
  func f() -> Double { return x + 17.0 }
}

struct C18 {
  let x: Double
}
extension C18: C {
  func f() -> Double { return x + 18.0 }
}

struct C19 {
  let x: Double
}
extension C19: C {
  func f() -> Double { return x + 19.0 }
}

struct C20 {
  let x: Double
}
extension C20: C {
  func f() -> Double { return x + 20.0 }
}

struct C21 {
  let x: Double
}
extension C21: C {
  func f() -> Double { return x + 21.0 }
}

struct C22 {
  let x: Double
}
extension C22: C {
  func f() -> Double { return x + 22.0 }
}

struct C23 {
  let x: Double
}
extension C23: C {
  func f() -> Double { return x + 23.0 }
}

struct C24 {
  let x: Double
}
extension C24: C {
  func f() -> Double { return x + 24.0 }
}

struct C25 {
  let x: Double
}
extension C25: C {
  func f() -> Double { return x + 25.0 }
}

struct C26 {
  let x: Double
}
extension C26: C {
  func f() -> Double { return x + 26.0 }
}

struct C27 {
  let x: Double
}
extension C27: C {
  func f() -> Double { return x + 27.0 }
}

struct C28 {
  let x: Double
}
extension C28: C {
  func f() -> Double { return x + 28.0 }
}

struct C29 {
  let x: Double
}
extension C29: C {
  func f() -> Double { return x + 29.0 }
}

struct C30 {
  let x: Double
}
extension C30: C {
  func f() -> Double { return x + 30.0 }
}

struct C31 {
  let x: Double
}
extension C31: C {
  func f() -> Double { return x + 31.0 }
}

struct C32 {
  let x: Double
}
extension C32: C {
  func f() -> Double { return x + 32.0 }
}

public func randomAnyC(random: inout Lcg.Random, classesCount: UInt64 = 32) -> any C {
  let i = random.nextUInt64() % classesCount
  let randomDouble = random.nextDoubleBetween(min: 0.0, max: 10.0)
  switch i {
    case 0: return C1(x: randomDouble)
    case 1: return C2(x: randomDouble)
    case 2: return C3(x: randomDouble)
    case 3: return C4(x: randomDouble)
    case 4: return C5(x: randomDouble)
    case 5: return C6(x: randomDouble)
    case 6: return C7(x: randomDouble)
    case 7: return C8(x: randomDouble)
    case 8: return C9(x: randomDouble)
    case 9: return C10(x: randomDouble)
    case 10: return C11(x: randomDouble)
    case 11: return C12(x: randomDouble)
    case 12: return C13(x: randomDouble)
    case 13: return C14(x: randomDouble)
    case 14: return C15(x: randomDouble)
    case 15: return C16(x: randomDouble)
    case 16: return C17(x: randomDouble)
    case 17: return C18(x: randomDouble)
    case 18: return C19(x: randomDouble)
    case 19: return C20(x: randomDouble)
    case 20: return C21(x: randomDouble)
    case 21: return C22(x: randomDouble)
    case 22: return C23(x: randomDouble)
    case 23: return C24(x: randomDouble)
    case 24: return C25(x: randomDouble)
    case 25: return C26(x: randomDouble)
    case 26: return C27(x: randomDouble)
    case 27: return C28(x: randomDouble)
    case 28: return C29(x: randomDouble)
    case 29: return C30(x: randomDouble)
    case 30: return C31(x: randomDouble)
    case 31: return C32(x: randomDouble)
    default: fatalError("Invalid class type index: \(i)")
  }
}
