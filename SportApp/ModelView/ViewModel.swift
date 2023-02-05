//
//  ViewModel.swift
//  SportApp
//
//  Created by Abdallah ismail on 03/02/2023.
//

import Foundation
class ViewModel{
    var url : String?
    var bindingData : (()->()) = {}
    var result : [FootballLeague]!{
        didSet{
            bindingData()
        }
    }
    func getLeagues(){
        NetworkServices.fetchData(url: url,handlerComplition: { result in
            self.result = result?.result
        })
    }
}
