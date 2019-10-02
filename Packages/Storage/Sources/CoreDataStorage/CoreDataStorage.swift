import CoreData
import Foundation
import Storage

public class CoreDataStorage: Storage {
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }

	public func createPhoto(forZylWithUUID uuid: UUID) {}

	public init() {}

	public func fetchRandomAssetGroup() -> StoredAssetGroup? {
		let req = AssetGroup.randomRecordRequest
		do {
			let results = try viewContext.fetch(req)
			if let result = results.first {
				return result
			}
			return nil
		} catch {
			return nil
		}
	}

	public func createAssetGroup(date: Date) -> StoredAssetGroup {
		let group = AssetGroup(context: viewContext)
		group.date = date
		return group
	}

	public func createPhoto(date: Date, data: Data, zyl: StoredZyl) -> StoredPhoto {
		guard let zyl = zyl as? Zyl else { return Photo() }
		let photo = Photo(context: viewContext)
		zyl.addToPhotos(photo)
		return photo
	}

	public func createZyl(date: Date) -> StoredZyl {
		let zyl = Zyl(context: viewContext)
		zyl.uuid = UUID()
		zyl.date = date
		return zyl
	}

	public func save() {
		viewContext.perform {
			try? self.viewContext.save()
		}
	}

	public func createAsset(forAssetGroup assetGroup: StoredAssetGroup, localIdentifier: String) -> StoredAsset {
		guard let group = assetGroup as? AssetGroup else { return Asset() }
		let asset = Asset(context: viewContext)
		asset.localIdentifier = localIdentifier
		group.addToAssets(asset)
		return asset
	}

	lazy var persistentContainer: PersistentContainer = {
		let container = PersistentContainer(name: "Zyl")
		container.loadPersistentStores(completionHandler: { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	internal func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
