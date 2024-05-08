/// An ordered, random-access collection guaranteeing index stability.
///
/// This collection can be used instead of `Array` in situations where the index of a particular
/// element must not be invalidated by the removal of another element.
public struct StableArray<Element> {

  /// The representation of a stable array.
  private class Representation {

    /// The internal capacity of the buffer.
    let capacity: Int

    /// The number of active elements in the buffer.
    var count: Int

    /// The position immediately after the last active element in the buffer.
    var end: Int

    /// The elements of the buffer.
    let elements: UnsafeMutablePointer<(Element, Bool)>

    /// Creates an instance capable of storing `capacity` elements.
    init(capacity: Int) {
      self.capacity = capacity
      self.count = 0
      self.end = 0
      self.elements = .allocate(capacity: capacity)
    }

    deinit {
      for i in 0 ..< end {
        let e = elements.advanced(by: i)
        if e.pointee.1 { e.deinitialize(count: 1) }
      }
    }

  }

  /// The elements in `self`.
  private var representation: Representation

  /// Creates an empty instance.
  public init() {
    self.representation = .init(capacity: 0)
  }

  /// `true` if `self` is empty.
  public var isEmpty: Bool {
    representation.count == 0
  }

  /// The number of elements in `self`.
  public var count: Int {
    representation.count
  }

  /// The number of elements that can be stored in `self` before new storage is allocated.
  public var capacity: Int {
    representation.count + (representation.capacity - representation.end)
  }

  /// Returns `true` if `i` is the index of an element in `self`.
  public func isActiveIndex(_ i: Index) -> Bool {
    (i < representation.end) && representation.elements[i].1
  }

  /// Appends `e` at the end of `self`.
  public mutating func append(_ e: Element) {
    let currentCapacity = capacity
    let currentCount = count

    if !isKnownUniquelyReferenced(&representation) || (currentCapacity <= currentCount) {
      // Create a new buffer.
      var newRepresentation = Representation(capacity: Swift.max(1, currentCapacity * 2))
      newRepresentation.count = representation.count
      newRepresentation.end = representation.end

      // Move existing elements.
      representation.end = 0
      newRepresentation.elements.moveInitialize(from: representation.elements, count: currentCount)
      swap(&representation, &newRepresentation)
    }

    appendAssumingUniqueAndLargeEnough(e)
  }

  /// Appends `e` at the end of `self` assuming it is not shared and has sufficient capacity.
  private func appendAssumingUniqueAndLargeEnough(_ e: Element) {
    let p = representation.end
    assert(capacity > p)
    representation.count += 1
    representation.end += 1
    representation.elements.advanced(by: p).initialize(to: (e, true))
  }

  /// Removes the element at position `p` in `self` and returns its value.
  @discardableResult
  public mutating func remove(at p: Int) -> Element {
    ensureUnique()

    precondition(isActiveIndex(p), "index is out of range")

    representation.count -= 1
    representation.elements[p].1 = false

    // Did we remove the last element?
    if p == (representation.end - 1) {
      var end = p
      while (end > 0) && !representation.elements.advanced(by: end - 1).pointee.1 { end -= 1 }
      representation.end = end
    }

    return representation.elements
      .advanced(by: p)
      .withMemoryRebound(to: Element.self, capacity: 1, { (e) in e.move() })
  }

  /// Ensures that `self` is not shared.
  private mutating func ensureUnique() {
    if !isKnownUniquelyReferenced(&representation) {
      // Create a new buffer.
      var newRepresentation = Representation(capacity: capacity)
      newRepresentation.count = representation.count
      newRepresentation.end = representation.end

      // Copy existing elements.
      newRepresentation.elements.initialize(from: representation.elements, count: count)
      swap(&representation, &newRepresentation)
    }
  }

}

extension StableArray: ExpressibleByArrayLiteral {

  public init(arrayLiteral elements: Element...) {
    self = .init()
    for e in elements { self.append(e) }
  }

}

extension StableArray: MutableCollection {

  public typealias Index = Int

  public var startIndex: Int {
    index(after: -1)
  }

  public var endIndex: Int {
    representation.end
  }

  public func index(after p: Int) -> Int {
    let end = endIndex
    for i in (p + 1) ..< end where representation.elements[i].1 { return i }
    return p + 1
  }

  public subscript(p: Int) -> Element {
    _read {
      precondition(isActiveIndex(p))
      yield representation.elements[p].0
    }
    _modify {
      precondition(isActiveIndex(p))
      yield &representation.elements.advanced(by: p).pointee.0
    }
  }

}

extension StableArray: CustomStringConvertible {

  public var description: String {
    "[" +  self.map(String.init(describing:)).joined(separator: ", ") + "]"
  }

}
