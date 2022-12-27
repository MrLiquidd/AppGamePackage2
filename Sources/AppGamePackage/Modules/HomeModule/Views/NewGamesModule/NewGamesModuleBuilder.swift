//
//  NewGamesModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

class NewGamesModuleBuilder {
    static func build() -> NewGamesViewController {
        let databaseManager = DatabaseManager.shared
        let apiCaller = APICaller.shared
        
        let interactor = NewGamesInteractor(databaseManager: databaseManager, apiCaller: apiCaller)
        let router = NewGamesRouter()
        let presenter = NewGamesPresenter(interactor: interactor, router: router)
        let viewController = NewGamesViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
