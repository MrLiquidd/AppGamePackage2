//
//  PreviewPresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

protocol PreviewPresenterProtocol: AnyObject {
    func saveFavoriteGames(game: Game)
}

class PreviewPresenter {
    weak var view: PreviewViewProtocol?
    var router: PreviewRouterProtocol
    var interactor: PreviewInteractorProtocol

    init(interactor: PreviewInteractorProtocol, router: PreviewRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension PreviewPresenter: PreviewPresenterProtocol {

    func saveFavoriteGames(game: Game) {
        interactor.saveFavoriteGame(game: game)
    }
}
