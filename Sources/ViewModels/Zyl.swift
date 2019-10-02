import Foundation
import Interactor

class Zyl: ObservableObject, Identifiable {
	var hero: Hero?
	var photos: [Photo] = []
	var date: Date

	init(interactorZyl: InteractorZyl) {
		hero = Hero()
		date = interactorZyl.date
        photos = interactorZyl.photos.map { Photo(interactorPhoto: $0) }
	}
}
