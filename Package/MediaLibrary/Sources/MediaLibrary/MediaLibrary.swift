import Foundation

public protocol Asset {
	var date: Date { get }
	var localIdentifier: String { get }
}

public protocol MediaLibrary {
	var isAuthorized: Bool { get }
	func requestAccess(completion: @escaping (Bool) -> Void)
	func fetchAssets() -> [Asset]
	func requestData(forImageWithLocalIdentifier id: String, completion: @escaping (Data) -> Void)
}
