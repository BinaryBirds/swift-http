// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-http",
    platforms: [
			.macOS("10.15"),
			.iOS("13.0"),
			.tvOS("13.0"),
			.watchOS("6.0")
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
