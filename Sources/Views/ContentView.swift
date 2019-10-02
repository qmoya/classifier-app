import CoreData
import SwiftUI

struct ContentView: View {
	@EnvironmentObject var userData: UserData
	var zyls: [Zyl] = []
	@Environment(\.managedObjectContext) var managedObjectContext

	var createZylButton: Button<Text> {
		if userData.canCreateZyl {
			return Button(action: userData.createZyl) {
				Text("🎁")
			}
		}
		return Button(action: {}) {
			Text("Time left")
		}
	}

	var showSettingsButton: Button<Image> {
		Button(action: userData.showSettings) {
			Image(systemName: "gear")
		}
	}

	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(userData.zyls) { zyl in
					ZylView(zyl: zyl)
				}
				.navigationBarTitle(userData.welcomeSentence)
				.navigationBarItems(leading: showSettingsButton, trailing: createZylButton)
			}
		}.sheet(isPresented: $userData.showsSettings, onDismiss: nil) {
			NavigationView {
				Form {
					Text("Settings go here")
				}.navigationBarTitle("Settings")
			}
		}
		.onAppear(perform: userData.launch)
		.alert(isPresented: $userData.showsClassificationActivity) {
			Alert(title: Text("Scanning your library"), message: Text("This may take some minutes."))
		}
	}
}
