import Foundation
import Storage

public struct InteractorPhoto {
	public let data: Data
    public let date: Date
    
    init(storedPhoto: StoredPhoto) {
        date = storedPhoto.date ?? Date()
        data = storedPhoto.data ?? Data()
    }
}
