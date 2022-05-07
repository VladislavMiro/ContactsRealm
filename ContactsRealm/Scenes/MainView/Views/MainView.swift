import UIKit

final class MainView: UITableViewController {

    public var interactor: MainViewInteractorProtocol!
    public var router: MainViewRouterProtocol!
    public var selectedIndex: Int = 0

    private var contacts = MainViewModels.FetchData.ViewModel().contacts
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    private func setup() {
        let presenter = MainViewPresenter(view: self)
        let storageManagerWorker = MainViewSMWorker(storageManager: StorageManager())
        let interactor = MainViewInteractor(presenter: presenter, storageManagerWorker: storageManagerWorker)
        self.interactor = interactor
        self.router = MainViewRouter(view: self, dataStore: interactor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchAllData()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchAllData()
    }
    
    @IBAction private func addNewButton(_ sender: UIBarButtonItem) {
        router.openAddEditContactView()
    }

}

// MARK: MainViewProtocolImplementation

extension MainView: MainViewProtocol {    
   
    public func showFetchedData(viewModel: MainViewModels.FetchData.ViewModel) {
        contacts = viewModel.contacts
        tableView.reloadData()
    }
    
    public func deleteRow(viewModel: MainViewModels.DeleteData.ViewModel) {
        contacts.remove(at: viewModel.indexOfDeletedElement.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [viewModel.indexOfDeletedElement], with: .fade)
        tableView.endUpdates()
    }
    
    public func showAlert(viewModel: MainViewModels.ShowError.ViewModel) {
        let title = NSLocalizedString("Alert_title_MainView", comment: "")
        
        let alert = UIAlertController(title: title, message: viewModel.errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Table view data source

extension MainView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = configureCell(for: indexPath)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteData(request: .init(index: indexPath))
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        router.openDetailView(for: indexPath.row)
        return indexPath
    }
    
    private func configureCell(for indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.cellIdentifire, for: indexPath) as? ContactCell {
            let contact = contacts[indexPath.row]
            
            cell.setData(name: contact.name,
                         lastName: contact.lastName,
                         image: contact.photo)
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
}

// MARK: navigation controller setup

extension MainView: UISearchResultsUpdating {
    
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        //add searchBar
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        guard let predicate = searchController.searchBar.text else { return }
        
        if !predicate.isEmpty {
            interactor.fetchData(request: .init(predicate: predicate))
            self.tableView.reloadData()
        } else {
            interactor.fetchAllData()
            self.tableView.reloadData()
        }
            
    }
    
}
