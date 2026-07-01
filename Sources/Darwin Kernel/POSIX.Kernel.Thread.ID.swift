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

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

// MARK: - POSIX.Kernel.Thread.ID bridge (Wave 3.5-Final-Atomic Class B Completion)
//
// 2026-05-02 — Class B bridge typealias for `Kernel.Thread.ID` on Darwin.
//
// Discovered during Item 5 Phase 4 downstream verification cascade
// (swift-io test-support consumed `Kernel.Thread.ID` post-flip and
// surfaced the gap). Initial Class A attempt at swift-posix failed to
// compile because `ISO_9945.Kernel.Thread.ID` is declared at L2
// platform-specific `Darwin_Kernel_Standard` (Mach-port-UInt32 struct)
// — swift-posix L3-policy has no visibility into platform-specific L2
// modules per [PLAT-ARCH-008e].
//
// Architectural placement: this bridge belongs at swift-darwin L3-policy,
// where the Darwin-specific L2 module (`Darwin_Kernel_Standard`) is
// already imported via the umbrella `@_exported public import` chain.
// Same precedent as Wave 3.5-Final-Atomic IO.Uring bridge at swift-linux L3
// + Kqueue bridge at swift-darwin L3 — Darwin-specific bridging is the
// platform L3-policy's responsibility, not swift-posix L3-policy's.
//
// On Darwin, `ISO_9945.Kernel.Thread.ID` resolves to the Mach-port-name
// struct declared at `Darwin_Kernel_Standard/Darwin.Kernel.Thread.ID.swift:26`.
// Linux platforms get the pid_t struct from `Linux_Kernel_System_Standard`
// via the symmetric bridge at swift-linux L3.

extension POSIX.Kernel.Thread {
    /// Thread identifier (Hashable, Sendable, RawRepresentable,
    /// CustomStringConvertible) — typealias to canonical Darwin-specific
    /// L2 declaration (Mach port name as `UInt32`).
    public typealias ID = ISO_9945.Kernel.Thread.ID
}

#endif
