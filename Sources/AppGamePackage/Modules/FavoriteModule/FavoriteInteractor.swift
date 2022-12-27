//
//  FavoriteInteractor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

protocol FavoriteInteractorProtocol: AnyObject {
    func deleteFavoriteGame(game: GameItem)
    func fetchGamesFromDataBase()
}

class FavoriteInteractor: FavoriteInteractorProtocol {

    weak var presenter: FavoritePresenterProtocol?
    var databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func deleteFavoriteGame(game: GameItem) {
        DatabaseManager.shared.deleteTitleWith(model: game) { result in
            switch result{
                case .success():
                    print("Successfully delted")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func fetchGamesFromDataBase() {
        DatabaseManager.shared.fetchGamesFromDataBase {[weak self] result in
            switch result{
                case .success(let games):
                    self?.presenter?.viewDidLoadGames(games: games)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

}
