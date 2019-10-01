import SwiftUI

struct PhotosRow: View {
	var photos: [Photo]

	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(alignment: .top, spacing: 15) {
				ForEach(photos) { photo in
					PhotoItem(photo: photo)
				}
			}
			.padding(.horizontal, 15)
		}
	}
}
