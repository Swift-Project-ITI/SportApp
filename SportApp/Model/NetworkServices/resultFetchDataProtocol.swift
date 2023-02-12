//
//  resultFetchDataProtocol.swift
//  SportApp
//
//  Created by Abdallah ismail on 12/02/2023.
//

import Foundation
protocol resultFetchDataProtocol {
    
    static func resultFetchData(url: String?, handlerComplition: @escaping (EvntResults?) -> Void)
    
    
}
