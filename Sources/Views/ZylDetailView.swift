import SwiftUI

struct HeroView: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

	var hero: Hero

	var body: some View {
        Image(uiImage: hero.uiImage)
            .resizable()
            .scaledToFill()
            .navigationBarTitle(PhotoDetailView.dateFormatter.string(from: hero.date))
	}
}
