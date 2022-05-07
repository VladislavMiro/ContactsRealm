import UIKit

final class AddEditView: UIViewController {
    
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var toolBar: UIToolbar!
    @IBOutlet private weak var imageView: UIImageView!

    public var router: AddEditViewRouterProtocol!
    public var interactor: AddEditViewInteractorProtocol!
    
    private var photoOfContact: UIImage?
    private var values: [String:Any] = Dictionary()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    private func setup() {
        let presenter = AddEditViewPresenter(view: self, dataFormatter: DataFormatter())
        let worker = AddEditSMWorker(storageManager: StorageManager())
        let interactor = AddEditViewInteractor(presenter: presenter, storageManagerWorker: worker)
        self.interactor = interactor
        router = AddEditViewRouter(view: self, dataStore: interactor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.layer.cornerRadius = imageView.layer.frame.height / 2
        imageView.layer.masksToBounds = true
        
        addKeyboardObserver()
        addGestureRecognizer()
        
        interactor.showData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteKeyboardObserver()
    }

    @IBAction private func saveButtonAction(_ sender: UIBarButtonItem) {
        
        guard textFields != nil,
              let nameTexField = textFields.first(where: {$0.tag == 1}),
              let lastNameTextField = textFields.first(where: {$0.tag == 2}),
              let name = nameTexField.text,
              let lastName = lastNameTextField.text
        else { return }
        
        if !name.isEmpty && !lastName.isEmpty {
            
            let request = fillContact()
                
            interactor.saveData(request: request)

        } else {
            interactor.showEmptyFields()
        }
        
    }
    
    @IBAction private func toolBarDoneButton(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    private func fillContact() -> AddEditViewModels.SaveData.Request {
    
        var request = AddEditViewModels.SaveData.Request()
    
        let photo = photoOfContact == nil ? nil : photoOfContact?.jpegData(compressionQuality: 1.0)
        
        request.photo = photo
        
        for textField in textFields {
            switch textField.tag {
            case 1:
                request.name = textField.text
            case 2:
                request.lastName = textField.text
            case 3:
                let date = datePicker.date
                request.birthday = date
            case 4:
                request.phoneNumber = textField.text
            case 5:
                request.email = textField.text
            case 6:
                request.homeCityAddress = textField.text
            case 7:
                request.homeStreetAddress = textField.text
            case 8:
                request.appartment = textField.text
            case 9:
                request.companyName = textField.text
            case 10:
                request.workPosition = textField.text
            case 11:
                request.workingPhoneNumber = textField.text
            case 12:
                request.workingCityAddress = textField.text
            case 13:
                request.workingStreetAddress = textField.text
            default:
                continue
            }
        }
        
        return request
        
    }
    
    private func configureDatePicker() {
        if let textField = textFields.first(where: {$0.tag == 3}) {
            datePicker.locale = Locale.current
            textField.inputView = datePicker
            textField.inputAccessoryView = toolBar
        }
    }
    
}

// MARK: AddEditViewProtocol implemetation

extension AddEditView: AddEditViewProtocol {
    
    public func showAlert(viewModel: AddEditViewModels.ShowError.ViewModel) {
        let title = NSLocalizedString("Alert_title_AddEditView", comment: "")
        
        let alert = UIAlertController(title: title, message: viewModel.messageOfError, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    public func fillTextFields(viewModel: AddEditViewModels.ShowData.ViewModel) {
        
        if let data = viewModel.photo {
            photoOfContact = UIImage(data: data)
            imageView.image = photoOfContact
        }
        
        for textField in textFields {
            switch textField.tag {
            case 1:
                textField.text = viewModel.name
            case 2:
                textField.text = viewModel.lastName
            case 3:
                textField.text = viewModel.birthday
            case 4:
                textField.text = viewModel.phoneNumber
            case 5:
                textField.text = viewModel.email
            case 6:
                textField.text = viewModel.homeCityAddress
            case 7:
                textField.text = viewModel.homeStreetAddress
            case 8:
                textField.text = viewModel.appartment
            case 9:
                textField.text = viewModel.companyName
            case 10:
                textField.text = viewModel.workPosition
            case 11:
                textField.text = viewModel.phoneNumber
            case 12:
                textField.text = viewModel.workingCityAddress
            case 13:
                textField.text = viewModel.workingStreetAddress
            default:
                continue
            }
        }
    }
    
    public func showEmptyFields() {
        
        guard textFields != nil,
              let nameTexField = textFields.first(where: {$0.tag == 1}),
              let lastNameTextField = textFields.first(where: {$0.tag == 2})
        else { return }
        
        nameTexField.layer.borderWidth = 0.3
        nameTexField.layer.masksToBounds = true
        lastNameTextField.layer.borderWidth = 0.3
        lastNameTextField.layer.masksToBounds = true
        nameTexField.layer.borderColor = UIColor.red.cgColor
        lastNameTextField.layer.borderColor = UIColor.red.cgColor
        
    }
    
    public func setConvertedDate(viewModel: AddEditViewModels.ConvertDate.ViewModel) {
        guard textFields != nil,
              let birthdayTexField = textFields.first(where: {$0.tag == 3})
        else { return }
        birthdayTexField.text = viewModel.date
    }
    
    public func setConvertedPhoneNumber(viewModel: AddEditViewModels.ConvertPhoneNumber.ViewModel) {
        guard textFields != nil,
              let texField = textFields.first(where: {$0.tag == viewModel.tagOfTextField})
        else { return }
        
        texField.text = viewModel.phoneNumber
    }
    
}

// MARK: imageView functions

extension AddEditView: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnImageView))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc private func tapOnImageView() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        imageView.image = image
        photoOfContact = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Keyboard functions

extension AddEditView {
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowEvent), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideEvent), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShowEvent(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight + 10, right: 0.0)
                
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardHideEvent(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
                
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    private func deleteKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: TextField functions

extension AddEditView: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            textField.layer.borderWidth = 0.0
        case 2:
            textField.layer.borderWidth = 0.0
        case 4:
            textField.inputAccessoryView = toolBar
        case 11:
            textField.inputAccessoryView = toolBar
        default:
            return true
        }
        
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let phoneNumber = textField.text else { return true }
        
        switch textField.tag {
        case 4:
            interactor.convertPhoneNumber(request: .init(tagOfTextField: 4, phoneNumber: phoneNumber))
        case 11:
            interactor.convertPhoneNumber(request: .init(tagOfTextField: 11, phoneNumber: phoneNumber))
        default:
            return true
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 3:
            interactor.convertDate(request: .init(date: datePicker.date))
        default:
            return
        }
    }

}
