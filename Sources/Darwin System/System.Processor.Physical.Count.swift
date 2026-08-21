public import System_Primitives

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    internal import Darwin_Kernel_Standard

    extension System.Processor.Physical {

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
