import Foundation

protocol MainViewPresenterProtocol {
    
    func presentFetchedData(response: MainViewModels.FetchData.Response)
    func deleteRow(response: MainViewModels.DeleteData.Response)
    func showError(response: MainViewModels.ShowError.Response)
    
}
