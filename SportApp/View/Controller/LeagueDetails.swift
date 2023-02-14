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

    @IBOutlet weak var btn: UIButton!
   
    @IBOutlet weak var ResultsCollectionView: UICollectionView!

    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    var evntModel: ViewModel?
    var test : [NSManagedObject] = []
    var DetailsUrl : String?
    var teamDetailsUrll : String?
    var leagueINFO : Leage = Leage()
    var teamkeyy : Team = Team()
    var leagueId : Int?
    var sportType : String?
    var ResultsUrls : String?
    var teamsUrl : String?
    var results : [Results] = []
    var evnts : [Events] = []
    var teams : [Team] = []
    let group = DispatchGroup()
//    let collection = NoteCollection()

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let teamURL = teamsUrl ?? "https://apiv2.allsportsapi.com/\(sportType ?? "no title")/?met=Teams&?met=Leagues&leagueId=\(leagueId ?? 153)&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
      
        let nib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        self.TeamsCollectionView.register(nib, forCellWithReuseIdentifier: "teamCell")
        
//        ResultsCollectionView.layer.borderColor = UIColor.systemGray.cgColor
//        ResultsCollectionView.layer.borderWidth = 3.0
//        ResultsCollectionView.layer.cornerRadius = 20.0
//
//        eventCollectionView.layer.borderColor = UIColor.systemGray.cgColor
//        eventCollectionView.layer.borderWidth = 3.0
//        eventCollectionView.layer.cornerRadius = 10.0
        
//        TeamsCollectionView.layer.borderColor = UIColor.systemGray.cgColor
//        TeamsCollectionView.layer.borderWidth = 3.0
//        TeamsCollectionView.layer.cornerRadius = 3.0
//       ResultsCollectionView.layer.masksToBounds = true
//
 
        
        
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
        
        renderall()
     
      
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2
        var managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "LeagueClass")
        //4
        
        fetchRequest.predicate = NSPredicate(format: "leagueName == %@",leagueINFO.league_name ?? "")
        
        
        do{
//            managedContext.
            test = try managedContext.fetch(fetchRequest)
            //self.tview.reloadData()
            
            
        }catch let error as NSError{
            print(error)
        }
        if test.count != 0
        {
            btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            btn.tintColor = .blue
        }
    }
    func renderAfterTeamData(){
        DispatchQueue.main.async {
            self.teams = self.evntModel?.teamResults ?? []
//            print(self.teams[0].team_name)

         
            
        }
    }
    func renderVieww(){
        DispatchQueue.main.async {
            self.evnts = self.evntModel?.Evnts ?? []
       
         
        }
    }
    
    
    func renderViewresult(){
        DispatchQueue.main.async {
          
            self.results = self.evntModel?.evntResult ?? []
         
        }
    }
    func renderall(){
        group.enter()
        evntModel?.evntbindData = {()in
        self.renderVieww()
            self.group.leave()
            }
        group.enter()
        evntModel?.resultbindData = {()in
        self.renderViewresult()
            self.group.leave()
            }
        group.enter()
        
         evntModel?.bindingTeamsData={
             self.renderAfterTeamData()
             self.group.leave()
         }
        group.notify(queue: .main) {
               
            self.ResultsCollectionView.reloadData()
            self.eventCollectionView.reloadData()
            self.TeamsCollectionView.reloadData()
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
        
        
        
        
     
        if(test.count == 0){
            
            btn.setImage(UIImage(systemName:"star.fill"), for: .normal)
            btn.tintColor = .blue
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
                //leag.setValue(leagueINFO.lea, forKey: "leagueKey")
                leag.setValue(self.sportType, forKey: "sportType")
//                leag.setValue(teamkeyy.team_key, forKey: "teamKey")
                
                try managedContext.save()
                
            }catch let error as NSError{
                print(error)
            }
        }
        else{
            btn.setImage(UIImage(systemName:"star"), for: .normal)
            let commit = test[0]
                  //container.viewContext.delete(commit)
            managedContext.delete(commit)
                  //tableView.deleteRows(at: [indexPath], with: .fade)
            do{
                try managedContext.save()
                
            }catch let error as NSError{
                print(error)
            }
        }
        
    }

}
extension LeagueDetails :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.TeamsCollectionView{
            
            teamDetailsUrll =
            "https://apiv2.allsportsapi.com/\(sportType ?? "no title")/?&met=Teams&teamId=\(teams[indexPath.row].team_key ?? 63)&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
         
            let sender: [String: Any?] = ["elementNumber": indexPath.row]
            
            performSegue(withIdentifier: "teamDetail", sender: sender)
            
            
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  if let destanation = segue.destination as? TeamDetailViewController {
                      _ = sender as! [String: Any?]
                      
                      destanation.teamDetailsUrl = teamDetailsUrll

                              
                  }
              }
                
                
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
                cell.homeTeam.text = evntss.event_away_team 
                cell.awayTeam.text = evntss.event_home_team
                cell.date.text = evntss.event_date
                if sportType == "football"{
                    let homeimgurl = URL(string:evntss.home_team_logo ?? "3")
                    cell.homeimg?.kf.setImage(with:homeimgurl,placeholder: UIImage(named: "load"))
                    let awayimgurl = URL(string:evntss.away_team_logo ?? "3")
                    cell.awayimg?.kf.setImage(with:awayimgurl,placeholder: UIImage(named: "load"))
                }
                else{
                    let homeimgurl = URL(string:evntss.event_home_team_logo ?? "3")
                    cell.homeimg?.kf.setImage(with:homeimgurl,placeholder: UIImage(named: "load"))
                    let awayimgurl = URL(string:evntss.event_away_team_logo ?? "3")
                    cell.awayimg?.kf.setImage(with:awayimgurl,placeholder: UIImage(named: "load"))
                 
                }
                cell.backgroundColor = UIColor.white
                cell.time.text = evntss.event_time
                cell.layer.borderColor = UIColor.systemGray.cgColor
                 cell.layer.borderWidth = 3.0
                cell.layer.cornerRadius = 20.0
               
                return cell
            }
            
            else if collectionView === self.ResultsCollectionView{
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "result", for:indexPath)as! ResultsCollectionViewCell
                let resultmatch = results [indexPath.row]
                cell2.homeResult.text = resultmatch.event_home_team
                cell2.awayResult.text = resultmatch.event_away_team
                if sportType == "football"{
                    cell2.matchResults.text = resultmatch.event_final_result
                    let homeimgurl = URL(string:resultmatch.home_team_logo ?? "3")
                    cell2.homeImg?.kf.setImage(with:homeimgurl)
                    let awayimgurl = URL(string:resultmatch.away_team_logo ?? "3")
                    cell2.awayImg?.kf.setImage(with:awayimgurl)
                }
                else{
                    cell2.matchResults.text = resultmatch.event_final_result
                    let homeimgurl = URL(string:resultmatch.event_home_team_logo ?? "")
                    cell2.homeImg?.kf.setImage(with:homeimgurl,placeholder: UIImage(named: "load"))
                    let awayimgurl = URL(string:resultmatch.event_away_team_logo ?? "")
                    cell2.awayImg?.kf.setImage(with:awayimgurl,placeholder: UIImage(named: "load"))
                }
                cell2.layer.borderColor = UIColor.systemGray.cgColor
                 cell2.layer.borderWidth = 3.0
                cell2.layer.cornerRadius = 20.0
                
                return cell2
            }
            else{
                let cell13 = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
                cell13.configureLabel(with: teams[indexPath.row].team_name)
                cell13.configureImage(with: URL(string: teams[indexPath.row].team_logo ?? ""))
                cell13.backgroundColor = UIColor.clear
                return cell13
            }
        }
        
       
        
    }
    
    
    
extension LeagueDetails:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == TeamsCollectionView{
            return CGSize(width: self.view.frame.width*0.4, height: self.view.frame.height*0.18)

        }
        else if collectionView == eventCollectionView
        {
            return CGSize(width: self.view.frame.width*0.85, height: self.view.frame.height*0.18)

            
        }
        else if collectionView == ResultsCollectionView{
            return CGSize(width: self.view.frame.width*0.86, height: self.view.frame.height*0.16)
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
    




