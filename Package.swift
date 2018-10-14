// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "SwiftySCADKit",
    products: [
        .library(name: "SwiftySCADKit", targets: ["SwiftySCADKit"]),
    ],
    targets: [
        .target(name: "SwiftySCADKit", dependencies: []),
        .testTarget(name: "SwiftySCADKitTests", dependencies: ["SwiftySCADKit"]),
    ]
)
