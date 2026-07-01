// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-loader open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-loader project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Darwin uses POSIX loader APIs (dlopen/dlsym) for symbol lookup
// and Darwin-specific dyld APIs for section enumeration
@_exported public import POSIX_Loader
@_exported public import Darwin_Loader_Standard
