import Foundation

enum DetailViewModels {
    
    enum ShowContact {
        
        struct Response {
            public var contact: ContactProtocol
        }
        
        struct ViewModel {
            public var name: String?
            public var lastName: String?
            public var birthday: String?
            public var photo: Data?
            public var phoneNumber: String?
            public var email: String?
            public var appartment: String?
            public var homeCityAddress: String?
            public var homeStreetAddress: String?
            public var companyName: String?
            public var workingPhoneNumber: String?
            public var workPosition: String?
            public var workingCityAddress: String?
            public var workingStreetAddress: String?
        }
        
    }
    
}
