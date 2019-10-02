import Foundation

public struct InteractorZyl {
	public let date: Date
	public let hero: Data
	public let photos: [InteractorPhoto]

	init(storedZyl: StoredZyl) {
		date = storedZyl.date ?? Date.distantPast
		hero = Data()
		photos = storedZyl.storedPhotos.map { InteractorPhoto(data: $0.data ?? Data()) }
	}
}
