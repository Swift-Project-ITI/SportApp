//
//  Teams.swift
//  SportApp
//
//  Created by Mahmoud on 08/02/2023.
//

import Foundation
class Team : Decodable{
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
    var coaches : [Coach]?
}
