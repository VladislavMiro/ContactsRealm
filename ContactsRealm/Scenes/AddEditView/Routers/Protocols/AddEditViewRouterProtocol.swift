import Foundation

protocol AddEditViewRouterProtocol {
    
    var dataStore: AddEditDataStoreProtocol { get set }
    
    func popViewController()
    func popToRootViewController()
    
}
