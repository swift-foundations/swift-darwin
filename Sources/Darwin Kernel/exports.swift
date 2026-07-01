// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-darwin open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-darwin project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

@_exported public import Darwin_Kernel_Standard
@_exported public import Darwin_Kernel_Event_Standard
@_exported public import ISO_9945_Core
@_exported public import Clock_Primitives
@_exported public import Error_Primitives
@_exported public import Memory_Primitives
@_exported public import Random_Primitives
@_exported public import System_Primitives
@_exported public import Path_Primitives
@_exported public import Random_Primitives
// Wave 3.5-Final-Atomic (2026-05-02): consolidate to umbrella POSIX_Kernel import
// (covers POSIX root namespace + all POSIX.Kernel.X sub-namespaces post-flip).
// Umbrella module re-exports all POSIX Kernel sub-modules including Time, Identity,
// Poll, Glob, Clock, Descriptor — needed for cross-platform Kernel typealias resolution.
@_exported public import POSIX_Kernel

/// Cross-platform `Kernel` namespace at L3.
///
/// Wave 3.5-Final-Atomic (2026-05-02): flipped from `ISO_9945.Kernel` to
/// `POSIX.Kernel`. Per Wave 3.5 envelope (Item 4 of post-Path-X cycles),
/// POSIX-shared content is now wrapped at the `POSIX.Kernel.X` namespace
/// with method-wrappers + value-type typealiases delegating to iso-9945
/// typed Phase 1.5 forms. The L3-unifier `Kernel` typealias targets
/// POSIX.Kernel; typealias transitivity resolves the chain to iso-9945
/// at compile time, preserving L3-policy → L2 → L1 composition discipline
/// per [PLAT-ARCH-008e]. swift-kernel umbrella's cross-platform `Kernel`
/// typealias mirrors this.
public typealias Kernel = POSIX.Kernel

/// Re-export Darwin namespace (flows through Darwin_Kernel_Standard via @_exported Core).
public typealias Darwin = Darwin_Kernel_Standard.Darwin

/// Re-export Random namespace from Random_Primitives.
public typealias Random = Random_Primitives.Random

// MARK: - Kqueue bridge (Wave 3.5-Final-Atomic mirror of IO.Uring at swift-linux)
//
// Darwin's Kqueue lives at L2 swift-darwin-standard
// (`Darwin Kernel Event Standard/Darwin.Kernel.Kqueue.swift:26` —
// `public typealias Kqueue = ISO_9945.Kernel.Event.Queue` inside
// `#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)`).
// Pre-flip, `Kernel.Kqueue` resolved via `Kernel = ISO_9945.Kernel`
// directly. Post-flip (`Kernel = POSIX.Kernel`), `Kernel.Kqueue` would
// resolve to `POSIX.Kernel.Kqueue` — but POSIX.Kernel has no Kqueue
// (Darwin-specific; not part of POSIX-shared surface).
//
// This typealias bridges the namespace gap. Mirrors the IO.Uring bridge
// at swift-linux L3, preserving [PLAT-ARCH-008e] composition discipline:
// Darwin-specific bridging is Darwin's L3-policy responsibility, not the
// cross-platform L3-unifier's.
#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
extension POSIX.Kernel {
    public typealias Kqueue = ISO_9945.Kernel.Kqueue
}
#endif
