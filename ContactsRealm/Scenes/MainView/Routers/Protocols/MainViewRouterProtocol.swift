import Foundation

protocol MainViewRouterProtocol {
    
    var dataStore: MainViewDataStoreProtocol { get }
    
    func openAddEditContactView()
    func openDetailView(for rowIndex: Int)
    
}
