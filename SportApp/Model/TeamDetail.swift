//
//  TeamDetail.swift
//  SportApp
//
//  Created by Abdallah ismail on 12/02/2023.
//

import Foundation
class TeamDetail : Decodable {
    var team_key : Int?
    var team_name : String?
    var team_logo: String?
    var players : [Player]?
    var coaches : [Coach]?

}
