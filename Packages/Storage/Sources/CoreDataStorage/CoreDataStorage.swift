import CoreData
import Foundation
import Storage

public class CoreDataStorage: Storage {
	public func fetchZyls() -> [StoredZyl] {
		let req = Zyl.defaultFetchRequest
		do {
			let results = try viewContext.fetch(req)
			return results
		} catch {
			return []
		}
	}

	var viewContext: NSManagedObjectContext { persistentContainer.viewContext }

	public func createPhoto(forZylWithUUID uuid: UUID) {}

	public init() {}

	public func fetchRandomAssetGroup() -> StoredAssetGroup? {
		let req = AssetGroup.defaultFetchRequest
		do {
			let results = try viewContext.fetch(req)
			if let result = results.randomElement() {
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
		photo.data = data
		photo.date = date
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
			self.saveContext()
		}
	}

    public func createAsset(forAssetGroup assetGroup: StoredAssetGroup, localIdentifier: String, date: Date) -> StoredAsset {
		guard let group = assetGroup as? AssetGroup else { return Asset() }
		let asset = Asset(context: viewContext)
		asset.localIdentifier = localIdentifier
        asset.date = date
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
