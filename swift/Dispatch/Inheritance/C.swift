import Lcg

public protocol C: AnyObject {
  func f() -> Double
}

final class C1: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 1.0 }
}

final class C2: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 2.0 }
}

final class C3: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 3.0 }
}

final class C4: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 4.0 }
}

final class C5: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 5.0 }
}

final class C6: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 6.0 }
}

final class C7: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 7.0 }
}

final class C8: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 8.0 }
}

final class C9: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 9.0 }
}

final class C10: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 10.0 }
}

final class C11: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 11.0 }
}

final class C12: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 12.0 }
}

final class C13: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 13.0 }
}

final class C14: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 14.0 }
}

final class C15: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 15.0 }
}

final class C16: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 16.0 }
}

final class C17: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 17.0 }
}

final class C18: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 18.0 }
}

final class C19: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 19.0 }
}

final class C20: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 20.0 }
}

final class C21: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 21.0 }
}

final class C22: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 22.0 }
}

final class C23: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 23.0 }
}

final class C24: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 24.0 }
}

final class C25: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 25.0 }
}

final class C26: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 26.0 }
}

final class C27: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 27.0 }
}

final class C28: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 28.0 }
}

final class C29: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 29.0 }
}

final class C30: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 30.0 }
}

final class C31: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 31.0 }
}

final class C32: C {
  let x: Double
  init(_ x: Double) {
    self.x = x
  }
  func f() -> Double { return x + 32.0 }
}

public func randomC(random: inout Lcg.Random, classesCount: UInt64 = 32) -> C {
  let i = random.nextUInt64() % classesCount
  let randomDouble = random.nextDoubleBetween(min: 0.0, max: 10.0)
  switch i {
    case 0: return C1(randomDouble)
    case 1: return C2(randomDouble)
    case 2: return C3(randomDouble)
    case 3: return C4(randomDouble)
    case 4: return C5(randomDouble)
    case 5: return C6(randomDouble)
    case 6: return C7(randomDouble)
    case 7: return C8(randomDouble)
    case 8: return C9(randomDouble)
    case 9: return C10(randomDouble)
    case 10: return C11(randomDouble)
    case 11: return C12(randomDouble)
    case 12: return C13(randomDouble)
    case 13: return C14(randomDouble)
    case 14: return C15(randomDouble)
    case 15: return C16(randomDouble)
    case 16: return C17(randomDouble)
    case 17: return C18(randomDouble)
    case 18: return C19(randomDouble)
    case 19: return C20(randomDouble)
    case 20: return C21(randomDouble)
    case 21: return C22(randomDouble)
    case 22: return C23(randomDouble)
    case 23: return C24(randomDouble)
    case 24: return C25(randomDouble)
    case 25: return C26(randomDouble)
    case 26: return C27(randomDouble)
    case 27: return C28(randomDouble)
    case 28: return C29(randomDouble)
    case 29: return C30(randomDouble)
    case 30: return C31(randomDouble)
    case 31: return C32(randomDouble)
    default: fatalError("Invalid final class type index: \(i)")
  }
}
