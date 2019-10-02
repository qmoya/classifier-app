import CoreDataStorage
import DateImageClassifier
import Foundation
import SimpleZylMaker
import Interactor
import SystemMediaLibrary

extension Interactor {
	static func build() -> Interactor {
		let zylMaker = SimpleZylMaker()
		let storage = CoreDataStorage()
		let classifier = DateClassifier()
		let mediaLibrary = SystemMediaLibrary()
		return Interactor(zylMaker: zylMaker, storage: storage, imageClassifier: classifier, mediaLibrary: mediaLibrary)
	}
}
