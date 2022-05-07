import Foundation

final class DetailViewInteractor: DetailViewDataStoreProtocol {
    
    public var contact: ContactProtocol!
    
    private let presenter: DetailViewPresenterProtocol
    
    init(presenter: DetailViewPresenterProtocol) {
        self.presenter = presenter
    }
    
}

extension DetailViewInteractor: DetailViewInteractorProtocol {
    
    public func showContact() {
        presenter.showData(response: .init(contact: contact))
    }
    
}
