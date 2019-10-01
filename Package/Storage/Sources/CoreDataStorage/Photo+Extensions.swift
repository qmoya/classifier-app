import Storage
import SwiftUI

extension Photo: Identifiable, StoredPhoto {
	static func all(for zyl: Zyl) -> FetchRequest<Photo> {
		let entity = Photo.entity()
		let predicate = NSPredicate(format: "self.zyl == %@", zyl)
		let sortDescriptors = [NSSortDescriptor(keyPath: \Photo.date, ascending: false)]
		let req: FetchRequest<Photo> = FetchRequest(
			entity: entity,
			sortDescriptors: sortDescriptors,
			predicate: predicate
		)
		return req
	}
}
