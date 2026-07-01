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

extension System.Topology.NUMA {
    /// NUMA topology discovery on Darwin.
    ///
    /// macOS and iOS do not expose NUMA topology information.
    /// Returns `.unavailable` to indicate honest "cannot determine"
    /// rather than assuming UMA.
    ///
    /// - Note: Apple Silicon Macs may have non-uniform memory characteristics
    ///   (performance vs efficiency cores, memory controllers), but Apple
    ///   does not expose this as NUMA topology.
    public static func discover() -> System.Topology.NUMA.State {
        .unavailable
    }
}
