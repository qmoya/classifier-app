import SwiftUI

struct PhotosAuthorization: View {
	@EnvironmentObject var userData: UserData

	var body: some View {
		VStack {
			Text("Zyl needs access to your photo library in order to proceed").padding().multilineTextAlignment(.center)
			Button(action: userData.grantAccessToPhotoLibrary) {
				Text("Grant access")
			}
		}
	}
}
