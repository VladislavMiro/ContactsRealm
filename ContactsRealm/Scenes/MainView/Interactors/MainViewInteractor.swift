import Foundation

final class MainViewInteractor: MainViewDataStoreProtocol {
    
    private var presenter: MainViewPresenterProtocol
    private var storageManagerWorker: MainViewSMWorkerProtocol
    
    public var contacts = [ContactProtocol]()
    
    init(presenter: MainViewPresenterProtocol, storageManagerWorker: MainViewSMWorkerProtocol) {
        self.presenter = presenter
        self.storageManagerWorker = storageManagerWorker
    }
    
}

extension MainViewInteractor: MainViewInteractorProtocol {
    
    public func fetchAllData() {
        let contacts = storageManagerWorker.fetchAllData()
        self.contacts = contacts
        presenter.presentFetchedData(response: .init(contacts: contacts))
    }
    
    public func fetchData(request: MainViewModels.FetchData.Request) {
        let contacts = storageManagerWorker.fetchData(request: request.predicate)
        self.contacts = contacts
        presenter.presentFetchedData(response: .init(contacts: contacts))
    }
    
    public func deleteData(request: MainViewModels.DeleteData.Request) {
        
        let contact = contacts[request.index.row]
        
        if storageManagerWorker.deleteData(contact: contact) {
            presenter.deleteRow(response: .init(indexOfDeletedElement: request.index))
        } else {
            let message = NSLocalizedString("Alert_Message_MainView_deleteError", comment: "")
            
            presenter.showError(response: .init(errorMessage: message))
        }
        
    }
    
}
