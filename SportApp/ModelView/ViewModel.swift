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
    var bindingTeamsData : (()->()) = {}
    var bindingData : (()->()) = {}
    var evntbindData :(()->()) = {}
    var resultbindData :(()->()) = {}
    
    
    
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
  
    func getLeagues(){
        NetworkServices.fetchData(url: url,handlerComplition: { result in
            self.result = result?.result
        })
    }
    
    
    func getEvents(){
        NetworkServices.eventsFetchData(url:EventUrl,handlerComplition: { events in
            self.Evnts = events?.result
           
        })
       }
    
    func getResults(){
        NetworkServices.resultFetchData(url:ResultUrl,handlerComplition: { results in
            self.evntResult = results?.result
           
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
