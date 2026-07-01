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
@testable import Darwin_Kernel

extension Random {
    @Suite struct Tests {
        @Suite struct Unit {
            @Test func `fill writes random bytes into buffer`() throws {
                var bytes = [UInt8](repeating: 0, count: 32)
                try unsafe bytes.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }

                let nonZeroCount = bytes.filter { $0 != 0 }.count
                #expect(nonZeroCount > 0, "32 random bytes should not all be zero")
            }

            @Test func `fill handles single byte`() throws {
                var bytes = [UInt8](repeating: 0, count: 1)
                try unsafe bytes.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }
                // Single byte: can be zero, just verify no crash
            }

            @Test func `fill handles large buffer`() throws {
                var bytes = [UInt8](repeating: 0, count: 4096)
                try unsafe bytes.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }

                let nonZeroCount = bytes.filter { $0 != 0 }.count
                #expect(nonZeroCount > 0, "4096 random bytes should not all be zero")
            }

            @Test func `successive fills produce different output`() throws {
                var first = [UInt8](repeating: 0, count: 32)
                var second = [UInt8](repeating: 0, count: 32)

                try unsafe first.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }
                try unsafe second.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }

                #expect(first != second, "Two 32-byte fills should differ")
            }
        }

        @Suite struct `Edge Case` {
            @Test func `fill with empty buffer does not crash`() throws {
                var bytes = [UInt8]()
                try unsafe bytes.withUnsafeMutableBytes { buffer in
                    try unsafe Random.fill(buffer)
                }
            }
        }
    }
}
