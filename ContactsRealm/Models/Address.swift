import Foundation
import RealmSwift

final class Address: Object, AddressProtocol {
    
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var city: String = ""
    @Persisted public var street: String = ""
    @Persisted public var appartment: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
