import Lcg

public protocol C: AnyObject {
  func f() -> Double
}

final class C1: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 401.0 }
}

final class C2: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 402.0 }
}

final class C3: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 403.0 }
}

final class C4: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 404.0 }
}

final class C5: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 405.0 }
}

final class C6: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 406.0 }
}

final class C7: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 407.0 }
}

final class C8: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 408.0 }
}

final class C9: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 409.0 }
}

final class C10: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 410.0 }
}

final class C11: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 411.0 }
}

final class C12: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 412.0 }
}

final class C13: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 413.0 }
}

final class C14: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 414.0 }
}

final class C15: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 415.0 }
}

final class C16: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 416.0 }
}

final class C17: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 417.0 }
}

final class C18: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 418.0 }
}

final class C19: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 419.0 }
}

final class C20: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 420.0 }
}

final class C21: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 421.0 }
}

final class C22: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 422.0 }
}

final class C23: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 423.0 }
}

final class C24: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 424.0 }
}

final class C25: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 425.0 }
}

final class C26: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 426.0 }
}

final class C27: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 427.0 }
}

final class C28: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 428.0 }
}

final class C29: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 429.0 }
}

final class C30: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 430.0 }
}

final class C31: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 431.0 }
}

final class C32: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 432.0 }
}

public func randomC(classIndex: Int, value: Double) -> any C {
  switch classIndex {
    case 0: return C1(value)
    case 1: return C2(value)
    case 2: return C3(value)
    case 3: return C4(value)
    case 4: return C5(value)
    case 5: return C6(value)
    case 6: return C7(value)
    case 7: return C8(value)
    case 8: return C9(value)
    case 9: return C10(value)
    case 10: return C11(value)
    case 11: return C12(value)
    case 12: return C13(value)
    case 13: return C14(value)
    case 14: return C15(value)
    case 15: return C16(value)
    case 16: return C17(value)
    case 17: return C18(value)
    case 18: return C19(value)
    case 19: return C20(value)
    case 20: return C21(value)
    case 21: return C22(value)
    case 22: return C23(value)
    case 23: return C24(value)
    case 24: return C25(value)
    case 25: return C26(value)
    case 26: return C27(value)
    case 27: return C28(value)
    case 28: return C29(value)
    case 29: return C30(value)
    case 30: return C31(value)
    case 31: return C32(value)
    default: fatalError("Invalid final class type index: \(classIndex)")
  }
}
