import Combine
import CoreData
import Foundation
import Interactor

final class UserData: ObservableObject {
	@Published var canCreateZyl = true
	@Published var showsSettings = false
	@Published var isCreateZylButtonEnabled = false
	@Published var showsClassificationActivity = false
	@Published var showsPhotoLibraryPermission = false
	@Published var showsCreatingZylActivityIndicator = false
	@Published var zyls: [Zyl] = []

	let interactor: Interactor

	init(interactor: Interactor) {
		self.interactor = interactor
	}

	func createZyl() {
		interactor.createZyl()
	}

	func showSettings() {
		showsSettings = true
	}

	func grantAccessToPhotoLibrary() {
		interactor.grantAccessToPhotoLibrary()
	}

	func launch() {
		interactor.launch()
	}
}

extension UserData: InteractorDelegate {
	func interactor(_ interactor: Interactor, didFetchZyls zyls: [InteractorZyl]) {
		self.zyls.append(contentsOf: zyls.map { Zyl(interactorZyl: $0) })
	}

	func interactor(_ interactor: Interactor, didCreateZyl interactorZyl: InteractorZyl) {
		let zyl = Zyl(interactorZyl: interactorZyl)
		zyls.insert(zyl, at: 0)
	}

	func interactorWillCreateZyl(_ interactor: Interactor) {
		showsCreatingZylActivityIndicator = true
	}

	func interactorPhotoLibraryAccessRequestDidFail(_ interactor: Interactor) {}

	func interactorDidBeginClassifying(_ interactor: Interactor) {
//		showsClassificationActivity = true
	}
}

extension UserData: UserInterface {
	func showAuthorizationScreen() {
		showsPhotoLibraryPermission = true
	}

	func hideAuthorizationScreen() {
		showsPhotoLibraryPermission = false
	}
}
