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
        databaseManager.deleteTitleWith(model: game) { result in
            switch result{
                case .success():
                    print("Successfully delted")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    func fetchGamesFromDataBase() {
        databaseManager.fetchFromDataBase{[weak self] (res:Array<GameItem>?, error) in
            if let result = res{
                self?.presenter?.viewDidLoadGames(games: result)
            } else{
                print(error!)
            }
        }
    }

}
