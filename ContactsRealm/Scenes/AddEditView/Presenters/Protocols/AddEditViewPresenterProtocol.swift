import Foundation

protocol AddEditViewPresenterProtocol {

    func showAlert(response: AddEditViewModels.ShowError.Response)
    func showEmptyFields(response: AddEditViewModels.ShowEmptyFields.Response)
    func convertDate(response: AddEditViewModels.ConvertDate.Response)
    func convertPhoneNumber(response: AddEditViewModels.ConvertPhoneNumber.Response)
    func showData(response: AddEditViewModels.ShowData.Response)
    func returnToPreviousView()
    
}
