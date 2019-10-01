import Foundation
import ImageClassifier

struct Image {
	let localIdentifier: String
	let date: Date
}

public class CoreMLClassifier: ImageClassifier {
	public var numberOfGroups: Int {
		return imagesByDate.keys.count
	}

	public func date(forGroupAt index: Int) -> Date? {
		let dates = Array(imagesByDate.keys)
		return dates[index]
	}

	public func numberOfPhotos(forGroupAt index: Int) -> Int {
		guard let date = self.date(forGroupAt: index), let images = imagesByDate[date] else { return 0 }
		return images.count
	}

	public func localIdentifier(forPhotoAt photoIndex: Int, inGroupAt groupIndex: Int) -> String? {
		guard let date = self.date(forGroupAt: groupIndex), let images = imagesByDate[date] else { return nil }
		return images[photoIndex].localIdentifier
	}

	var images = [Image]()

	public func reloadData() {
		guard let ds = dataSource else { return }
		for i in 0 ..< ds.numberOfImages(for: self) {
			let id = ds.imageClassifier(self, localIdentifierForImageAtIndex: i)
			let date = ds.imageClassifier(self, dateForImageAtIndex: i)
			let normalizedDate = self.normalizedDate(for: date)
			let image = Image(localIdentifier: id, date: normalizedDate)
			images.append(image)
		}
	}

	public weak var delegate: ImageClassifierDelegate?

	public weak var dataSource: ImageClassifierDataSource?

	private var imagesByDate = [Date: [Image]]()

	func normalizedDate(for date: Date) -> Date {
		let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
		return Calendar.current.date(from: components)!
	}

	public func classifyImages() {
		delegate?.imageClassifierWillBeginClassifyingImages(self)
		reloadData()
		imagesByDate = Dictionary(grouping: images) { $0.date }
		delegate?.imageClassifierDidEndClassifyingImages(self)
	}

	public init() {}
}
