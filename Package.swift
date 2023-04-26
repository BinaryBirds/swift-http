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
        .library(name: "SwiftHttpAsyncHTTPClient", targets: ["SwiftHttpAsyncHTTPClient"]),
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
        ]),
        .target(name: "SwiftHttpFoundation", dependencies: [
            .target(name: "SwiftHttp")
        ]),
        .target(name: "SwiftHttpAsyncHTTPClient", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .target(name: "SwiftHttp"),
        ]),

        .testTarget(
            name: "SwiftHttpTests",
            dependencies: [
                .target(name: "SwiftHttp"),
            ]
        ),
        .testTarget(
            name: "SwiftHttpFoundationTests",
            dependencies: [
                .target(name: "SwiftHttpFoundation"),
            ]
        ),
        .testTarget(
            name: "SwiftHttpAsyncHTTPClientTests",
            dependencies: [
                .target(name: "SwiftHttpAsyncHTTPClient"),
            ]
        ),
    ]
)
