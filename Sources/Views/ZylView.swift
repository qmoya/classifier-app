import SwiftUI

struct ZylView: View {
	let zyl: Zyl

	init(zyl: Zyl) {
		self.zyl = zyl
	}

	var body: some View {
		VStack(alignment: .leading) {
			Text("Cocentaina")
				.font(.headline)
				.padding(.leading, 15)
				.padding(.top, 5)

			NavigationLink(destination: HeroView(hero: zyl.hero!)) {
				Image("landscape")
					.renderingMode(.original)
					.resizable()
					.scaledToFill()
					.frame(height: 200)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.padding([.leading, .trailing], 15)
			}

			PhotosRow(photos: zyl.photos)
				.padding(.top, 8)
		}
	}
}
