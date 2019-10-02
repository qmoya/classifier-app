import Foundation
import SwiftUI

struct PhotoItem: View {
	var photo: Photo

    func uiImage(for photo: Photo) -> UIImage {
        guard let data = photo.data, let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
    
	var body: some View {
		NavigationLink(destination: PhotoDetailView(photo: photo)) {
			VStack(alignment: .leading) {
                Image(uiImage: uiImage(for: photo))
					.renderingMode(.original)
					.resizable()
					.scaledToFill()
					.frame(width: 100, height: 100)
					.cornerRadius(10)
			}
		}
	}
}
