extension Collection {

  /// Returns the start index of the partition of a collection that matches the given predicate.
  public func partitioningIndex(
    where belongsInSecondPartition: (Element) throws -> Bool
  ) rethrows -> Index {
    var n = count
    var l = startIndex

    while n > 0 {
      let h = n / 2
      let m = index(l, offsetBy: h)
      if try belongsInSecondPartition(self[m]) {
        n = h
      } else {
        l = index(after: m)
        n -= h + 1
      }
    }
    return l
  }

}
