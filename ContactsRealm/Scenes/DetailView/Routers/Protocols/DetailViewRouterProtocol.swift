//
//  DetailViewRouterProtocol.swift
//  ContactsCoreData
//
//  Created by Vladislav Miroshnichenko on 30.04.2022.
//

import Foundation
import UIKit

protocol DetailViewRouterProtocol {
    var dataStore: DetailViewDataStoreProtocol { get set }
    func openEditView()
}
