import CoreData
import Foundation
import Storage

extension Zyl: Identifiable, StoredZyl {
	public var storedPhotos: [StoredPhoto] {
		guard let photos = self.photos, let array = photos.allObjects as? [Photo] else { return [] }
		return array.map { $0 as StoredPhoto }
	}

	static var all: NSFetchRequest<Zyl> {
		let req: NSFetchRequest<Zyl> = Zyl.fetchRequest()
		req.sortDescriptors = [NSSortDescriptor(keyPath: \Zyl.date, ascending: false)]
		return req
	}
}
