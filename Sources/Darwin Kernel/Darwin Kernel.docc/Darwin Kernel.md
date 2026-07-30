# ``Darwin_Kernel``

@Metadata {
    @DisplayName("Darwin Kernel")
    @TitleHeading("Swift Foundations")
}

The Darwin-specific completion of the ISO 9945 (POSIX) kernel spec: file
metadata and flush semantics, cryptographically secure random fill via
`arc4random_buf`, and `Kernel.Thread.ID` bridging, layered over the L1
primitives (`Clock`, `Error`, `Memory`, `Random`, `System`, `Path`) and the
shared `POSIX Kernel` product.

## When to use this

Reach for this package when code needs a POSIX kernel operation to actually
run on macOS, iOS, tvOS, watchOS, or visionOS — it supplies the
platform-specific bodies (Darwin's Mach-port thread IDs, `arc4random`-backed
random fill, Darwin's file-stats and flush behavior) behind the
cross-platform `ISO 9945` names that `swift-posix` and higher layers depend
on. Code that only needs the POSIX names themselves, portable across
platforms, should depend on `swift-iso-9945` or `swift-posix` directly rather
than this package; reach for `swift-linux` for the equivalent completion on
Linux.

## Topics

### Related packages

- [swift-iso-9945](https://github.com/swift-iso/swift-iso-9945) — the
  cross-platform POSIX kernel spec this package completes for Darwin.
- [swift-posix](https://github.com/swift-foundations/swift-posix) — the
  shared POSIX Kernel product this package's targets depend on.
- [swift-linux](https://github.com/swift-foundations/swift-linux) — the
  equivalent completion for Linux.
