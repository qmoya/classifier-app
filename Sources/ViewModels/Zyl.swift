import Foundation
import Interactor

class Zyl: ObservableObject, Identifiable {
	var hero: Hero?
	var photos: [Photo] = []
    
    init(interactorZyl: InteractorZyl) {
        hero = Hero()
        for interactorPhoto in interactorZyl.photos {
            let photo = Photo()
            photo.data = interactorPhoto.data
            photos.append(photo)
        }
    }
}

