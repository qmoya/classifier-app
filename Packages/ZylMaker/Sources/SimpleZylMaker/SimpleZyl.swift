import Foundation
import ZylMaker

internal struct SimpleProxy: Proxy {
    func date(forPhotoAt index: Int) -> Date {
        return images[index].date
    }
    
    var date: Date
    
	let images: [Image]

	var heroData: Data {
        return images.first?.data ?? Data()
	}

	var numberOfPhotos: Int {
		return images.count
	}

	func data(forPhotoAt index: Int) -> Data {
		return images[index].data
	}
}
