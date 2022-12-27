//
//  FavoritePresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

protocol FavoritePresenterProtocol: AnyObject {
    func didFetchGamesFromDB()
    func viewDidLoadGames(games: [GameItem])
    func deleteFavoriteGame(game: GameItem)
}

class FavoritePresenter {
    weak var view: FavoriteViewProtocol?
    var router: FavoriteRouterProtocol
    var interactor: FavoriteInteractorProtocol

    init(interactor: FavoriteInteractorProtocol, router: FavoriteRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritePresenter: FavoritePresenterProtocol {

    func didFetchGamesFromDB() {
        interactor.fetchGamesFromDataBase()
    }

    func viewDidLoadGames(games: [GameItem]) {
        view?.showDownloadGames(games: games)
    }

    func deleteFavoriteGame(game: GameItem){
        interactor.deleteFavoriteGame(game: game)
    }

}
