// swift-tools-version:5.7
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
        .library(name: "SwiftHttpFoundation", targets: ["SwiftHttpFoundation"]),
        .library(name: "SwiftHttpAsyncClient", targets: ["SwiftHttpAsyncClient"]),
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
        .target(name: "SwiftHttpAsyncClient", dependencies: [
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
