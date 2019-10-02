import CoreData
import Storage

extension AssetGroup: StoredAssetGroup {
	public var storedAssets: [StoredAsset] {
		guard let assets = self.assets, let array = assets.allObjects as? [Asset] else { return [] }
		return array.map { $0 as StoredAsset }
	}

	static var defaultFetchRequest: NSFetchRequest<AssetGroup> {
		let req: NSFetchRequest<AssetGroup> = AssetGroup.fetchRequest()
		req.sortDescriptors = [NSSortDescriptor(keyPath: \AssetGroup.date, ascending: true)]
		return req
	}
}
