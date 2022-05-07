import Foundation

final class AddEditViewInteractor: AddEditDataStoreProtocol {
    
    public var contact: ContactProtocol!
    public var isEditMode = false
    
    private let presenter: AddEditViewPresenterProtocol
    private let storageManagerWorker: AddEditSMWorkerProtocol
    
    init(presenter: AddEditViewPresenterProtocol, storageManagerWorker: AddEditSMWorkerProtocol) {
        self.presenter = presenter
        self.storageManagerWorker = storageManagerWorker
    }
    
}

extension AddEditViewInteractor: AddEditViewInteractorProtocol {
    
    public func saveData(request: AddEditViewModels.SaveData.Request) {
        
        let values = prepareData(request: request)
        
        if isEditMode {
            
            if let contact = contact, storageManagerWorker.changeData(newValues: values, for: contact) {
                presenter.returnToPreviousView()
            } else {
                let message = NSLocalizedString("Alert_Message_AddEditView_editError", comment: "")
                presenter.showAlert(response: .init(messageOfError: message))
            }
            
        } else {
            
            if storageManagerWorker.appendData(values: values) {
                presenter.returnToPreviousView()
            } else {
                let message = NSLocalizedString("Alert_Message_AddEditView_saveError", comment: "")
                presenter.showAlert(response: .init(messageOfError: message))
            }
            
        }
    }
    
    public func showData() {
        if isEditMode {
            presenter.showData(response: .init(data: contact))
        }
    }
    
    private func prepareData(request: AddEditViewModels.SaveData.Request) -> [String : Any?] {
        var values = [String : Any?]()
        
        values["photo"] = request.photo
        values["name"] = request.name
        values["lastName"] = request.lastName
        values["birthday"] = request.birthday
        values["phoneNumber"] = request.phoneNumber
        values["email"] = request.email
        values["address.city"] = request.homeCityAddress
        values["address.street"] = request.homeStreetAddress
        values["address.appartment"] = request.appartment
        values["job.companyName"] = request.companyName
        values["job.position"] = request.workPosition
        values["job.phoneNumber"] = request.workingPhoneNumber
        values["job.address.city"] = request.workingCityAddress
        values["job.address.street"] = request.workingStreetAddress
        
        return values
    }
    
    public func showEmptyFields() {
        let message = NSLocalizedString("Alert_Message_AddEditView_emptyTextField", comment: "")
        presenter.showEmptyFields(response: .init(errorMessage: message))
    }
    
    public func convertDate(request: AddEditViewModels.ConvertDate.Request) {
        presenter.convertDate(response: .init(date: request.date))
    }
    
    public func convertPhoneNumber(request: AddEditViewModels.ConvertPhoneNumber.Request) {
        presenter.convertPhoneNumber(response: .init(tagOfTextField: request.tagOfTextField,
                                                     phoneNumber: request.phoneNumber))
    }
    
}
