//
//  PopularModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

class PopularModuleBuilder {
    static func build() -> PopularViewController {
        let databaseManager = DatabaseManager()
        let apiCaller = APICaller()

        let interactor = PopularInteractor( databaseManager: databaseManager, apiCaller: apiCaller)
        let router = PopularRouter()
        let presenter = PopularPresenter(interactor: interactor, router: router)
        let viewController = PopularViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
