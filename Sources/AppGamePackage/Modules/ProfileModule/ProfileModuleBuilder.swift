//
//  ProfileModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

import UIKit

class ProfileModuleBuilder {
    static func build() -> ProfileViewController {
        let databaseManager = DatabaseManager.shared
        let userDefaults = MTUserDefaults.shared

        let interactor = ProfileInteractor(databaseManager: databaseManager, userDefaults: userDefaults)
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        let viewController = ProfileViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
