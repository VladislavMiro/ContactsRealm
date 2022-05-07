import UIKit

final class DetailView: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet private var labels: [UILabel]!

    public var interactor: DetailViewInteractorProtocol!
    public var router: DetailViewRouterProtocol!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let dataFormatter = DataFormatter()
        let presenter = DetailViewPresenter(view: self, dataFormatter: dataFormatter)
        let interactor = DetailViewInteractor(presenter: presenter)
        self.interactor = interactor
        self.router = DetailViewRouter(view: self, dataStore: interactor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
        
        interactor.showContact()
    }
    
    @IBAction private func editButton(_ sender: UIBarButtonItem) {
        router.openEditView()
    }

}

extension DetailView: DetailViewProtocol {
    
    public func fillData(viewModel: DetailViewModels.ShowContact.ViewModel) {
        guard let labels = labels else { return }
        
        let photo = viewModel.photo
        
        imageView.image = photo != nil ? UIImage(data: photo!) : UIImage(named: "defaultPhoto")
        
        for label in labels {
            
            switch label.tag {
            case 1:
                label.text = viewModel.name ?? ""
            case 2:
                label.text = viewModel.lastName ?? ""
            case 3:
                label.text = viewModel.birthday ?? ""
            case 4:
                let text = NSLocalizedString("Phone_Number_DetailView", comment: "")
                label.text! = text + (viewModel.phoneNumber ?? "")
            case 5:
                let text = NSLocalizedString("Email_DetailView", comment: "")
                label.text! = text + (viewModel.email ?? "")
            case 6:
                let text = NSLocalizedString("Home_City_DetailView", comment: "")
                label.text! = text + (viewModel.homeCityAddress ?? "")
            case 7:
                let text = NSLocalizedString("Home_Street_DetailView", comment: "")
                label.text! = text + (viewModel.homeStreetAddress ?? "")
            case 8:
                let text = NSLocalizedString("Appartment_DetailView", comment: "")
                label.text! = text + (viewModel.appartment ?? "")
            case 9:
                let text = NSLocalizedString("Company_Name_DetailView", comment: "")
                label.text! = text + (viewModel.companyName ?? "")
            case 10:
                let text = NSLocalizedString("Working_Position_DetailView", comment: "")
                label.text! = text + (viewModel.workPosition ?? "")
            case 11:
                let text = NSLocalizedString("Working_Phone_DetailView", comment: "")
                label.text! = text + (viewModel.workingPhoneNumber ?? "")
            case 12:
                let text = NSLocalizedString("Working_City_DetailView", comment: "")
                label.text! = text + (viewModel.workingCityAddress ?? "")
            case 13:
                let text = NSLocalizedString("Working_Street_DetailView", comment: "")
                label.text! = text + (viewModel.workingStreetAddress ?? "")
            default:
                continue
            }
        }
        
    }
    
}
