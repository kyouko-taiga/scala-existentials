public struct Random {
    public var seed: UInt64

    public init(seed: UInt64) {
        self.seed = seed
    }

    /// Maximum int value that can be represented as a double without loss of
    /// precision.
    private static let MAX_INT_AS_DOUBLE: UInt64 = 0x0FFFFFFFFFFFFF

    /// Returns a random `UInt64` value, using the linear congruential generator
    /// algorithm.
    public mutating func nextUInt64() -> UInt64 {
        seed = (6364136223846793005 &* seed) &+ 1
        return seed   
    }

    public mutating func nextDoubleBetween(min: Double, max: Double) -> Double {
        let value = Double(nextUInt64() & Random.MAX_INT_AS_DOUBLE)
        let normalized = value / Double(Random.MAX_INT_AS_DOUBLE)
        return min + (max - min) * normalized
    }   
}
