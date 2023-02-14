//
//  MockingNetworkTest.swift
//  SportAppTests
//
//  Created by Mahmoud on 14/02/2023.
//

import XCTest
@testable import SportApp
final class MockingNetworkTest: XCTestCase {

    override  func setUp() {
        
    }
    override func tearDown() {
        
    }
    func testMocLeaues (){
        MockingNetwork.fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341") { leagues in
            guard let leag = leagues else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(leag.result?.count, 0)
            
        }
    }
    func testMocEvent (){
        MockingNetwork.eventsFetchData(url: "") { eventResult  in
            guard let eventResult = eventResult else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(eventResult.result?.count, 0)
            
        }
    }
    func testMocEventResult (){
        MockingNetwork.resultFetchData(url: "") { results  in
            guard let results = results else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(results.result?.count, 0)
            
        }
    }

}
