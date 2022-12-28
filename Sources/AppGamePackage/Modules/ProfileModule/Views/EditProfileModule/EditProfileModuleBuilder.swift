//
//  EditProfileModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

import UIKit

class EditProfileModuleBuilder {
    static func build() -> EditProfileViewController {

        let databaseManager = DatabaseManager()
        
        let interactor = EditProfileInteractor(databaseManager: databaseManager)
        let router = EditProfileRouter()
        let presenter = EditProfilePresenter(interactor: interactor, router: router)
        let viewController = EditProfileViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
