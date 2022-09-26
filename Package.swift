// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsFontAwesome",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "RefdsFontAwesome",
            targets: ["RefdsFontAwesome"])
    ],
    targets: [
        .target(
            name: "RefdsFontAwesome",
            resources: [
                .copy("Resource/Font-Awesome-6-Brands-Regular-400.otf"),
                .copy("Resource/Font-Awesome-6-Pro-Duotone-Solid-900.otf"),
                .copy("Resource/Font-Awesome-6-Pro-Light-300.otf"),
                .copy("Resource/Font-Awesome-6-Pro-Regular-400.otf"),
                .copy("Resource/Font-Awesome-6-Pro-Solid-900.otf"),
                .copy("Resource/Font-Awesome-6-Pro-Thin-100.otf"),
                .copy("Resource/icons.json")
            ]),
        .testTarget(
            name: "FontAwesomeTests",
            dependencies: ["RefdsFontAwesome"])
    ]
)
