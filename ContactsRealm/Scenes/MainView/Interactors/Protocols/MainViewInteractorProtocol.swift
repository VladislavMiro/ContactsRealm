import Foundation

protocol MainViewInteractorProtocol {
    
    func fetchAllData()
    func fetchData(request: MainViewModels.FetchData.Request)
    func deleteData(request: MainViewModels.DeleteData.Request)
    
}
