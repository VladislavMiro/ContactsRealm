import Foundation
import UIKit

final class AddEditViewRouter {

    public var dataStore: AddEditDataStoreProtocol

    private weak var view: AddEditView?

    init(view: AddEditView, dataStore: AddEditDataStoreProtocol) {
        self.view = view
        self.dataStore = dataStore
    }
    
}

extension AddEditViewRouter: AddEditViewRouterProtocol {
    
    public func popViewController() {
        self.view?.navigationController?.popViewController(animated: true)
    }
    
    public func popToRootViewController() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
}
