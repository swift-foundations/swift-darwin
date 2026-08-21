public import System_Primitives

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    internal import Darwin_Kernel_Standard

    extension System.Memory {

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

#endif
