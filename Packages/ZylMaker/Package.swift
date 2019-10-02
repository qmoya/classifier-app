import PackageDescription

let package = Package(
	name: "ZylMaker",
	products: [
		.library(
			name: "ZylMaker",
			targets: ["ZylMaker"]
		),
		.library(
			name: "SimpleZylMaker",
			targets: ["SimpleZylMaker"]
		)
	],
	targets: [
		.target(
			name: "ZylMaker",
			dependencies: []
		),
		.target(
			name: "SimpleZylMaker",
			dependencies: ["ZylMaker"]
		)
	]
)
