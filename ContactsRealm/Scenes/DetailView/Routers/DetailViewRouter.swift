import Foundation
import UIKit

final class DetailViewRouter {
   
    public var dataStore: DetailViewDataStoreProtocol
    
    private weak var view: DetailView?
    
    init(view: DetailView, dataStore: DetailViewDataStoreProtocol) {
        self.view = view
        self.dataStore = dataStore
    }
    
}

extension DetailViewRouter: DetailViewRouterProtocol {
    
    public func openEditView() {
        let title = NSLocalizedString("New_Contact_title", comment: "")
        let storyboard = UIStoryboard(name: "AddEditView", bundle: nil)
        guard let view = storyboard.instantiateViewController(identifier: "AddEditView") as? AddEditView else { return }
        
        view.router.dataStore.isEditMode = true
        view.router.dataStore.contact = dataStore.contact
        
        view.navigationItem.title = title
        
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
}
