import Foundation
import ZylMaker

internal struct SimpleProxy: Proxy {
    var date: Date
    
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
