import Foundation
import ZylMaker

internal struct GIFProxy: Proxy {
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
