import Foundation
import RealmSwift

protocol ContactProtocol: Object {
    var id: ObjectId { get }
    var name: String { get set }
    var lastName: String { get set }
    var photo: Data? { get set }
    var birthday: Date { get set }
    var phoneNumber: String { get set }
    var email: String { get set }
    var address: Address? { get }
    var job: Job? { get }
}
