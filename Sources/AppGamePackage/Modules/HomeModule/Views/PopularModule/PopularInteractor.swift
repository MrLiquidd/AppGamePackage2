//
//  PopularInteractor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

import Foundation

protocol PopularInteractorProtocol: AnyObject {
    func loadPopularGames()
    func saveFavoriteGames(games: [GameViewModel])
}

class PopularInteractor: PopularInteractorProtocol {


    weak var presenter: PopularPresenterProtocol?
    var databaseManager: DatabaseManager
    var apiCaller: APICaller

    init(databaseManager: DatabaseManager, apiCaller: APICaller) {
        self.databaseManager = databaseManager
        self.apiCaller = apiCaller
    }

    func loadPopularGames(){
        apiCaller.getGames(.Popularity){ [weak self] result in
            switch result{
                case .success(let games):
                    self?.presenter?.didLoadGames(games: games)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func saveFavoriteGames(games: [GameViewModel]) {
        for game in games {
            databaseManager.addGame(game: game) { result in
                switch result{
                    case .success():
                        NotificationCenter.default.post(name: NSNotification.Name("updateFavorite"), object: nil)
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}
