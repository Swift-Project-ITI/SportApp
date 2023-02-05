//
//  APIHandler.swift
//  SportApp
//
//  Created by Abdallah ismail on 02/02/2023.
//
//
//import Foundation
//import Alamofire
//
//class APIHandler {
//    func fetchData(handler :@escaping(_ apiData:[Model])->(Void)) {
//        let url = "https://sportscore1.p.rapidapi.com/sports"
//        let headers = [
//            "X-RapidAPI-Key": "7df7c94d83msha3f4b06d09697e8p1bd9f9jsn2cbfc4616792",
//            "X-RapidAPI-Host": "sportscore1.p.rapidapi.com"
//        ] as HTTPHeaders
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers:headers , interceptor: nil).response { response in
//            
//            
//            switch response.result{
//            case .success(let data):
//                do {
//                    let jsondata = try JSONDecoder().decode([Model].self, from: data!)
//                    print (jsondata)
//                    
//                }catch{
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            
//        }
//        
//        
//    }
//    
//    
//}
//
