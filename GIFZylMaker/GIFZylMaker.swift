import Foundation
import ZylMaker

struct Image {
	let data: Data
	let date: Date
}

struct GIFProxy: Proxy {
	let images: [Image]

	var heroData: Data {
		return images[0].data
	}

	var numberOfPhotos: Int {
		return images.count
	}

	func data(forPhotoAt index: Int) -> Data {
		return images[index].data
	}
}

public class GIFZylMaker: ZylMaker {
	public var dataSource: ZylMakerDataSource?

	public weak var delegate: ZylMakerDelegate?

	public func makeZyl() {
		guard let del = delegate, let ds = dataSource else { return }
		del.zylMakerWillCreateZyl(self)
		guard ds.numberOfImages(for: self) > 0 else { return }

		var images = [Image]()
		for i in 0 ..< ds.numberOfImages(for: self) {
			let date = ds.zylMaker(self, dateForImageAt: i)
			ds.zylMaker(self, dataForImageAt: i) { data in
				let image = Image(data: data, date: date)
				images.append(image)
			}
		}

		let proxy = GIFProxy(images: images)
		del.zylMaker(self, didCreateZyl: proxy)
	}

	public init() {}
}
