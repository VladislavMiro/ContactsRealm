import Foundation

protocol DetailViewProtocol: AnyObject {
    
    var interactor: DetailViewInteractorProtocol! { get set }
    var router: DetailViewRouterProtocol! { get set }
    
    func fillData(viewModel: DetailViewModels.ShowContact.ViewModel)
    
}
