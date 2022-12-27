//
//  BaseModel.swift
//  AnimeApp
//
//  Created by Олег Борисов on 22.11.2022.
//

import Foundation

struct PopularGameResponse: Decodable{
    let results: [Game]
}

struct Game: Decodable{
    var id: Int64
    var title: String
    var worth: String
    var image: String
    var description: String
}

struct FavoriteGames{
    var game: Game
    var isSelect: Bool = false
}
