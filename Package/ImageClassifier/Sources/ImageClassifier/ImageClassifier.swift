import Foundation

public protocol ImageClassifierDelegate: class {
	func imageClassifierWillBeginClassifyingImages(_ imageClassifier: ImageClassifier)
	func imageClassifierDidEndClassifyingImages(_ imageClassifier: ImageClassifier)
}

public protocol ImageClassifierDataSource: class {
	func numberOfImages(for imageClassifier: ImageClassifier) -> Int
	func imageClassifier(_ imageClassifier: ImageClassifier, dateForImageAtIndex index: Int) -> Date
	func imageClassifier(_ imageClassifier: ImageClassifier, localIdentifierForImageAtIndex: Int) -> String
	func imageClassifier(_ imageClassifier: ImageClassifier, requestDataForImageAtIndex index: Int, completion: @escaping (Data) -> Void)
}

public protocol ImageClassifier: class {
	var delegate: ImageClassifierDelegate? { get set }
	var dataSource: ImageClassifierDataSource? { get set }

	var numberOfGroups: Int { get }
	func date(forGroupAt index: Int) -> Date?
	func numberOfPhotos(forGroupAt index: Int) -> Int
	func localIdentifier(forPhotoAt photoIndex: Int, inGroupAt groupIndex: Int) -> String?

	func reloadData()

	func classifyImages()
}
