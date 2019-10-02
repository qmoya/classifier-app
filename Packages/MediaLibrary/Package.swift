// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "MediaLibrary",
	platforms: [.iOS(.v13)],
	products: [
		.library(
			name: "MediaLibrary",
			targets: ["MediaLibrary"]
		),
		.library(
			name: "SystemMediaLibrary",
			targets: ["SystemMediaLibrary"]
		)
	],
	targets: [
		.target(
			name: "MediaLibrary",
			dependencies: []
		),
		.target(
			name: "SystemMediaLibrary",
			dependencies: ["MediaLibrary"]
		)
	]
)
