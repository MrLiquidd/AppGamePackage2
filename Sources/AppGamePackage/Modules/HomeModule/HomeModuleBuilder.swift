//
//  Home2ModuleBuilder.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import UIKit

class HomeModuleBuilder {
    static func build() -> HomeViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let viewController = HomeViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

