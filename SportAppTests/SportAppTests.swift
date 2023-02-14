//
//  SportAppTests.swift
//  SportAppTests
//
//  Created by Abdallah ismail on 30/01/2023.
//

import XCTest
@testable import SportApp

final class SportAppTests: XCTestCase {
    var testLeagueURL : String?
    var eventURL  : String?
    var resultURL : String?
    var teamsURL : String?
    
    var leagues : [LeagueResult]?
    var events : [Events]?
    var results : [Results]?
    var teams : [Teams]?
    override func setUp() {
    testLeagueURL = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
        eventURL = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=50/&from=2022-03-07&to=2023-05-18&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
        resultURL = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&leagueId=%2250%22/&from=2022-8-18&to=2023-02-07&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
        teamsURL = "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=55&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
        
        
        leagues = [LeagueResult]()
        events = [Events]()
        results = [Results]()
        
    }
   
    override func tearDown() {
        testLeagueURL = nil
        eventURL = nil
        leagues = nil
    }
    func testLeagueTable(){
        let ex = expectation(description: "Waiting leaues API Resonse")
        NetworkServices.fetchData(url:testLeagueURL,handlerComplition: {leagueResult in
            guard let leagues = leagueResult?.result else{
                XCTFail()
                ex.fulfill()
                return
            }
            XCTAssertNotEqual(leagues.count, 0)
            ex.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    func testEvent(){
        let ex = expectation(description: "Waiting Events API Resonse")
        NetworkServices.eventsFetchData(url:eventURL,handlerComplition: {eventResult in
            guard let events = eventResult?.result else{
                XCTFail()
                ex.fulfill()
                return
            }
            XCTAssertNotEqual(events.count, 0)
            ex.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func testResult(){
        let ex = expectation(description: "Waiting Result API Resonse")
        NetworkServices.resultFetchData(url:resultURL,handlerComplition: {resultResult in
            guard let results = resultResult?.result else{
                XCTFail()
                ex.fulfill()
                return
            }
            XCTAssertNotEqual(results.count, 0)
            ex.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    func testTeams(){
        let ex = expectation(description: "Waiting teams API Resonse")
        NetworkServices.teamsFetchData(url:teamsURL,handlerComplition: {teamsResults in
            guard let teams = teamsResults?.result else{
                XCTFail()
                ex.fulfill()
                return
            }
            XCTAssertNotEqual(teams.count, 0)
            ex.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
}
//4356
