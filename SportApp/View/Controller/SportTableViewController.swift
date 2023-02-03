//
//  SportTableViewController.swift
//  SportApp
//
//  Created by Mahmoud on 03/02/2023.
//

import UIKit

class SportTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SportTableViewCell", bundle: nil)
    }
    


}
//extension SportTableViewController : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell
//    }
//    
//    
//}
extension SportTableViewController : UITableViewDelegate{
    
}

