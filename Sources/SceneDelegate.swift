import Combine
import Interactor
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var showsPhotoSinkCancellable: Cancellable?
	var photosAuthorizationViewController: UIViewController?

	func setPhotosAuthorizationViewControllerHidden(_ hidden: Bool) {
		guard let vc = photosAuthorizationViewController else { return }
		vc.modalPresentationStyle = .fullScreen
		if !hidden {
			window?.rootViewController?.present(vc, animated: true)
			return
		}
		vc.dismiss(animated: true)
	}

	func observePhotosAuthorization(in userData: UserData) {
		showsPhotoSinkCancellable = userData.$showsPhotoLibraryPermission.sink { [weak self] shows in
			self?.setPhotosAuthorizationViewControllerHidden(!shows)
		}
	}

	fileprivate func setRootViewController(_ rootViewController: UIViewController, for scene: UIScene) {
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController = rootViewController
			self.window = window
			window.makeKeyAndVisible()
		}
	}

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		let interactor: Interactor = .build()
		let userData = UserData(interactor: interactor)
		interactor.delegate = userData

		let contentView = ContentView().environmentObject(userData)
		photosAuthorizationViewController = UIHostingController(rootView: PhotosAuthorization().environmentObject(userData))
		let vc = UIHostingController(rootView: contentView)
		setRootViewController(vc, for: scene)

		observePhotosAuthorization(in: userData)
	}
}
