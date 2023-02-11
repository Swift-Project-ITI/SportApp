//
//  LeagueTeamsProtocol.swift
//  SportApp
//
//  Created by Mahmoud on 08/02/2023.
//

import Foundation
protocol LeagueTeams {
    static func teamsFetchData(url: String?, handlerComplition: @escaping (Teams?) -> Void)
}
