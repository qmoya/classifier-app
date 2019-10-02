import MediaLibrary
import Photos
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public class SystemMediaLibrary: MediaLibrary {
	public var isAuthorized: Bool {
		switch PHPhotoLibrary.authorizationStatus() {
		case .authorized:
			return true
		default:
			return false
		}
	}

	let imageManager: PHImageManager

	public func requestData(forImageWithLocalIdentifier id: String, completion: @escaping (Data) -> Void) {
		let assets = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
		let asset = assets.object(at: 0)
		imageManager.requestImage(for: asset, targetSize: CGSize(width: 1200, height: 1200), contentMode: .aspectFill, options: nil) { image, _ in
			guard let img = image, let data = img.pngData() else { return }
			completion(data)
		}
	}

	public func fetchAssets() -> [Asset] {
		let results = PHAsset.fetchAssets(with: .image, options: nil)
		var assets = [Asset]()
		for i in 0 ..< results.count {
			assets.append(results.object(at: i))
		}
		return assets
	}

	public init(imageManager: PHImageManager = .default()) {
		self.imageManager = imageManager
	}

	public func requestAccess(completion: @escaping (Bool) -> Void) {
		PHPhotoLibrary.requestAuthorization { status in
			switch status {
			case .authorized:
				completion(true)
			default:
				completion(false)
			}
		}
	}
}

extension PHAsset: Asset {
	public var date: Date {
		return creationDate ?? Date()
	}
}
