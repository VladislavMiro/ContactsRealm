import Foundation
import RealmSwift

protocol AddressProtocol: Object {
    var id: ObjectId { get }
    var city: String { get set }
    var street: String { get set }
    var appartment: String { get set }
    
}
