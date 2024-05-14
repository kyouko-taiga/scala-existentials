import Lcg

public protocol C {
  func f() -> Double
}

struct C1: C {
  let x: Double
  func f() -> Double { return x + 401.0 }
}

struct C2: C {
  let x: Double
  func f() -> Double { return x + 402.0 }
}

struct C3: C {
  let x: Double
  func f() -> Double { return x + 403.0 }
}

struct C4: C {
  let x: Double
  func f() -> Double { return x + 404.0 }
}

struct C5: C {
  let x: Double
  func f() -> Double { return x + 405.0 }
}

struct C6: C {
  let x: Double
  func f() -> Double { return x + 406.0 }
}

struct C7: C {
  let x: Double
  func f() -> Double { return x + 407.0 }
}

struct C8: C {
  let x: Double
  func f() -> Double { return x + 408.0 }
}

struct C9: C {
  let x: Double
  func f() -> Double { return x + 409.0 }
}

struct C10: C {
  let x: Double
  func f() -> Double { return x + 410.0 }
}

struct C11: C {
  let x: Double
  func f() -> Double { return x + 411.0 }
}

struct C12: C {
  let x: Double
  func f() -> Double { return x + 412.0 }
}

struct C13: C {
  let x: Double
  func f() -> Double { return x + 413.0 }
}

struct C14: C {
  let x: Double
  func f() -> Double { return x + 414.0 }
}

struct C15: C {
  let x: Double
  func f() -> Double { return x + 415.0 }
}

struct C16: C {
  let x: Double
  func f() -> Double { return x + 416.0 }
}

struct C17: C {
  let x: Double
  func f() -> Double { return x + 417.0 }
}

struct C18: C {
  let x: Double
  func f() -> Double { return x + 418.0 }
}

struct C19: C {
  let x: Double
  func f() -> Double { return x + 419.0 }
}

struct C20: C {
  let x: Double
  func f() -> Double { return x + 420.0 }
}

struct C21: C {
  let x: Double
  func f() -> Double { return x + 421.0 }
}

struct C22: C {
  let x: Double
  func f() -> Double { return x + 422.0 }
}

struct C23: C {
  let x: Double
  func f() -> Double { return x + 423.0 }
}

struct C24: C {
  let x: Double
  func f() -> Double { return x + 424.0 }
}

struct C25: C {
  let x: Double
  func f() -> Double { return x + 425.0 }
}

struct C26: C {
  let x: Double
  func f() -> Double { return x + 426.0 }
}

struct C27: C {
  let x: Double
  func f() -> Double { return x + 427.0 }
}

struct C28: C {
  let x: Double
  func f() -> Double { return x + 428.0 }
}

struct C29: C {
  let x: Double
  func f() -> Double { return x + 429.0 }
}

struct C30: C {
  let x: Double
  func f() -> Double { return x + 430.0 }
}

struct C31: C {
  let x: Double
  func f() -> Double { return x + 431.0 }
}

struct C32: C {
  let x: Double
  func f() -> Double { return x + 432.0 }
}

public func randomAnyC(classIndex: Int, value: Double) -> any C {
  switch classIndex {
    case 0: return C1(x: value)
    case 1: return C2(x: value)
    case 2: return C3(x: value)
    case 3: return C4(x: value)
    case 4: return C5(x: value)
    case 5: return C6(x: value)
    case 6: return C7(x: value)
    case 7: return C8(x: value)
    case 8: return C9(x: value)
    case 9: return C10(x: value)
    case 10: return C11(x: value)
    case 11: return C12(x: value)
    case 12: return C13(x: value)
    case 13: return C14(x: value)
    case 14: return C15(x: value)
    case 15: return C16(x: value)
    case 16: return C17(x: value)
    case 17: return C18(x: value)
    case 18: return C19(x: value)
    case 19: return C20(x: value)
    case 20: return C21(x: value)
    case 21: return C22(x: value)
    case 22: return C23(x: value)
    case 23: return C24(x: value)
    case 24: return C25(x: value)
    case 25: return C26(x: value)
    case 26: return C27(x: value)
    case 27: return C28(x: value)
    case 28: return C29(x: value)
    case 29: return C30(x: value)
    case 30: return C31(x: value)
    case 31: return C32(x: value)
    default: fatalError("Invalid class type index: \(classIndex)")
  }
}
