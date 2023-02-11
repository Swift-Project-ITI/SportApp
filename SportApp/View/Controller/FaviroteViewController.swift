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
    @IBOutlet weak var tview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       let nib = UINib(nibName: "SportTableViewCell", bundle: nil)
        tview.register(nib, forCellReuseIdentifier: "cell")
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
            
            
            let commit = leagues[indexPath.row]
                  //container.viewContext.delete(commit)
            managedContext.delete(leagues[indexPath.row])
                  //tableView.deleteRows(at: [indexPath], with: .fade)
            do{
                try managedContext.save()
                
            }catch let error as NSError{
                print(error)
            }
            
            tview.reloadData()
           }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
            print(leagues[indexPath.row].value(forKey: "leagueLogo") as? String)
            let data = (leagues[indexPath.row].value(forKey: "leagueLogo") as? String) ?? ""
            
            print(data)
            cell.configureImage(with: URL(string: data))
        }
        return cell
    }
    
    
    
    
}

