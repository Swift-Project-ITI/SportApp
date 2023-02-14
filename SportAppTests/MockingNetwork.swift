//
//  MockingNetwork.swift
//  SportAppTests
//
//  Created by Mahmoud on 14/02/2023.
//

import Foundation
import Alamofire
@testable import SportApp
class MockingNetwork{
    static let mocItemJSONResponseForLeagues : String = "{\"result\":[{\"league_key\":4,\"league_name\":\"UEFA Europa League\",\"country_key\":1,\"country_name\":\"eurocups\",\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/\",\"country_logo\":null}]}"
    static let mocItemJSONResponseForEvents : String = "{\"success\":1,    \"result\":[{\"event_date\":\"2023-05-14\",            \"event_time\":\"07:00\",\"event_home_team\":\"Blacktown City\",\"event_away_team\":\"Rockdale Ilinden\",\"home_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/1063_blacktown-city.jpg\",\"away_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/1058_rockdale-ilinden.jpg\",\"event_home_team_logo\":null,\"event_away_team_logo\":null}]}"
    static let mocItemJSONResponseForResult : String = "{\"result\":[{\"event_home_team\":\"Cuba W\",\"event_away_team\":\"Dominican Republic W\",\"event_final_result\":\"73 - 59\",\"home_team_logo\":null,\"away_team_logo\":null,\"event_home_team_logo\":null,\"event_away_team_logo\":null}]}"
    static let mocItemJSONResponseForTeams : String = "{\"result\":[{\"team_key\":1091,\"team_name\":\"Leoben\", \"team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/1091_leoben.jpg\",\"players\":[{\"player_key\":1362119250,\"player_name\":\"F. Kinzl\",\"player_number\":\"\",\"player_image\":null}]}]}"
    
    static let mocItemJSONResponseForTeam : String = "{\"result\":[{\"team_key\":1091,\"team_name\":\"Leoben\"}]}"
    
    
    
    
    
}

extension MockingNetwork : LeagueNetwork{
    
    static func fetchData(url: String?, handlerComplition: @escaping (SportApp.LeagueResult?) -> Void) {
        
        
        let data = Data(mocItemJSONResponseForLeagues.utf8)
        print(data)
        do{
            let result = try JSONDecoder().decode(LeagueResult.self, from: data)
            handlerComplition(result)
        }catch let error {
            print(error.localizedDescription)
            handlerComplition(nil)
        }
        
    }
 
}
extension MockingNetwork : eventsFetchDataProtocol{
    static func eventsFetchData(url: String?, handlerComplition: @escaping (SportApp.EvntModel?) -> Void) {
        let data = Data(mocItemJSONResponseForEvents.utf8)
        do{
        let events = try JSONDecoder().decode(EvntModel.self, from: data)
            handlerComplition(events)
        }catch let error {
            print(error.localizedDescription)
            handlerComplition(nil)
        }
    }
    
}
extension MockingNetwork : resultFetchDataProtocol{
    static func resultFetchData(url: String?, handlerComplition: @escaping (SportApp.EvntResults?) -> Void) {
        let data = Data(mocItemJSONResponseForResult.utf8)
        do{
        let results = try JSONDecoder().decode(EvntResults.self, from: data)
            handlerComplition(results)
        }catch let error {
            print(error.localizedDescription)
            handlerComplition(nil)
        }
    }
    
    
}
extension MockingNetwork : teamDetail{
    static func teamsdetailFetchData(url: String?, handlerComplition: @escaping (SportApp.TeamDetailsModel?) -> Void) {
        let data = Data(mocItemJSONResponseForTeams.utf8)
        do{
        let teams = try JSONDecoder().decode(TeamDetailsModel.self, from: data)
            handlerComplition(teams)
        }catch let error {
            print(error.localizedDescription)
            handlerComplition(nil)
        }
    }
    
    
}

extension MockingNetwork : LeagueTeams{
    static func teamsFetchData(url: String?, handlerComplition: @escaping (SportApp.Teams?) -> Void) {
        let data = Data(mocItemJSONResponseForTeam.utf8)
        do{
        let team = try JSONDecoder().decode(Teams.self, from: data)
            handlerComplition(team)
        }catch let error {
            print(error.localizedDescription)
            handlerComplition(nil)
        }
    }
    
    
}
