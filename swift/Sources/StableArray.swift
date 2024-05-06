/// An ordered, random-access collection guaranteeing index stability.
///
/// This collection can be used instead of `Array` in situations where the index of a particular
/// element must not be invalidated by the removal of another element.
struct StableArray<Element> {

  /// A position in a stable array.
  public struct Index: Hashable, Comparable {

    /// The raw value of this position.
    public let rawValue: Int

    /// Returns `true` if `l` precedes `r`.
    public static func < (l: Self, r: Self) -> Bool { l.rawValue < r.rawValue }

  }

  /// The contents of a cell in the underying array.
  fileprivate enum Cell {

    /// A cell occupied with an element.
    case occupied(Element)

    /// An empty cell pointing at the next occupied cell.
    case empty(next: UInt32)

    /// `true` if `self` is occupied.
    var isOccupied: Bool {
      if case .occupied = self { return true } else { return false }
    }

    /// Returns the element contained in `self`, which is occupied.
    var occupant: Element {
      guard case .occupied(let v) = self else { fatalError() }
      return v
    }

  }

  /// The contents of the array.
  ///
  /// Each value of this array is a "cell" containing either an element, an index pointing at the
  /// next occupied cell, or the end position if there are no occupied cell after it. A cell is
  /// emptied if the element that it contained is removed from `self`.
  ///
  /// The data structure maintains that the last cell of the array is occupied.
  private var contents: [Cell] = []

  /// Creates an empty array.
  public init() {}

  /// Returns `true` if `i` is the index of an element in `self`.
  public func isActiveIndex(_ i: Index) -> Bool {
    (i.rawValue >= 0) && (i.rawValue < contents.count) && (contents[i.rawValue].isOccupied)
  }

  /// Appends `e` at the end of `self`.
  public mutating func append(_ e: Element) {
    contents.append(.occupied(e))
  }

  /// Removes the element at position `p` in `self` and returns its value.
  @discardableResult
  public mutating func remove(at p: Index) -> Element {
    // Are we removing the last element?
    if (p.rawValue == (contents.count - 1)) {
      return removeLast()
    }

    var e: Cell
    if case .empty(let n) = contents[p.rawValue + 1] {
      e = .empty(next: n)
    } else {
      e = .empty(next: UInt32(truncatingIfNeeded: p.rawValue + 1))
    }

    if (p.rawValue > 0) && !contents[p.rawValue - 1].isOccupied {
      contents[p.rawValue - 1] = e
    }

    swap(&e, &contents[p.rawValue])
    return e.occupant
  }

  /// Removes the last element in `self` and returns its value.
  public mutating func removeLast() -> Element {
    let e = contents.removeLast()
    if let i = contents.lastIndex(where: \.isOccupied) {
      contents.removeSubrange((i + 1)...)
    } else {
      contents.removeAll(keepingCapacity: true)
    }
    return e.occupant
  }

}

extension StableArray: ExpressibleByArrayLiteral {

  public init(arrayLiteral elements: Element...) {
    self.contents = elements.map({ (e) in .occupied(e) })
  }

}

extension StableArray: MutableCollection {

  public var startIndex: Index {
    if !contents.isEmpty, case .empty(let n) = contents[0] {
      return .init(rawValue: .init(truncatingIfNeeded: n))
    } else {
      return .init(rawValue: 0)
    }
  }

  public var endIndex: Index {
    .init(rawValue: contents.endIndex)
  }

  public func index(after i: Index) -> Index {
    if ((i.rawValue + 1) < contents.count), case .empty(let n) = contents[i.rawValue + 1] {
      return .init(rawValue: .init(truncatingIfNeeded: n))
    } else {
      return .init(rawValue: i.rawValue + 1)
    }
  }

  public subscript(i: Index) -> Element {
    get { contents[i.rawValue].occupant }
    set { contents[i.rawValue] = .occupied(newValue) }
  }

}

extension StableArray.Cell: Equatable where Element: Equatable {}

extension StableArray: Equatable where Element: Equatable {}

extension StableArray.Cell: Hashable where Element: Hashable {}

extension StableArray: Hashable where Element: Hashable {}

extension StableArray: CustomStringConvertible {

  public var description: String {
    "[" +  self.map(String.init(describing:)).joined(separator: ", ") + "]"
  }

}
