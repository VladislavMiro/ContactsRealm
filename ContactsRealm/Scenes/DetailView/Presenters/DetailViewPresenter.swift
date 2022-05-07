import Foundation

final class DetailViewPresenter {
    
    private weak var view: DetailViewProtocol?
    private let dataFormatter: DataFormatterProtocol
    
    init(view: DetailViewProtocol, dataFormatter: DataFormatterProtocol) {
        self.view = view
        self.dataFormatter = dataFormatter
    }

}

extension DetailViewPresenter: DetailViewPresenterProtocol {
    
    public func showData(response: DetailViewModels.ShowContact.Response) {
        
        let contact = response.contact
        let birthday = dataFormatter.formatDate(date: contact.birthday) ?? ""
        
        let viewModel = DetailViewModels.ShowContact.ViewModel(name: contact.name,
                                                               lastName: contact.lastName,
                                                               birthday: birthday,
                                                               photo: contact.photo,
                                                               phoneNumber: contact.phoneNumber,
                                                               email: contact.email,
                                                               appartment: contact.address?.appartment ?? "",
                                                               homeCityAddress: contact.address?.city ?? "",
                                                               homeStreetAddress: contact.address?.street ?? "",
                                                               companyName: contact.job?.companyName ?? "",
                                                               workingPhoneNumber: contact.job?.phoneNumber ?? "",
                                                               workPosition: contact.job?.position ?? "",
                                                               workingCityAddress: contact.job?.address?.city ?? "",
                                                               workingStreetAddress: contact.job?.address?.street ?? "")
        
        view?.fillData(viewModel: viewModel)
        
    }
    
}
