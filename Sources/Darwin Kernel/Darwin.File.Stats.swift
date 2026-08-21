#if canImport(Darwin)

    public import Darwin_Kernel_Standard
    public import ISO_9945_Core

    extension Darwin.File.Stats {

        public static func get(
            descriptor: borrowing ISO_9945.Kernel.Descriptor
        ) throws(Error) -> Self {
            try Darwin_Kernel_Standard.Darwin.File.Stats.get(descriptor)
        }
    }

#endif
