// swift-tools-version:5.2
import PackageDescription

let packageName = "MonteWatchlist"  // <-- Change this to yours

let package = Package(
    name: packageName,
    products: [
        .library(name: packageName, targets: [packageName])
    ],
    targets: [
        .target(name: packageName, path: packageName)
    ]
)
