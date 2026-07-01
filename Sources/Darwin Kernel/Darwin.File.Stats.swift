// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-darwin open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-darwin project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

#if canImport(Darwin)

public import Darwin_Kernel_Standard
public import ISO_9945_Core

// MARK: - L3-policy typed wrapper

extension Darwin.File.Stats {
    /// Gets Darwin-specific file metadata for an open file descriptor.
    ///
    /// L3-policy convenience overload exposing a labelled-`descriptor:` shape
    /// alongside the L2 typed form `Darwin.File.Stats.get(_:)` (which takes
    /// the same `borrowing ISO_9945.Kernel.Descriptor` parameter without
    /// label). Both end up calling the same L2 typed entry; this overload
    /// exists only to preserve a labelled call shape used by some consumers.
    ///
    /// - Parameter descriptor: The file descriptor to stat.
    /// - Returns: Darwin file metadata including birthtime.
    /// - Throws: ``Kernel/File/Stats/Error`` if the syscall fails.
    public static func get(descriptor: borrowing ISO_9945.Kernel.Descriptor) throws(Error) -> Self {
        try Darwin_Kernel_Standard.Darwin.File.Stats.get(descriptor)
    }
}

#endif
