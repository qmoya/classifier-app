import Foundation
import ImageClassifier
import MediaLibrary
import Storage
import UIKit
import ZylMaker

public protocol InteractorDelegate: class {
	func interactorDidBeginClassifying(_ interactor: Interactor)
	func interactorWillCreateZyl(_ interactor: Interactor)
	func interactor(_ interactor: Interactor, didCreateZyl zyl: InteractorZyl)
	func interactor(_ interactor: Interactor, didFetchZyls zyl: [InteractorZyl])
}

public protocol UserInterface {
	func showAuthorizationScreen()
	func hideAuthorizationScreen()
}

public class Interactor {
	let zylMaker: ZylMaker
	let storage: Storage
	let imageClassifier: ImageClassifier
	let mediaLibrary: MediaLibrary
	let dispatchQueue: DispatchQueue

	public weak var delegate: (InteractorDelegate & UserInterface)?

	var assets: [Asset] = []
	var lastAssetGroup: StoredAssetGroup?

	public init(zylMaker: ZylMaker, storage: Storage, imageClassifier: ImageClassifier, mediaLibrary: MediaLibrary, dispatchQueue: DispatchQueue = .main) {
		self.zylMaker = zylMaker
		self.storage = storage
		self.imageClassifier = imageClassifier
		self.mediaLibrary = mediaLibrary
		self.dispatchQueue = dispatchQueue

		zylMaker.delegate = self
		zylMaker.dataSource = self
		imageClassifier.delegate = self
		imageClassifier.dataSource = self
	}

	public func createZyl() {
		zylMaker.makeZyl()
	}

	func loadZyls() {
		let zyls = storage.fetchZyls().map { InteractorZyl(storedZyl: $0) }
		delegate?.interactor(self, didFetchZyls: zyls)
	}

	public func launch() {
		guard let d = delegate else { return }
		loadZyls()
		if !mediaLibrary.isAuthorized {
			perform { d.showAuthorizationScreen() }
		}
	}

	func perform(block: @escaping () -> Void) {
		dispatchQueue.async {
			block()
		}
	}

	public func grantAccessToPhotoLibrary() {
		mediaLibrary.requestAccess { [weak self] ok in
			guard let s = self else { return }
			if ok {
				s.assets = s.mediaLibrary.fetchAssets()
				s.imageClassifier.classifyImages()
				s.perform { s.delegate?.hideAuthorizationScreen() }
			}
		}
	}
}

extension Interactor: ImageClassifierDataSource {
	public func imageClassifier(_ imageClassifier: ImageClassifier, localIdentifierForImageAtIndex index: Int) -> String {
		return assets[index].localIdentifier
	}

	public func imageClassifier(_ imageClassifier: ImageClassifier, dateForImageAtIndex index: Int) -> Date {
		return assets[index].date
	}

	public func numberOfImages(for imageClassifier: ImageClassifier) -> Int {
		return assets.count
	}

	public func imageClassifier(_ imageClassifier: ImageClassifier, requestDataForImageAtIndex index: Int, completion: @escaping (Data) -> Void) {
		mediaLibrary.requestData(forImageWithLocalIdentifier: assets[index].localIdentifier) { data in
			completion(data)
		}
	}
}

extension Interactor: ImageClassifierDelegate {
	public func imageClassifierWillBeginClassifyingImages(_ imageClassifier: ImageClassifier) {
		perform { self.delegate?.interactorDidBeginClassifying(self) }
	}

	public func imageClassifier(_ imageClassifier: ImageClassifier, didDetectGroupForDate: Date) {}

	public func imageClassifier(_ imageClassifier: ImageClassifier, didClassifyImageWithLocalIdentifier: String, forDate date: Date) {}

	public func imageClassifierDidEndClassifyingImages(_ imageClassifier: ImageClassifier) {
		for i in 0 ..< imageClassifier.numberOfGroups {
			guard let date = imageClassifier.date(forGroupAt: i) else { continue }
			let group = storage.createAssetGroup(date: date)

			for j in 0 ..< imageClassifier.numberOfPhotos(forGroupAt: i) {
				guard let id = imageClassifier.localIdentifier(forPhotoAt: j, inGroupAt: i) else { continue }
                _ = storage.createAsset(forAssetGroup: group, localIdentifier: id, date: date)
			}
		}
		storage.save()
	}
}

extension Interactor: ZylMakerDelegate {
	public func zylMaker(_ zylMaker: ZylMaker, didCreateZyl zyl: Proxy) {
        let newZyl = storage.createZyl(date: zyl.date)

		for i in 0 ..< zyl.numberOfPhotos {
			let data = zyl.data(forPhotoAt: i)
            let date = zyl.date(forPhotoAt: i)
            _ = storage.createPhoto(date: date, data: data, zyl: newZyl)
		}
		storage.save()

		let interactorZyl = InteractorZyl(storedZyl: newZyl)
		delegate?.interactor(self, didCreateZyl: interactorZyl)
	}

	public func zylMakerWillCreateZyl(_ zylMaker: ZylMaker) {
		delegate?.interactorWillCreateZyl(self)
		lastAssetGroup = storage.fetchRandomAssetGroup()
	}
}

extension Interactor: ZylMakerDataSource {
    public func date(for zylMaker: ZylMaker) -> Date {
        guard let group = lastAssetGroup, let date = group.date else { return Date() }
        return date
    }
    
	public func zylMaker(_ zylMaker: ZylMaker, dataForImageAt index: Int, completion: @escaping (Data) -> Void) {
		guard let group = lastAssetGroup, let id = group.storedAssets[index].localIdentifier else { return }
		mediaLibrary.requestData(forImageWithLocalIdentifier: id) { data in
			completion(data)
		}
	}

	public func numberOfImages(for zylMaker: ZylMaker) -> Int {
		guard let group = lastAssetGroup else { return 0 }
		let assets = group.storedAssets
		return assets.count
	}

	public func zylMaker(_ zylMaker: ZylMaker, dateForImageAt index: Int) -> Date {
		guard let group = lastAssetGroup else { return Date() }
		let assets = group.storedAssets
		return assets[index].date ?? Date()
	}
}
