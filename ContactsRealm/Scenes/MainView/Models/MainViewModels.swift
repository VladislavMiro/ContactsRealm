import Foundation

enum MainViewModels {
    
    enum FetchData {
        
        struct Request {
            public var predicate: String
        }
        
        struct Response {
            public var contacts: [ContactProtocol]
        }
        
        struct ViewModel {
            struct ContactRow {
                public var name: String
                public var lastName: String
                public var photo: Data?
            }
            
            public var contacts = [ContactRow]()
        }
        
    }
    
    enum DeleteData {
        
        struct Request {
            public var index: IndexPath
        }
        
        struct Response {
            public var indexOfDeletedElement: IndexPath
        }
        
        struct ViewModel {
            public var indexOfDeletedElement: IndexPath
        }
        
    }
    
    enum ShowError {
        
        struct Response {
            public var errorMessage: String
        }
        
        struct ViewModel {
            public var errorMessage: String
        }
        
    }
    
}
