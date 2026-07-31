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

public import System_Primitives

// `Darwin.Kernel.Sysctl` is declared under swift-darwin-standard's own
// `#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)`
// gate (see Darwin Kernel/exports.swift's Kqueue bridge and
// POSIX.Kernel.Thread.ID.swift for the matching idiom in this package).
// This target's `platforms:` list is Apple-only, but SwiftPM still
// type-checks the source against a Linux triple for the DocC docs leg,
// so the consuming extension needs the same gate as the declaration.
#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    internal import Darwin_Kernel_Standard

    extension System.Processor.Physical {
        /// Physical processor count via `sysctl("hw.physicalcpu")`.
        ///
        /// Returns the number of physical CPU cores, excluding hyperthreading
        /// and efficiency/performance core distinctions. Delegates to L2
        /// ``Darwin/Kernel/Sysctl/byName(_:as:)`` per [PLAT-ARCH-008c].
        ///
        /// - Note: On Apple Silicon, this returns the total physical core count
        ///   (performance + efficiency cores combined).
        public static var count: System.Processor.Count {
            let value: Int32
            do throws(Darwin.Kernel.Sysctl.Error) {
                value = try Darwin.Kernel.Sysctl.byName("hw.physicalcpu", as: Int32.self)
            } catch {
                value = 0
            }
            let clamped = value > 0 ? UInt(value) : 1
            return System.Processor.Count(_unchecked: Cardinal(clamped))
        }
    }

#endif
