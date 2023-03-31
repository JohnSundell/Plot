// swift-tools-version:5.4

/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "Plot",
    products: [
        .library(
            name: "Plot",
            targets: ["Plot"]
        )
    ],
    targets: [
        .target(name: "Plot"),
        .testTarget(
            name: "PlotTests",
            dependencies: ["Plot"]
        )
    ]
)
