// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "swift-http",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "SwiftHttp", targets: ["SwiftHttp"]),
        .library(name: "SwiftHttpFoundation", targets: ["SwiftHttpFoundation"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-log",
            from: "1.5.2"
        ),
        .package(
            url: "https://github.com/swift-server/async-http-client",
            from: "1.17.0"
        ),
    ],
    targets: [
        .target(name: "SwiftHttp", dependencies: [
            .product(name: "Logging", package: "swift-log"),
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
        ]),
        .target(name: "SwiftHttpFoundation", dependencies: [
            .target(name: "SwiftHttp")
        ]),
        .testTarget(
            name: "SwiftHttpTests",
            dependencies: ["SwiftHttp"]
        ),
        .testTarget(
            name: "SwiftHttpFoundationTests",
            dependencies: ["SwiftHttpFoundation"]
        ),
    ]
)
