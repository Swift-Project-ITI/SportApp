//
//  FaviroteViewController.swift
//  SportApp
//
//  Created by Mahmoud on 31/01/2023.
//

import UIKit
import CoreData

class FaviroteViewController: UIViewController {
    var leagues : [NSManagedObject] = []
    var resultsUrl : String?
    var category : String?
    var urll : String?
    var teamsurl: String?
    var teamDetailsUrll : String?
    @IBOutlet weak var tview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       let nib = UINib(nibName: "SportTableViewCell", bundle: nil)
        tview.register(nib, forCellReuseIdentifier: "cell")
        tview.backgroundColor = UIColor.black
        self.tview.separatorInset = UIEdgeInsets.zero
        self.tview.separatorColor = UIColor.systemGray
    }
    override func viewWillAppear(_ animated: Bool) {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "LeagueClass")
        //4
       
        do{
            leagues = try managedContext.fetch(fetchRequest)
            self.tview.reloadData()
            
            for item in leagues{
                print(item.value(forKey: "leagueName") ?? "hhh")}
        }catch let error as NSError{
            print(error)
        }
        self.tview.reloadData()
    }

}
extension FaviroteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        //3
        let fetchRequest = NSFetchRequest <NSManagedObject> (entityName: "LeagueClass")
        if (editingStyle == .delete) {
            print(leagues.count)
            print(indexPath.row)
            let alert = UIAlertController(title: "comfirm", message: "are you sure", preferredStyle: .alert)
            let ok = UIAlertAction(title: "YES", style: .default) { _ in
                
                _ = self.leagues[indexPath.row]
                      //container.viewContext.delete(commit)
                managedContext.delete(self.leagues[indexPath.row])
                      //tableView.deleteRows(at: [indexPath], with: .fade)
                do{
                    try managedContext.save()
                    
                }catch let error as NSError{
                    print(error)
                }
                do{
                    self.leagues = try managedContext.fetch(fetchRequest)
                }
                catch let error as NSError{
                    print(error)
                }
                self.tview.reloadData()
            }
            let cancel = UIAlertAction(title: "cancel", style: .cancel,handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true)
           }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let leguekey =  leagues[indexPath.row].value(forKey: "leagueKey") as? Int
        let sportname =  leagues[indexPath.row].value(forKey: "sportType") as? String
      //  let teamId =  leagues[indexPath.row].value(forKey: "teamId") as? Int
//        let teamkey =  leagues[indexPath.row].value(forKey: "teamKey") as? Int
        urll = "https://apiv2.allsportsapi.com/\(sportname!)/?met=Fixtures&leagueId=\(leguekey!)/&from=2022-03-07&to=2023-05-18&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"

        resultsUrl = "https://apiv2.allsportsapi.com/\(sportname!)?met=Fixtures&leagueId=\(leguekey ?? 0)/&from=2022-8-18&to=2023-02-07&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
        resultsUrl = "https://apiv2.allsportsapi.com/\(sportname!)?met=Fixtures&leagueId=\(leguekey ?? 0)/&from=2022-8-18&to=2023-02-07&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
        teamsurl = "https://apiv2.allsportsapi.com/\(sportname!)/?met=Teams&?met=Leagues&leagueId=\(leguekey ?? 0)&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
        
        teamDetailsUrll =
        "https://apiv2.allsportsapi.com/\(sportname ?? "")/?&met=Teams&teamId=\( 60)&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
        let sender: [String: Any?] = ["elementNumber": indexPath.row,"resultUrl":resultsUrl!,"sportType" : sportname]
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "favourite", sender: sender)
        
        
     
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destanation = segue.destination as? LeagueDetails {
          let object = sender as! [String: Any?]
            print((object["resultUrl"] as? String)!)
            destanation.DetailsUrl = urll
            destanation.ResultsUrls = resultsUrl
            destanation.sportType = (object["sportType"] as? String)!
            destanation.teamsUrl = teamsurl
            destanation.teamDetailsUrll = self.teamDetailsUrll
          
                    
        }
    }
}
extension FaviroteViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SportTableViewCell
        if leagues.count > 0
        {
            cell.configureLabel(with: leagues[indexPath.row].value(forKey: "leagueName") as? String)
//            print(leagues[indexPath.row].value(forKey: "leagueLogo") as? String)
            let data = (leagues[indexPath.row].value(forKey: "leagueLogo") as? String) ?? ""
            
            print(data)
            cell.configureImage(with: URL(string: data))
        }
        return cell
    }
    
    
    
    
}

