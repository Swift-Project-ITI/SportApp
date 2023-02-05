//
//  LeagueNetworkProtocol.swift
//  SportApp
//
//  Created by Mahmoud on 05/02/2023.
//

import Foundation
protocol LeagueNetwork{
    static func fetchData(url : String?,handlerComplition : @escaping (LeagueResult?)->Void)
        
    
}
