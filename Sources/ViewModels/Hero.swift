import Foundation
import UIKit

class Hero: ObservableObject {
    static func uiImage(for hero: Hero) -> UIImage {
        guard let image = UIImage(data: hero.data) else {
            return UIImage()
        }
        return image
    }
    
    init(data: Data, date: Date) {
        self.data = data
        self.date = date
    }
    
    var uiImage: UIImage { Hero.uiImage(for: self) }
    var data: Data
    var date: Date
}
