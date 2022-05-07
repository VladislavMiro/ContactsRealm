import Foundation
import RealmSwift

final class AddEditSMWorker {
    
    private var storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
    
}

extension AddEditSMWorker: AddEditSMWorkerProtocol {
    
    public func appendData(values: [String : Any?]) -> Bool {
        let newObject: ContactProtocol = ContactRealmModel()
        
        for value in values {
            newObject.setValue(value.value, forKeyPath: value.key)
        }
        
        return storageManager.appendObject(object: newObject)
    }
    
    
    public func changeData(newValues: [String : Any?], for contact: ContactProtocol) -> Bool {

        return storageManager.updateObject(object: contact, newValues: newValues)
    }
    
}
