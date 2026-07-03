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

internal import Darwin_Kernel_Standard
public import System_Primitives

extension System.Memory {
    /// Total physical memory via `sysctl("hw.memsize")`.
    ///
    /// Returns the total installed RAM in bytes. Delegates to L2
    /// ``Darwin/Kernel/Sysctl/byName(_:as:)`` per [PLAT-ARCH-008c].
    public static var total: System.Memory.Capacity {
        let value: UInt64
        do throws(Darwin.Kernel.Sysctl.Error) {
            value = try Darwin.Kernel.Sysctl.byName("hw.memsize", as: UInt64.self)
        } catch {
            value = 0
        }
        return Self.Capacity(_unchecked: Cardinal(UInt(value)))
    }
}
