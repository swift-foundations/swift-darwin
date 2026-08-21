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
