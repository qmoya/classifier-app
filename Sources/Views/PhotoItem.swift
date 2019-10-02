import Foundation
import SwiftUI

struct PhotoItem: View {
	var photo: Photo

	var body: some View {
		NavigationLink(destination: PhotoDetailView(photo: photo)) {
			VStack(alignment: .leading) {
                Image(uiImage: photo.uiImage)
					.renderingMode(.original)
					.resizable()
					.scaledToFill()
					.frame(width: 100, height: 100)
					.cornerRadius(10)
			}
		}
	}
}
