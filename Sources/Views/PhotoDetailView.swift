import SwiftUI

struct PhotoDetailView: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

	var photo: Photo

	var body: some View {
        Image(uiImage: photo.uiImage)
            .resizable()
            .scaledToFill()
            .navigationBarTitle(PhotoDetailView.dateFormatter.string(from: photo.date))
	}
}
