// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-darwin open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-darwin project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// MARK: - Role
//
// Darwin-side L3 extensions on the cross-platform `System.*` namespace
// (`System.Memory.Total`, `System.Processor.Physical.Count`,
// `System.Topology.NUMA.Discover`). Uses Darwin-specific APIs (sysctl)
// internally but presents a namespace-neutral `System.*` surface.
//
// See [PLAT-ARCH-009] for the L3 platform package role definition.
//
// MARK: - Role Split from `Darwin Kernel`
//
// `Darwin System` is a separate target from `Darwin Kernel` because
// `swift-foundations/swift-systems` is an independent consumer that
// needs only the `System.*` extensions, not the much larger `ISO_9945.Kernel.*`
// surface. Merging into `Darwin Kernel` would force swift-systems to
// pull in Kernel File / Socket / Process / Thread / Event primitives
// it does not use, violating [MOD-008]'s independent-consumer rule
// and [MOD-006]'s dependency minimization.
//
// The split axis is the L1 namespace: `ISO_9945.Kernel.*` (file / socket /
// process / thread / event abstractions) vs `System.*` (system-info
// queries: memory totals, CPU topology, NUMA). Both extend cross-
// platform L1 namespaces using Darwin L2 syscalls.
@_exported public import System_Primitives
