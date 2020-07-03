// swift-tools-version:5.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "SwiftySCADKit",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "SwiftySCADKit", targets: ["SwiftySCADKit"]),
    ],
    targets: [
        .target(name: "SwiftySCADKit", dependencies: []),
        .testTarget(name: "SwiftySCADKitTests", dependencies: ["SwiftySCADKit"]),
    ]
)
