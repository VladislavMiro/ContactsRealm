import Foundation

protocol DataFormatterProtocol {
    func formatDate(date: Date?) -> String?
    func formatDate(date: String?) -> Date?
    func formatPhoneNumber(with mask: String, phone: String) -> String
}
