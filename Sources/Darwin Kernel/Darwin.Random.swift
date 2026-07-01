// Darwin.Random.swift
// Cryptographically-secure random number generation for Darwin platforms.

// MARK: - Typealias

extension Darwin {
    /// Typealias to Random namespace.
    ///
    /// Allows `Darwin.Random.fill()` syntax while sharing the same
    /// underlying type across all platforms.
    public typealias Random = Random_Primitives.Random
}

// MARK: - Platform Implementation

extension Random {
    /// Fills the buffer with cryptographically-secure random bytes.
    ///
    /// Delegates to ``Darwin/Kernel/Random/arc4random(_:)-(UnsafeMutableRawBufferPointer)``
    /// which wraps `arc4random_buf` — always succeeds, never blocks on Darwin.
    /// The error-mapping path is present for signature compatibility; on Darwin
    /// the L2 body never actually throws.
    ///
    /// - Parameter buffer: The buffer to fill with random bytes.
    ///   If the buffer is empty, this method returns immediately.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var bytes = [UInt8](repeating: 0, count: 32)
    /// try bytes.withUnsafeMutableBytes { buffer in
    ///     try Random.fill(buffer)
    /// }
    /// ```
    public static func fill(
        _ buffer: UnsafeMutableRawBufferPointer
    ) throws(Error) {
        try unsafe Darwin.Kernel.Random.arc4random(buffer)
    }
}
