import Foundation

protocol AddEditSMWorkerProtocol {
    func appendData(values: [String : Any?]) -> Bool
    func changeData(newValues: [String : Any?], for contact: ContactProtocol) -> Bool
}
