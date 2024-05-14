package rays.inheritance.algorithms

import scala.collection.mutable

/** Returns the start index of the partition of a collection that matches the given predicate. */
extension[T] (self: mutable.ArrayBuffer[T]) def partitioningIndex(
    belongsInSecondPartition: T => Boolean
): Int =
  var n = self.length
  var l = 0
  while n > 0 do
    val h = n / 2
    val m = l + h
    if belongsInSecondPartition(self(m)) then
      n = h
    else
      l += 1
      n -= h + 1
  l
