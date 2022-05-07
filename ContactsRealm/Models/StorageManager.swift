import Foundation
import RealmSwift

final class StorageManager: StorageManagerProtocol {
    
    private var configuration: Realm.Configuration?
    
    public lazy var realm: Realm = {
        let realm = self.configuration == nil ?
            try! Realm(configuration: .defaultConfiguration) :
            try! Realm(configuration: configuration!)
        return realm
    }()
    
    public func setConfiguration(fileURL: URL?, inMemoryIdentifire: String?, syncConfiguration: SyncConfiguration?, encryptionKey: Data?,
                                 readOnly: Bool, schemaVersion: UInt64, migrationBlock: MigrationBlock?, deleteRealmIfMigrationNeeded: Bool,
                                 shouldCompactOnLaunch: ((Int, Int) -> Bool)?, objectTypes: [ObjectBase.Type]?) {
        
        self.configuration = Realm.Configuration(fileURL: fileURL,
                                                 inMemoryIdentifier: inMemoryIdentifire,
                                                 syncConfiguration: syncConfiguration,
                                                 encryptionKey: encryptionKey,
                                                 readOnly: readOnly,
                                                 schemaVersion: schemaVersion,
                                                 migrationBlock: migrationBlock,
                                                 deleteRealmIfMigrationNeeded: deleteRealmIfMigrationNeeded,
                                                 shouldCompactOnLaunch: shouldCompactOnLaunch,
                                                 objectTypes: objectTypes)
        
    }
    
    public func appendObject(object: Object) -> Bool {
        do {
            let realm = self.realm
            
            try realm.write {
                realm.add(object)
            }

            return true
            
            } catch let error as NSError  {
                print(error)
                
                return false
            }
    }
    
    public func updateObject<T: Object>(object: T, newValues: [String:Any?]) -> Bool {
       
        do {
            let realm = self.realm
            try realm.write {
                for element in newValues {
                    object.setValue(element.value, forKeyPath: element.key)
                }
            }
            
            return true
        } catch {
            return false
        }
        
    }
    
    public func fetchObject<T: Object>(type: T.Type, with id: ObjectId) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    public func fetchObjects<T: Object>(type: T.Type, withPredicate predicate: NSPredicate?) -> Results<T> {
        return predicate == nil ? realm.objects(type) : realm.objects(type).filter(predicate!)
    }
    
    public func deleteObject<T: Object>(object: T) -> Bool {
        let objects = cascadeDeleteObject(object: object)
        
        do {
            let realm = self.realm
            
            try realm.write {
                objects.forEach { object in
                    self.realm.delete(object)
                }
            }
             
            return true
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    public func cascadeDeleteObject<T: Object>(object: T) -> [Object] {
        var dataForDeleting = [Object]()
        var tmpArray = getObjectsForDeleting(object: object)
        
        dataForDeleting.append(object)
        
        while !tmpArray.isEmpty {
            let element = tmpArray.removeFirst()
            
            dataForDeleting.append(element)
            
            let objects = getObjectsForDeleting(object: element)
            
            if !objects.isEmpty {
                tmpArray.append(contentsOf: objects)
            }
        }
        
        return dataForDeleting
    }
    
    private func getObjectsForDeleting(object: Object) -> [Object] {
        var objects = [Object]()
        let properties = object.objectSchema.properties
        
        properties.forEach { (property) in
            if let data = object.value(forKey: property.name) as? Object {
                objects.append(data)
            }
        }
        
        return objects
    }

    
    public func deleteAllObjects() {
        do {
            let realm = self.realm
            
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print(error)
        }
    }

}
