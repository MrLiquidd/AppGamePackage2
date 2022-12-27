//
//  Home2Interactor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 25.12.2022
//

protocol HomeInteractorProtocol: AnyObject {
}

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?

}
