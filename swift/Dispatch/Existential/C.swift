import Lcg

public protocol C {
  func f() -> Double
}

struct C1: C {
  let x: Double
  func f() -> Double { return x + 1.0 }
}

struct C2: C {
  let x: Double
  func f() -> Double { return x + 2 }
}

struct C3: C {
  let x: Double
  func f() -> Double { return x + 3 }
}

struct C4: C {
  let x: Double
  func f() -> Double { return x + 4 }
}

struct C5: C {
  let x: Double
  func f() -> Double { return x + 5 }
}

struct C6: C {
  let x: Double
  func f() -> Double { return x + 6 }
}

struct C7: C {
  let x: Double
  func f() -> Double { return x + 7 }
}

struct C8: C {
  let x: Double
  func f() -> Double { return x + 8 }
}

struct C9: C {
  let x: Double
  func f() -> Double { return x + 9 }
}

struct C10: C {
  let x: Double
  func f() -> Double { return x + 10 }
}

struct C11: C {
  let x: Double
  func f() -> Double { return x + 11 }
}

struct C12: C {
  let x: Double
  func f() -> Double { return x + 12 }
}

struct C13: C {
  let x: Double
  func f() -> Double { return x + 13 }
}

struct C14: C {
  let x: Double
  func f() -> Double { return x + 14 }
}

struct C15: C {
  let x: Double
  func f() -> Double { return x + 15 }
}

struct C16: C {
  let x: Double
  func f() -> Double { return x + 16 }
}

struct C17: C {
  let x: Double
  func f() -> Double { return x + 17 }
}

struct C18: C {
  let x: Double
  func f() -> Double { return x + 18 }
}

struct C19: C {
  let x: Double
  func f() -> Double { return x + 19 }
}

struct C20: C {
  let x: Double
  func f() -> Double { return x + 20 }
}

struct C21: C {
  let x: Double
  func f() -> Double { return x + 21 }
}

struct C22: C {
  let x: Double
  func f() -> Double { return x + 22 }
}

struct C23: C {
  let x: Double
  func f() -> Double { return x + 23 }
}

struct C24: C {
  let x: Double
  func f() -> Double { return x + 24 }
}

struct C25: C {
  let x: Double
  func f() -> Double { return x + 25 }
}

struct C26: C {
  let x: Double
  func f() -> Double { return x + 26 }
}

struct C27: C {
  let x: Double
  func f() -> Double { return x + 27 }
}

struct C28: C {
  let x: Double
  func f() -> Double { return x + 28 }
}

struct C29: C {
  let x: Double
  func f() -> Double { return x + 29 }
}

struct C30: C {
  let x: Double
  func f() -> Double { return x + 30 }
}

struct C31: C {
  let x: Double
  func f() -> Double { return x + 31 }
}

struct C32: C {
  let x: Double
  func f() -> Double { return x + 32 }
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
