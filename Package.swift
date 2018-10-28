// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Authorized",
    products: [
        .library(
            name: "Authorized",
            targets: ["Authorized"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Authorized",
            dependencies: [
                "Vapor",
                "Authentication",
        ]),
        .testTarget(
            name: "AuthorizedTests",
            dependencies: [
                "Authorized",
                "Vapor",
                "Authentication",
            ]),
    ]
)
