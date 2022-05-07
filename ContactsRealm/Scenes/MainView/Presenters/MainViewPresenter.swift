import Foundation

final class MainViewPresenter {
    
    private weak var view: MainViewProtocol?
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
}

extension MainViewPresenter: MainViewPresenterProtocol {
    
    public func presentFetchedData(response: MainViewModels.FetchData.Response) {
        
        var contacts = MainViewModels.FetchData.ViewModel().contacts
        
        for item in response.contacts {
            let contact = fillContact(contact: item)
            
            contacts.append(contact)
        }

        view?.showFetchedData(viewModel: .init(contacts: contacts))
        
    }
    
    private func fillContact(contact: ContactProtocol) -> MainViewModels.FetchData.ViewModel.ContactRow {
        return .init(name: contact.name, lastName: contact.lastName, photo: contact.photo)
    }
    
    public func deleteRow(response: MainViewModels.DeleteData.Response) {
        view?.deleteRow(viewModel: .init(indexOfDeletedElement: response.indexOfDeletedElement))
    }
    
    public func showError(response: MainViewModels.ShowError.Response) {
        view?.showAlert(viewModel: .init(errorMessage: response.errorMessage))
    }
    
}
