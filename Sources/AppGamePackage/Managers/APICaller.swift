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

protocol APICallerProtocol: AnyObject{
    func getGames(_ caller: APICallers,completion:@escaping(Result<[Game], Error>) -> Void)
}

enum APIError: Error{
    case failedToGetData
}


enum APICallers: String{
    private var baseURL: String { return "https://www.gamerpower.com/api/giveaways" }

    case Popularity = "?type=game&sort-by=popularity"
    case DateGames = "?type=game&sort-by=date"

    var url: String {
        return baseURL + self.rawValue
    }

}

final class APICaller: APICallerProtocol{

    func getGames(_ caller: APICallers, completion: @escaping (Result<[Game], Error>) -> Void) {
            getGamesBy(caller.url, completion: completion)
        }

    func getGamesBy(_ url:String,completion:@escaping(Result<[Game], Error>) -> Void){
        guard let url = URL(string: url) else { return }
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

