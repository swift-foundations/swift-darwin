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

extension System.Processor.Physical {
    @Suite struct Tests {
        @Suite struct Unit {
            @Test func `count returns at least one`() {
                let count = System.Processor.Physical.count
                let value = Int(count)
                #expect(value >= 1, "Physical processor count must be at least 1")
            }

            @Test func `count does not exceed logical processor count`() {
                let physical = Int(System.Processor.Physical.count)
                let logical = Int(System.Processor.count)
                #expect(
                    physical <= logical,
                    "Physical cores (\(physical)) should not exceed logical processors (\(logical))"
                )
            }

            @Test func `count is consistent across reads`() {
                let first = Int(System.Processor.Physical.count)
                let second = Int(System.Processor.Physical.count)
                #expect(first == second, "Physical processor count should be stable between reads")
            }
        }
    }
}
