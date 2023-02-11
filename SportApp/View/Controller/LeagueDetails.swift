//
//  LeagueDetails.swift
//  SportApp
//
//  Created by Abdallah ismail on 06/02/2023.
//

import UIKit
import Kingfisher
import CoreData
class LeagueDetails: UIViewController {

    @IBOutlet var btn: UIView!
    @IBOutlet weak var ResultsCollectionView: UICollectionView!

    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    var evntModel: ViewModel?
    var test : [NSManagedObject] = []
    var DetailsUrl : String?
    var leagueINFO : Leage = Leage()
    var leagueId : Int?
    var sportType : String?
    var ResultsUrls : String?
    var results : [Results] = []
    var evnts : [Events] = []
    var teams : [Team] = []
    let group = DispatchGroup()
 
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let teamURL = "https://apiv2.allsportsapi.com/\(sportType!)/?met=Teams&?met=Leagues&leagueId=\(leagueId!)&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
      
        let nib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        self.TeamsCollectionView.register(nib, forCellWithReuseIdentifier: "teamCell")
        
        ResultsCollectionView.layer.borderColor = UIColor.black.cgColor
        ResultsCollectionView.layer.borderWidth = 3.0
        ResultsCollectionView.layer.cornerRadius = 3.0
        eventCollectionView.layer.borderColor = UIColor.green.cgColor
        eventCollectionView.layer.borderWidth = 3.0
        eventCollectionView.layer.cornerRadius = 3.0
        TeamsCollectionView.layer.borderColor = UIColor.red.cgColor
        TeamsCollectionView.layer.borderWidth = 3.0
        TeamsCollectionView.layer.cornerRadius = 3.0
        
        
        
        
        
//        let layout = UICollectionViewFlowLayout()
//        TeamsCollectionView.collectionViewLayout = layout
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: self.view.frame.height / 3 -  20)
        
        evntModel = ViewModel()
     ResultsCollectionView.delegate = self
     ResultsCollectionView.dataSource = self
//     eventCollectionView.delegate = self
//     eventCollectionView.dataSource = self
        
        evntModel?.EventUrl = self.DetailsUrl
        evntModel?.ResultUrl = self.ResultsUrls
        evntModel?.teamURL = teamURL
    
        
        
        
        evntModel?.getEvents()
        evntModel?.getResults()
        evntModel?.getTeams()
        
        
        evntModel?.evntbindData = {()in
        self.renderVieww()
        
            }
        evntModel?.resultbindData = {()in
        self.renderViewresult()
        
            }
       
        evntModel?.bindingTeamsData={
            self.renderAfterTeamData()
        }
    }
    func renderAfterTeamData(){
        DispatchQueue.main.async {
            self.teams = self.evntModel?.teamResults ?? []
            print(self.teams[0].team_name)

            self.TeamsCollectionView.reloadData()
            
        }
    }
    func renderVieww(){
        DispatchQueue.main.async {
            self.evnts = self.evntModel?.Evnts ?? []
            self.eventCollectionView.reloadData()
         
        }
    }
    
    
    func renderViewresult(){
        DispatchQueue.main.async {
          
            self.results = self.evntModel?.evntResult ?? []
            self.ResultsCollectionView.reloadData()
         
        }
    }
    
    
    
   
    @IBAction func addFavoriate(_ sender: Any) {
        
        //1
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2
        var managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "LeagueClass")
        //4
        
        fetchRequest.predicate = NSPredicate(format: "leagueName == %@",leagueINFO.league_name!)
        
        
        do{
//            managedContext.
            test = try managedContext.fetch(fetchRequest)
            //self.tview.reloadData()
            
            
        }catch let error as NSError{
            print(error)
        }
        
        
        
        
        //        print(fetchRequest.predicate)
        //        print("in add buttoni")
        if(test.count == 0){
            //1
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            //2
            managedContext = appDelegate.persistentContainer.viewContext
            //3
            let entity = NSEntityDescription.entity(forEntityName: "LeagueClass", in: managedContext)
            //4
            do{
                let leag = NSManagedObject(entity: entity!, insertInto: managedContext)
                leag.setValue(leagueINFO.league_key, forKey: "leagueKey")
                leag.setValue(leagueINFO.league_name, forKey: "leagueName")
                leag.setValue(leagueINFO.league_logo, forKey: "leagueLogo")
                leag.setValue(self.sportType, forKey: "sportType")
                
                try managedContext.save()
                
            }catch let error as NSError{
                print(error)
            }
        }
        
    }

}
extension LeagueDetails :UICollectionViewDelegate {
    

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        }
  


}



extension LeagueDetails:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.eventCollectionView{
            return evnts.count
        }
        else if collectionView == self.ResultsCollectionView{
                return results.count
        }
        else{
            return teams.count
        }
            
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            
            if collectionView == self.eventCollectionView{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventt", for:indexPath)as! EventCollectionViewCell
                let evntss=evnts[indexPath.row]
                cell.homeTeam.text = evntss.event_home_team
                cell.awayTeam.text = evntss.event_away_team
                let homeimgurl = URL(string:evntss.home_team_logo ?? "3")
                cell.awayimg?.kf.setImage(with:homeimgurl)
                let awayimgurl = URL(string:evntss.away_team_logo ?? "3")
                cell.homeimg?.kf.setImage(with:awayimgurl)
                cell.backgroundColor = UIColor.white
                cell.time.text = evntss.event_time
                return cell
            }
            
            else if collectionView === self.ResultsCollectionView{
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "result", for:indexPath)as! ResultsCollectionViewCell
                let resultmatch = results [indexPath.row]
                cell2.homeResult.text = resultmatch.event_home_team
                cell2.awayResult.text = resultmatch.event_away_team
                cell2.matchResults.text = resultmatch.event_final_result
                let homeimgurl = URL(string:resultmatch.home_team_logo ?? "3")
                cell2.homeImg?.kf.setImage(with:homeimgurl)
                let awayimgurl = URL(string:resultmatch.away_team_logo ?? "3")
                cell2.awayImg?.kf.setImage(with:awayimgurl)
                
                return cell2
            }
            else{
                let cell13 = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
                cell13.configureLabel(with: teams[indexPath.row].team_name)
                cell13.configureImage(with: URL(string: teams[indexPath.row].team_logo ?? ""))
                return cell13
            }
        }
        
        
        
    }
    
    
    
extension LeagueDetails:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == TeamsCollectionView{
            return CGSize(width: UIScreen.main.bounds.width  ,height: UIScreen.main.bounds.height / 3 - 80  )

        }
        else if collectionView == eventCollectionView
        {
            
                return CGSize(width: UIScreen.main.bounds.width  ,height: UIScreen.main.bounds.height / 3 - 80)
            
        }
        else if collectionView == ResultsCollectionView{
            return CGSize(width: UIScreen.main.bounds.width / 2 - 20 ,height: self.view.bounds.height / 3   )
        }
        return CGSize(width: 0 , height: 0)
    }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 0
//        }
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 0
//        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//            return CGSize(width: self.view.frame.width*0.1, height: self.view.frame.height / 3)
//        }
//
        
        
    }
    




