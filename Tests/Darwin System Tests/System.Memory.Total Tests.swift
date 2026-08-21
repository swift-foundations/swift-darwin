import Testing

@testable import Darwin_System

extension System.Memory {
    @Suite struct Tests {
        @Suite struct Unit {
            @Test func `total returns positive value`() {
                let total = System.Memory.total
                let bytes = Int(total)
                #expect(bytes > 0, "Total physical memory must be positive")
            }

            @Test func `total exceeds one megabyte`() {
                let total = System.Memory.total
                let bytes = Int(total)
                let oneMB = 1024 * 1024
                #expect(bytes > oneMB, "Total memory should exceed 1 MB")
            }

            @Test func `total is consistent across reads`() {
                let first = Int(System.Memory.total)
                let second = Int(System.Memory.total)
                #expect(first == second, "Total memory should be stable between reads")
            }
        }
    }
}
