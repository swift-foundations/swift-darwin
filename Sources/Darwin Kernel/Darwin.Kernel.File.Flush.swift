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

public import ISO_9945_Kernel_File

// MARK: - Darwin-specific File.Flush policy
//
// Per [PLAT-ARCH-008k] Spec/Policy Namespace Split (Wave 3, 2026-04-30):
// `Linux.Kernel` and `Darwin.Kernel` are now distinct nominal types; these
// extensions target `ISO_9945.Kernel.File.Flush` directly (the spec-shared
// home) so swift-kernel can compose the cross-platform name without
// redeclaration. On Darwin, `ISO_9945.Kernel.File.Flush.{data,full,barrier}`
// ARE the canonical entry points — there is no companion at L3 swift-kernel;
// the platform packages (swift-darwin, swift-linux) extend the shared
// namespace directly per [PLAT-ARCH-008d] — this is the "platform-policy owns
// the unified name" shape, sibling to the "L3 unifier composes over L3
// platform-policy" shape used for POSIX `fsync`
// (`ISO_9945.Kernel.File.Flush.flush`).
//
// `POSIX.Kernel.File.Flush` hosts only the POSIX-shared wrappers (currently
// `flush` / `directory`); Darwin-specific policy (EINTR-wrapped fullFsync /
// barrierFsync) lives here per [PLAT-ARCH-002].

// MARK: - data(_:) — best data-only durability on Darwin

extension ISO_9945.Kernel.File.Flush {
    /// Synchronizes file data to storage with the best available Darwin
    /// semantic, automatically retrying on EINTR.
    ///
    /// Delegates to ``ISO_9945/Kernel/File/Flush/barrierFsync(_:)``
    /// (`fcntl(F_BARRIERFSYNC)`) — Darwin's closest "data-only-ish" semantic.
    /// F_BARRIERFSYNC is lighter than F_FULLFSYNC but still provides ordering
    /// guarantees: data reaches disk and a barrier ensures ordering with
    /// subsequent writes.
    ///
    /// Pairs with the Linux companion in swift-linux so consumers write
    /// `ISO_9945.Kernel.File.Flush.data(fd)` and get the right semantic on
    /// every POSIX platform.
    ///
    /// - Parameter descriptor: The file descriptor.
    /// - Throws: ``Kernel/File/Flush/Error`` on failure (excluding EINTR).
    @inlinable
    public static func data(_ descriptor: borrowing ISO_9945.Kernel.Descriptor) throws(ISO_9945.Kernel.File.Flush.Error) {
        while true {
            do {
                try ISO_9945.Kernel.File.Flush.barrierFsync(descriptor)
                return
            } catch where error.code.isInterrupted {
                continue  // Retry on EINTR
            }
        }
    }
}

// MARK: - full(_:) — F_FULLFSYNC with EINTR retry

extension ISO_9945.Kernel.File.Flush {
    /// Flushes data to permanent storage with full sync, automatically retrying
    /// on EINTR.
    ///
    /// Delegates to ``ISO_9945/Kernel/File/Flush/fullFsync(_:)``
    /// (`fcntl(F_FULLFSYNC)`). Ensures data is flushed through disk caches —
    /// the strongest durability guarantee available on Darwin.
    ///
    /// - Parameter descriptor: The file descriptor.
    /// - Throws: ``Kernel/File/Flush/Error`` on failure (excluding EINTR).
    @inlinable
    public static func full(_ descriptor: borrowing ISO_9945.Kernel.Descriptor) throws(ISO_9945.Kernel.File.Flush.Error) {
        while true {
            do {
                try ISO_9945.Kernel.File.Flush.fullFsync(descriptor)
                return
            } catch where error.code.isInterrupted {
                continue  // Retry on EINTR
            }
        }
    }
}

// MARK: - barrier(_:) — F_BARRIERFSYNC with EINTR retry

extension ISO_9945.Kernel.File.Flush {
    /// Flushes data with barrier sync, automatically retrying on EINTR.
    ///
    /// Delegates to ``ISO_9945/Kernel/File/Flush/barrierFsync(_:)``
    /// (`fcntl(F_BARRIERFSYNC)`). Lighter than `full(_:)` but still provides
    /// ordering guarantees: data reaches disk and a barrier ensures ordering
    /// with subsequent writes.
    ///
    /// - Parameter descriptor: The file descriptor.
    /// - Throws: ``Kernel/File/Flush/Error`` on failure (excluding EINTR).
    @inlinable
    public static func barrier(_ descriptor: borrowing ISO_9945.Kernel.Descriptor) throws(ISO_9945.Kernel.File.Flush.Error) {
        while true {
            do {
                try ISO_9945.Kernel.File.Flush.barrierFsync(descriptor)
                return
            } catch where error.code.isInterrupted {
                continue  // Retry on EINTR
            }
        }
    }
}
