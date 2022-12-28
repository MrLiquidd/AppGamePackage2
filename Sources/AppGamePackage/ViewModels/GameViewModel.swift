//
//  File.swift
//  
//
//  Created by Олег Борисов on 29.12.2022.
//

import Foundation

struct GameViewModel: Decodable{
    var id: Int64
    var title: String
    var worth: String
    var image: String
    var description: String
}
