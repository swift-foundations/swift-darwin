extension Darwin {

    public typealias Random = Random_Primitives.Random
}

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)

    extension Random {

        public static func fill(
            _ buffer: UnsafeMutableRawBufferPointer
        ) throws(Error) {
            try unsafe Darwin.Kernel.Random.arc4random(buffer)
        }
    }

#endif
