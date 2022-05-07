import Foundation

protocol AddEditViewInteractorProtocol {
    
    func saveData(request: AddEditViewModels.SaveData.Request)
    func showEmptyFields()
    func convertDate(request: AddEditViewModels.ConvertDate.Request)
    func convertPhoneNumber(request: AddEditViewModels.ConvertPhoneNumber.Request)
    func showData()
    
}
