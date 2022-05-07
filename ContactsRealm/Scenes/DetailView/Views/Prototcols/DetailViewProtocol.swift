import Foundation

protocol DetailViewProtocol: class {
    
    var interactor: DetailViewInteractorProtocol! { get set }
    var router: DetailViewRouterProtocol! { get set }
    
    func fillData(viewModel: DetailViewModels.ShowContact.ViewModel)
    
}
