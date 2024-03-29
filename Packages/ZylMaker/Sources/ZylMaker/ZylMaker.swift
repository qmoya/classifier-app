import Foundation

public protocol Proxy {
	var heroData: Data { get }
	var numberOfPhotos: Int { get }
	func data(forPhotoAt index: Int) -> Data
    func date(forPhotoAt index: Int) -> Date
    var date: Date { get }
}

public protocol ZylMakerDataSource: class {
	func numberOfImages(for zylMaker: ZylMaker) -> Int
    func date(for zylMaker: ZylMaker) -> Date
	func zylMaker(_ zylMaker: ZylMaker, dataForImageAt index: Int, completion: @escaping (Data) -> Void)
	func zylMaker(_ zylMaker: ZylMaker, dateForImageAt index: Int) -> Date
}

public protocol ZylMakerDelegate: class {
	func zylMakerWillCreateZyl(_ zylMaker: ZylMaker)
	func zylMaker(_ zylMaker: ZylMaker, didCreateZyl zyl: Proxy)
}

public protocol ZylMaker: class {
	var delegate: ZylMakerDelegate? { get set }
	var dataSource: ZylMakerDataSource? { get set }

	func makeZyl()
}
