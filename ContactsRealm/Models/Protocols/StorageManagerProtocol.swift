import Foundation
import RealmSwift

protocol StorageManagerProtocol {
    var realm: Realm { get }
    
    func setConfiguration(fileURL: URL?, inMemoryIdentifire: String?, syncConfiguration: SyncConfiguration?, encryptionKey: Data?,
                          readOnly: Bool, schemaVersion: UInt64, migrationBlock: MigrationBlock?, deleteRealmIfMigrationNeeded: Bool,
                          shouldCompactOnLaunch: ((Int, Int) -> Bool)?, objectTypes: [ObjectBase.Type]?)
    func appendObject(object: Object) -> Bool
    func updateObject<T: Object>(object: T, newValues: [String:Any?]) -> Bool
    func fetchObject<T: Object>(type: T.Type, with id: ObjectId) -> T?
    func fetchObjects<T: Object>(type: T.Type, withPredicate predicate: NSPredicate?) -> Results<T>
    func deleteObject<T: Object>(object: T) -> Bool
    func deleteAllObjects()
    
}
