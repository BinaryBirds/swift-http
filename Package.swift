// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-http",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
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
