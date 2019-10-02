import Foundation
import Interactor

class Zyl: ObservableObject, Identifiable {
	var hero: Hero?
	var photos: [Photo] = []
	var date: Date

	init(interactorZyl: InteractorZyl) {
        if let firstPhotoData = interactorZyl.photos.first?.data {
            hero = Hero(data: firstPhotoData, date: interactorZyl.date)
        }
		date = interactorZyl.date
        photos = interactorZyl.photos.map { Photo(interactorPhoto: $0) }
	}
}
