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

import Testing
@testable import Darwin_System

extension System.Topology.NUMA {
    @Suite struct Tests {
        @Suite struct Unit {
            @Test func `discover returns unavailable on Darwin`() {
                let state = System.Topology.NUMA.discover()
                #expect(
                    state == .unavailable,
                    "Darwin does not expose NUMA topology; discover must return .unavailable"
                )
            }

            @Test func `discover is idempotent`() {
                let first = System.Topology.NUMA.discover()
                let second = System.Topology.NUMA.discover()
                #expect(first == second, "NUMA discovery should return consistent results")
            }
        }
    }
}
