//
//  ProfileInteractor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

import Foundation
import UIKit

protocol ProfileInteractorProtocol: AnyObject {
    func deleteAllTitles()
    func fetchProfileFromDatabase()
    func setNewTheme(theme: Theme)
    func showNewTheme()
}

class ProfileInteractor: ProfileInteractorProtocol {

    weak var presenter: ProfilePresenterProtocol?

    var databaseManager: DatabaseManager
    var userDefaults: MTUserDefaults

    init(databaseManager: DatabaseManager, userDefaults: MTUserDefaults) {
        self.databaseManager = databaseManager
        self.userDefaults = userDefaults
    }

    func setNewTheme(theme: Theme) {
        userDefaults.theme = theme
    }

    func showNewTheme(){
        let newTheme = userDefaults.theme
        presenter?.showNewTheme(newTheme: newTheme)
    }

    func deleteAllTitles() {
        databaseManager.deleteAllTitles { result in
            switch result{
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("updateFavorite"), object: nil)
                    self.presenter?.deleteComplete()
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }

    func fetchProfileFromDatabase(){
        databaseManager.fetchProfileFromDataBase { result in
            switch result{
                case .success(let profile):
                    self.presenter?.loadProfile(profile: profile)
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }


}
