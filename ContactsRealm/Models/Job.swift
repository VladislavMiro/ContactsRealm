import Foundation
import RealmSwift

final class Job: Object, JobProtocol {
    
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var companyName: String = ""
    @Persisted public var phoneNumber: String = ""
    @Persisted public var position: String = ""
    @Persisted public var address: Address?
    
    override init() {
        super.init()
        self.address = Address()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
