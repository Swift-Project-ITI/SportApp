//
//  eventsFetchDataProtocol.swift
//  SportApp
//
//  Created by Abdallah ismail on 12/02/2023.
//

import Foundation
protocol eventsFetchDataProtocol {
    static func eventsFetchData(url : String?,handlerComplition : @escaping (EvntModel?)->Void)
}
