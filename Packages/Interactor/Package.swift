import PackageDescription

let package = Package(
	name: "Interactor",
	platforms: [.iOS(.v13)],
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "Interactor",
			targets: ["Interactor"]
		)
	],
	dependencies: [
		.package(path: "../MediaLibrary"),
		.package(path: "../ImageClassifier"),
		.package(path: "../Storage"),
		.package(path: "../ZylMaker")
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages which this package depends on.
		.target(
			name: "Interactor",
			dependencies: [
				"MediaLibrary",
				"ImageClassifier",
				"Storage",
				"ZylMaker"
			]
		)
	]
)
