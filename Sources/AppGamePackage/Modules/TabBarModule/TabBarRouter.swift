//
//  TabBarRouter.swift
//  AnimeApp
//
//  Created by Олег Борисов on 22.11.2022.
//

import Foundation
import UIKit

public protocol TabBarRouterProtocol: AnyObject{ }

public final class TabBarRouter {

    public static func build(using navController: UINavigationController) -> TabBarController{
        let router = TabBarRouter()
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view

    }
}

extension TabBarRouter: TabBarRouterProtocol { }
