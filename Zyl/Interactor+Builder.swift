import CoreDataStorage
import CoreMLClassifier
import Foundation
import GIFZylMaker
import Interactor
import SystemMediaLibrary

extension Interactor {
	static func build() -> Interactor {
		let zylMaker = GIFZylMaker()
		let storage = CoreDataStorage()
		let classifier = CoreMLClassifier()
		let mediaLibrary = SystemMediaLibrary()
		return Interactor(zylMaker: zylMaker, storage: storage, imageClassifier: classifier, mediaLibrary: mediaLibrary)
	}
}
