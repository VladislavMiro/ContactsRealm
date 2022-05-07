import Foundation
import RealmSwift

protocol MainViewSMWorkerProtocol {
    
    func fetchAllData() -> [ContactProtocol]
    func fetchData(request: String) -> [ContactProtocol]
    func deleteData(contact: ContactProtocol) -> Bool
    
}
