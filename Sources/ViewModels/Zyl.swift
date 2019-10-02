import Foundation
import Interactor

class Zyl: ObservableObject, Identifiable {
	var hero: Hero?
	var photos: [Photo] = []
	var date: Date

	init(interactorZyl: InteractorZyl) {
		hero = Hero()
		date = interactorZyl.date
		for interactorPhoto in interactorZyl.photos {
			let photo = Photo()
			photo.data = interactorPhoto.data
			photos.append(photo)
		}
	}
}
