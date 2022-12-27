//
//  APICaller.swift
//  AnimeApp
//
//  Created by Олег Борисов on 28.11.2022.
//

import Foundation

struct Constants{
    static let baseURL = "https://www.gamerpower.com/api"
}

enum APIError: Error{
    case failedToGetData
}

class APICaller{
    static let shared = APICaller()

    func getPopularGames(completion: @escaping(Result<[Game], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/giveaways?type=game&sort-by=popularity") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Game].self, from: data)
                completion(.success(results))
            } catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getValueGames(completion: @escaping(Result<[Game], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)value") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Game].self, from: data)
                completion(.success(results))
            } catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getDateGames(completion: @escaping(Result<[Game], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/giveaways?type=game&sort-by=date") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Game].self, from: data)
                completion(.success(results))
            } catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
