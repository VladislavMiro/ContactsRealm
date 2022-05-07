import Foundation
import RealmSwift

final class ContactRealmModel: Object, ContactProtocol {
    
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var name = ""
    @Persisted public var lastName: String = ""
    @Persisted public var photo: Data? = nil
    @Persisted public var birthday: Date = Date()
    @Persisted public var phoneNumber: String = ""
    @Persisted public var email: String = ""
    @Persisted public var address: Address?
    @Persisted public var job: Job?
    
    override init() {
        super.init()
        address = Address()
        job = Job()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
