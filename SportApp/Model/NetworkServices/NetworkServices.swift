//
//  NetworkServices.swift
//  SportApp
//
//  Created by Mahmoud on 05/02/2023.
//

import Foundation
import Alamofire
class NetworkServices : LeagueNetwork{
    static func fetchData(url : String?,handlerComplition: @escaping (LeagueResult?) -> Void) {
      
        AF.request("\(url!)").responseJSON { [self] response in
            guard let data = response.data else {
                return
            }
            
            do{
                let result = try JSONDecoder().decode(LeagueResult.self, from: data)
                handlerComplition(result)
            }catch let error {
                print(error.localizedDescription)
                handlerComplition(nil)
            }
            
        }
    }
        
    
}
