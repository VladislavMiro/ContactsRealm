import Foundation
import RealmSwift

final class MainViewSMWorker {
    
    private var storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
    
}

extension MainViewSMWorker: MainViewSMWorkerProtocol {
    
    public func fetchAllData() -> [ContactProtocol]  {
        let contacts = storageManager.fetchObjects(type: ContactRealmModel.self, withPredicate: nil)
        return Array(contacts)
    }
    
    public func fetchData(request: String) -> [ContactProtocol]  {
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", request)
        let contacts = storageManager.fetchObjects(type: ContactRealmModel.self, withPredicate: predicate)
        return Array(contacts)
    }
    
    public func deleteData(contact: ContactProtocol) -> Bool {
        return storageManager.deleteObject(object: contact)
    }
    
}
