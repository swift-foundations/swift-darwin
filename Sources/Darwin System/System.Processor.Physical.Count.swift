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
        let value = (try? Darwin.Kernel.Sysctl.byName("hw.physicalcpu", as: Int32.self)) ?? 0
        let clamped = value > 0 ? UInt(value) : 1
        return System.Processor.Count(_unchecked: Cardinal(clamped))
    }
}
