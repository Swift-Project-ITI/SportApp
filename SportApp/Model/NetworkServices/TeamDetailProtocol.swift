//
//  TeamDetailProtocol.swift
//  SportApp
//
//  Created by Abdallah ismail on 12/02/2023.
//

import Foundation
protocol teamDetail {
    static func teamsdetailFetchData(url: String?, handlerComplition: @escaping (TeamDetailsModel?) -> Void)
}
