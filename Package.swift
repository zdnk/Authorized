// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Authorization",
    products: [
        .library(
            name: "Authorization",
            targets: ["Authorization"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Authorization",
            dependencies: [
                "Vapor",
                "Authentication",
        ]),
        .testTarget(
            name: "AuthorizationTests",
            dependencies: [
                "Authorization",
                "Vapor",
                "Authentication",
            ]),
    ]
)
