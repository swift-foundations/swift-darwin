#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    extension POSIX.Kernel.Thread {

        public typealias ID = ISO_9945.Kernel.Thread.ID
    }

#endif
