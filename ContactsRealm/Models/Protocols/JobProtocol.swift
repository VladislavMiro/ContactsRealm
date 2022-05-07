import Foundation
import RealmSwift

protocol JobProtocol: Object {
    var id: ObjectId { get }
    var companyName: String { get set }
    var phoneNumber: String { get set }
    var position: String { get set }
    var address: Address? { get }
}
