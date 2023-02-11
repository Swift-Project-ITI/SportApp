//
//  NetworkServices.swift
//  SportApp
//
//  Created by Mahmoud on 05/02/2023.
//

import Foundation
import Alamofire
class NetworkServices:LeagueNetwork{
   

    
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
    
    
    
    static func eventsFetchData(url: String?, handlerComplition: @escaping (EvntModel?) -> Void) {
        
        AF.request("\(url!)").responseJSON { [self] response in
            guard let dataa = response.data else {
                return
            }

            do{
                                let events = try JSONDecoder().decode(EvntModel.self, from: dataa)
                handlerComplition(events)
            }catch let error {
                print(error.localizedDescription)
                handlerComplition(nil)
            }


        }
    }
    
    
    
    
    static func resultFetchData(url: String?, handlerComplition: @escaping (EvntResults?) -> Void) {
        
        AF.request("\(url!)").responseJSON { [self] response in
            guard let dataa = response.data else {
                return
            }

            do{
              

                let results = try JSONDecoder().decode(EvntResults.self, from: dataa)
                handlerComplition(results)
            }catch let error {
                print(error.localizedDescription)
                handlerComplition(nil)
            }


        }
    }
    
        
    
}
extension NetworkServices : LeagueTeams{
    static func teamsFetchData(url: String?, handlerComplition: @escaping (Teams?) -> Void) {
        AF.request("\(url!)").responseJSON { [self] response in
            print(response.data)
            guard let dataa = response.data else {
                return
            }

            do{
                let allTeams = try JSONDecoder().decode(Teams.self, from: dataa)
                handlerComplition(allTeams)
            }catch let error {
                print(error.localizedDescription)
                handlerComplition(nil)
            }


        }
    }
    
    
}
