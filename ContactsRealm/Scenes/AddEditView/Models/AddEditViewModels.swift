import Foundation

enum AddEditViewModels {
    
    enum SaveData {
        
        struct Request {
            public var name: String?
            public var lastName: String?
            public var birthday: Date?
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
    
    enum ShowData {
        
        struct Response {
            var data: ContactProtocol
        }
        
        struct ViewModel {
            public var name: String
            public var lastName: String
            public var birthday: String
            public var photo: Data?
            public var phoneNumber: String
            public var email: String
            public var appartment: String
            public var homeCityAddress: String
            public var homeStreetAddress: String
            public var companyName: String
            public var workingPhoneNumber: String
            public var workPosition: String
            public var workingCityAddress: String
            public var workingStreetAddress: String
        }
        
    }
            
    enum ShowError {
        
        struct Response {
            var messageOfError: String
        }
        
        struct ViewModel {
            var messageOfError: String
        }
        
    }
    
    enum ShowEmptyFields {
        
        struct Response {
            var errorMessage: String
        }
        
        struct ViewModel {
            var errorMessage: String
        }
        
    }
    
    enum ConvertDate {
        
        struct Request {
            var date: Date
        }
        
        struct Response {
            var date: Date
        }
        
        struct ViewModel {
            var date: String
        }
        
    }
    
    enum ConvertPhoneNumber {
        
        struct Request {
            public var tagOfTextField: Int
            public var phoneNumber: String
        }
        
        struct Response {
            public var tagOfTextField: Int
            public var phoneNumber: String
        }
        
        struct ViewModel {
            public var tagOfTextField: Int
            public var phoneNumber: String
        }
        
    }
    
}
