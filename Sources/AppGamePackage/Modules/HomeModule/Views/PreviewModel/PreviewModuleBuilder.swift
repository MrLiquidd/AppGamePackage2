//
//  PreviewModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

import UIKit

class PreviewModuleBuilder {
    static func build() -> PreviewViewController {

        let databaseManager = DatabaseManager()

        let interactor = PreviewInteractor(databaseManager: databaseManager)
        let router = PreviewRouter()
        let presenter = PreviewPresenter(interactor: interactor, router: router)
        let viewController = PreviewViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
