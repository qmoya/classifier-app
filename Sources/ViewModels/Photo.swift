import Foundation
import UIKit
import Interactor

class Photo: ObservableObject, Identifiable {
    static func uiImage(for photo: Photo) -> UIImage {
        guard let image = UIImage(data: photo.data) else {
            return UIImage()
        }
        return image
    }

    var data: Data
    var date: Date
    var uiImage: UIImage { Photo.uiImage(for: self) }
    
    init(interactorPhoto: InteractorPhoto) {
        data = interactorPhoto.data
        date = interactorPhoto.date
    }
}
