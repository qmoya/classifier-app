import Foundation
import ZylMaker

public class SimpleZylMaker: ZylMaker {
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

        let date = ds.date(for: self)
        let proxy = SimpleProxy(date: date, images: images)
		del.zylMaker(self, didCreateZyl: proxy)
	}

	public init() {}
}
