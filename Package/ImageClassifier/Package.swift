// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ImageClassifier",
    products: [
        .library(
            name: "ImageClassifier",
            targets: ["ImageClassifier"]),
        .library(
            name: "DateImageClassifier",
            targets: ["DateImageClassifier"]),
    ],
    targets: [
        .target(
            name: "ImageClassifier",
            dependencies: []),
        .target(
            name: "DateImageClassifier",
            dependencies: ["ImageClassifier"]),
    ]
)
