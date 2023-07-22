import Foundation
import UIKit

protocol AddEditViewProtocol: AnyObject {
    
    var router: AddEditViewRouterProtocol! { get set }
    var interactor: AddEditViewInteractorProtocol! { get set }
    
    func showAlert(viewModel: AddEditViewModels.ShowError.ViewModel)
    func showEmptyFields()
    func setConvertedDate(viewModel: AddEditViewModels.ConvertDate.ViewModel)
    func setConvertedPhoneNumber(viewModel: AddEditViewModels.ConvertPhoneNumber.ViewModel)
    func fillTextFields(viewModel: AddEditViewModels.ShowData.ViewModel)
    
}
