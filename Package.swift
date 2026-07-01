// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-darwin",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Darwin Kernel",
            targets: ["Darwin Kernel"]
        ),
        .library(
            name: "Darwin Loader",
            targets: ["Darwin Loader"]
        ),
        .library(
            name: "Darwin System",
            targets: ["Darwin System"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-darwin-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-memory-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-system-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-random-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-error-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-path-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-clock-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-posix.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-9945.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Darwin Kernel",
            dependencies: [
                .product(name: "Darwin Kernel Standard", package: "swift-darwin-standard"),
                .product(name: "Darwin Kernel Event Standard", package: "swift-darwin-standard"),
                .product(name: "Clock Primitives", package: "swift-clock-primitives"),
                .product(name: "Error Primitives", package: "swift-error-primitives"),
                .product(name: "Memory Primitives", package: "swift-memory-primitives"),
                .product(name: "Random Primitives", package: "swift-random-primitives"),
                .product(name: "System Primitives", package: "swift-system-primitives"),
                .product(name: "Path Primitives", package: "swift-path-primitives"),
                // Wave 3.5-Final-Atomic (2026-05-02): consolidate to umbrella POSIX Kernel product
                // (covers all POSIX.Kernel.X namespaces post-flip — Time/Identity/Poll/Glob/Clock/Descriptor
                // were missing from individual deps). Umbrella product re-exports all sub-modules.
                .product(name: "POSIX Kernel", package: "swift-posix"),
                .product(name: "ISO 9945 Kernel", package: "swift-iso-9945"),
                .product(name: "ISO 9945 Core", package: "swift-iso-9945"),
                .product(name: "ISO 9945 Kernel File", package: "swift-iso-9945"),
            ]
        ),
        .target(
            name: "Darwin Loader",
            dependencies: [
                .product(name: "Darwin Loader Standard", package: "swift-darwin-standard"),
                .product(name: "POSIX Loader", package: "swift-posix"),
            ]
        ),
        .target(
            name: "Darwin System",
            dependencies: [
                .product(name: "System Primitives", package: "swift-system-primitives"),
                .product(name: "Darwin Kernel Standard", package: "swift-darwin-standard"),
            ]
        ),

        // MARK: - Test Targets

        .testTarget(
            name: "Darwin Kernel Tests",
            dependencies: [
                "Darwin Kernel",
            ]
        ),
        .testTarget(
            name: "Darwin System Tests",
            dependencies: [
                "Darwin System",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
