//
//  NewGamesPresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol NewGamesPresenterProtocol: AnyObject {
    func didLoadGames(games: [Game])
    func showDetailTitle(_ viewModel: TitlePreviewViewModel)

    func viewDidLoadedGames()
    func saveFavoriteGames(games: [Game])
}

class NewGamesPresenter {
    weak var view: NewGamesViewProtocol?
    var router: NewGamesRouterProtocol
    var interactor: NewGamesInteractorProtocol

    init(interactor: NewGamesInteractorProtocol, router: NewGamesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension NewGamesPresenter: NewGamesPresenterProtocol {

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
