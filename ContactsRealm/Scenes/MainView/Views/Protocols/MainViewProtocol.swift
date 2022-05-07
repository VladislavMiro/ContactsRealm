//
//  MainViewProtocol.swift
//  ContactsRealm
//
//  Created by Vladislav Miroshnichenko on 29.01.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    
    var interactor: MainViewInteractorProtocol! { get set }
    var router: MainViewRouterProtocol! { get set }
    var selectedIndex: Int { get }
    
    func showFetchedData(viewModel: MainViewModels.FetchData.ViewModel)
    func deleteRow(viewModel: MainViewModels.DeleteData.ViewModel)
    func showAlert(viewModel: MainViewModels.ShowError.ViewModel)

}
