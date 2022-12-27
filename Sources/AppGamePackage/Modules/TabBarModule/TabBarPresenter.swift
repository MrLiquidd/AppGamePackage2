//
//  TabBarPresenter.swift
//  AnimeApp
//
//  Created by Олег Борисов on 22.11.2022.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject{
    func notifyViewLoaded()
}
final class TabBarPresenter{

    private weak var view: TabBarViewProtocol?
    private weak var router: TabBarRouterProtocol?

    init(view: TabBarViewProtocol?, router: TabBarRouterProtocol?) {
        self.view = view
        self.router = router
    }
}


extension TabBarPresenter: TabBarPresenterProtocol{
    func notifyViewLoaded() {
        view?.setupView()
    }
}
