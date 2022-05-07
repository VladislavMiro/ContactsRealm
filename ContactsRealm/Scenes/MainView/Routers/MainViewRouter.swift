import Foundation
import UIKit

final class MainViewRouter {
    
    public let dataStore: MainViewDataStoreProtocol
    
    private weak var view: MainView?
    
    init(view: MainView, dataStore: MainViewDataStoreProtocol) {
        self.view = view
        self.dataStore = dataStore
    }
    
    private func getView(storyboardName: String, viewIdentifier: String) -> UIViewController {
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: viewIdentifier)
        return view
    }
    
}

extension MainViewRouter: MainViewRouterProtocol {
    
    public func openAddEditContactView() {
        let title = NSLocalizedString("New_Contact_title", comment: "")
        let view = getView(storyboardName: "AddEditView", viewIdentifier: "AddEditView")
        
        view.navigationItem.title = title
        
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    public func openDetailView(for rowIndex: Int){
        let contact = dataStore.contacts[rowIndex]
        
        guard let view = getView(storyboardName: "DetailView", viewIdentifier: "DetailView") as? DetailView else { return }
        view.router.dataStore.contact = contact
        
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
}
