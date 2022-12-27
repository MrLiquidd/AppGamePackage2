//
//  PopularPresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol PopularPresenterProtocol: AnyObject {
    func didLoadGames(games: [Game])
    func showDetailTitle(_ viewModel: TitlePreviewViewModel)

    func viewDidLoadedGames()
    func saveFavoriteGames(games: [Game])
}

class PopularPresenter {
    weak var view: PopularViewProtocol?
    var router: PopularRouterProtocol
    var interactor: PopularInteractorProtocol

    init(interactor: PopularInteractorProtocol, router: PopularRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension PopularPresenter: PopularPresenterProtocol {
    func didLoadGames(games: [Game]) {
        view?.showPopularGames(games: games)
    }

    func viewDidLoadedGames() {
        interactor.loadPopularGames()
    }

    func saveFavoriteGames(games: [Game]) {
        interactor.saveFavoriteGames(games: games)
    }

    func showDetailTitle(_ viewModel: TitlePreviewViewModel) {
        router.showDetailTitle(viewModel)
    }


}
