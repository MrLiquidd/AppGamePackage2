//
//  PreviewInteractor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

import Foundation

protocol PreviewInteractorProtocol: AnyObject {
    func saveFavoriteGame(game: Game)
}

class PreviewInteractor: PreviewInteractorProtocol {
    weak var presenter: PreviewPresenterProtocol?

    func saveFavoriteGame(game: Game) {
        DatabaseManager.shared.addGame(game: game) { result in
            switch result{
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("updateFavorite"), object: nil)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
