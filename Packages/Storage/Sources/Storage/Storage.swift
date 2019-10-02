import CoreData
import Foundation

public protocol StoredZyl {
	var uuid: UUID? { get set }
	var date: Date? { get set }
	var storedPhotos: [StoredPhoto] { get }
}

public protocol StoredPhoto {
	var data: Data? { get set }
	var date: Date? { get set }
}

public protocol StoredAssetGroup {
	var storedAssets: [StoredAsset] { get }
}

public protocol StoredAsset {
    var localIdentifier: String? { get set }
	var date: Date? { get set }
}

public protocol Storage: class {
	func save()

    func fetchZyls() -> [StoredZyl]
	func fetchRandomAssetGroup() -> StoredAssetGroup?
	func createZyl(date: Date) -> StoredZyl
	func createPhoto(date: Date, data: Data, zyl: StoredZyl) -> StoredPhoto
	func createAssetGroup(date: Date) -> StoredAssetGroup
	func createAsset(forAssetGroup assetGroup: StoredAssetGroup, localIdentifier: String) -> StoredAsset
}
