public import ISO_9945_Kernel_File

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    extension ISO_9945.Kernel.File.Flush {

        @inlinable
        public static func data(
            _ descriptor: borrowing ISO_9945.Kernel.Descriptor
        ) throws(Self.Error) {
            while true {
                do throws(Self.Error) {
                    try Self.barrierFsync(descriptor)
                    return
                } catch  where error.code.isInterrupted {
                    continue
                }
            }
        }
    }

    extension ISO_9945.Kernel.File.Flush {

        @inlinable
        public static func full(
            _ descriptor: borrowing ISO_9945.Kernel.Descriptor
        ) throws(Self.Error) {
            while true {
                do throws(Self.Error) {
                    try Self.fullFsync(descriptor)
                    return
                } catch  where error.code.isInterrupted {
                    continue
                }
            }
        }
    }

    extension ISO_9945.Kernel.File.Flush {

        @inlinable
        public static func barrier(
            _ descriptor: borrowing ISO_9945.Kernel.Descriptor
        ) throws(Self.Error) {
            while true {
                do throws(Self.Error) {
                    try Self.barrierFsync(descriptor)
                    return
                } catch  where error.code.isInterrupted {
                    continue
                }
            }
        }
    }

#endif
