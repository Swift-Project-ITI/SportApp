//
//  SportTableViewController.swift
//  SportApp
//
//  Created by Mahmoud on 03/02/2023.
//

import UIKit

class SportTableViewController: UIViewController {

    @IBOutlet weak var tView: UITableView!
    var viewModel : ViewModel!
    var leagueUrl : String?
    var myResult : [FootballLeague]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.configureImage(with: URL(string: (myResult?[indexPath.row].league_logo) ?? "2") )
        cell.configureLabel(with: (myResult![indexPath.row].league_name!))
        return cell
    }
    
    
}

