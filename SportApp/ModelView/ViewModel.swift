//
//  ViewModel.swift
//  SportApp
//
//  Created by Abdallah ismail on 03/02/2023.
//

import Foundation
class ViewModel{
    var url : String?
    var EventUrl: String?
    var ResultUrl: String?
    var teamURL : String?
    var teamDetailsURL : String?
    var bindingTeamsData : (()->()) = {}
    var bindingData : (()->()) = {}
    var evntbindData :(()->()) = {}
    var resultbindData :(()->()) = {}
    var detailsbindData :(()->()) = {}
    
    
    
    var teamResults :[Team] = []{
        didSet{
        bindingTeamsData()
        }
    }
    
    
    
    var result : [Leage]!{
        didSet{
            bindingData()
        }
    }
    
    var Evnts :[Events]!{
        didSet{
            evntbindData()
        }
    }
    var evntResult :[Results]!{
        didSet{
            resultbindData()
        }
    }
    var detailsTeam:[TeamDetail] = []{
        didSet{
            detailsbindData()
        }
    }
  
    func getLeagues(){
        NetworkServices.fetchData(url: url,handlerComplition: { result in
            self.result = result?.result
        })
    }
    
    
    
   
    
}
extension ViewModel : getTeamsProtocol{
   
    func getTeams() {
        NetworkServices.teamsFetchData(url: teamURL,handlerComplition: { teams in
            self.teamResults = teams?.result ?? []
        })
    }
    
    
}
extension ViewModel:getTeamDetails {
    func getTeamsdetails() {
        NetworkServices.teamsdetailFetchData(url: teamDetailsURL,handlerComplition: { details in
            self.detailsTeam = details?.result ?? []
    
        })
    }
    
}
extension ViewModel:getEventsProtocol{
    
    func getEvents(){
        NetworkServices.eventsFetchData(url:EventUrl,handlerComplition: { events in
            self.Evnts = events?.result
           
        })
       }

    
}
extension ViewModel:getresultsProtocol{
    
   
    func getResults(){
        NetworkServices.resultFetchData(url:ResultUrl,handlerComplition: { results in
            self.evntResult = results?.result
           
        })
       }
}

