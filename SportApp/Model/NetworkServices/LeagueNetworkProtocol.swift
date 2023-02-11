//
//  LeagueNetworkProtocol.swift
//  SportApp
//
//  Created by Mahmoud on 05/02/2023.
//

import Foundation
protocol LeagueNetwork{
    static func fetchData(url : String?,handlerComplition : @escaping (LeagueResult?)->Void)
    static func eventsFetchData(url : String?,handlerComplition : @escaping (EvntModel?)->Void)
    static func resultFetchData(url: String?, handlerComplition: @escaping (EvntResults?) -> Void)
}
