// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "swift-http",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "SwiftHttp", targets: ["SwiftHttp"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "SwiftHttp", dependencies: []),
        .testTarget(name: "SwiftHttpTests", dependencies: ["SwiftHttp"]),
    ]
)
