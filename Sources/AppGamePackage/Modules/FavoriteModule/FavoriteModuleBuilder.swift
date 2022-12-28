//
//  FavoriteModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

import UIKit

class FavoriteModuleBuilder {
    static func build() -> FavoriteViewController {
        let databaseManager = DatabaseManager()
        
        let interactor = FavoriteInteractor(databaseManager: databaseManager)
        let router = FavoriteRouter()
        let presenter = FavoritePresenter(interactor: interactor, router: router)
        let viewController = FavoriteViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

