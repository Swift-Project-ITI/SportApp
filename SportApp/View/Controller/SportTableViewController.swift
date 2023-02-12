//
//  SportTableViewController.swift
//  SportApp
//
//  Created by Mahmoud on 03/02/2023.
//

import UIKit
import Reachability
class SportTableViewController: UIViewController {

    @IBOutlet weak var tView: UITableView!
    var viewModel : ViewModel!
    var leagueUrl : String?
    var reachability : Reachability?
    var sportName : String?
    var myResult : [Leage]?
    var resultsUrl : String?
    var category : String?
    var urll : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = Reachability.forInternetConnection()
        let nib = UINib(nibName: "SportTableViewCell", bundle: nil)
        self.tView.register(nib, forCellReuseIdentifier:"cell")
        
        viewModel = ViewModel()
        viewModel.url = self.leagueUrl
        
        viewModel.getLeagues()
        viewModel.bindingData = {()in
            self.renderView()
        }
    }
    func renderView(){
        DispatchQueue.main.async {
            self.myResult = self.viewModel.result
            self.tView.reloadData()
        }
    }


}

extension SportTableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if ((reachability!.isReachable()) ){
            urll = "https://apiv2.allsportsapi.com/\(sportName!)/?met=Fixtures&leagueId=\(myResult![indexPath.row].league_key!)/&from=2022-03-07&to=2023-05-18&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
            print (urll)
            print ("hereeeeeee")
            resultsUrl = "https://apiv2.allsportsapi.com/\(sportName!)?met=Fixtures&leagueId=\(myResult![indexPath.row].league_key!)/&from=2022-8-18&to=2023-02-07&APIkey=3c13c72b777d982661628264e50d9126fcfcd2ccda7e07493df180cc93e6cc37"
            
            let sender: [String: Any?] = ["elementNumber": indexPath.row]
            //        tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "showDetail", sender: sender)
            
            
        }else{
            let alert = UIAlertController(title: "internet connection", message:"please cheack your internet connection" , preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destanation = segue.destination as? LeagueDetails {
          let object = sender as! [String: Any?]
            
            destanation.leagueINFO = myResult![object["elementNumber"] as! Int]
            destanation.DetailsUrl = urll
            destanation.ResultsUrls = resultsUrl
            destanation.sportType = self.category
            destanation.leagueId = myResult![object["elementNumber"] as! Int].league_key
                    
        }
    }
    
}
extension SportTableViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResult?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SportTableViewCell
        cell.configureImage(with: URL(string: (myResult?[indexPath.row].league_logo) ?? "") )
        cell.configureLabel(with: (myResult![indexPath.row].league_name!))
        return cell
        }
    
    
}

