//
//  SecondViewController.swift
//  SportApp
//
//  Created by Abdallah on 31/01/2023.
//

import UIKit
import Reachability
class SportViewController: UIViewController {
    
    var reachable : Reachability?
    var sprtArr = [Model]()
    var reach: Reachability?
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var SprtCollectionView: UICollectionView!
    

override func viewDidLoad() {
        super.viewDidLoad()
        SprtCollectionView.delegate = self
        SprtCollectionView.dataSource = self
        self.reachable = Reachability.forInternetConnection()

        appendSprtArr()
       
    }
}


extension SportViewController:UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if ((reachable!.isReachable()) ){
            print("item \(indexPath.row) tapped")
            print(sprtArr[indexPath.row].sprtname!)
            let url : String = "https://apiv2.allsportsapi.com/\(sprtArr[indexPath.row].sprtname!)/?met=Leagues&APIkey=4f903d8cf50564a86012b4a6deeed9acfd56ebab8249cf837ed48352096fc341"
            print(url)
            
            let leagueTable = self.storyboard?.instantiateViewController(withIdentifier: "sportTable") as! SportTableViewController
            
            leagueTable.leagueUrl = url
            leagueTable.category = self.sprtArr[indexPath.row].sprtname
            leagueTable.sportName = (self.sprtArr[indexPath.row].sprtname!)
            navigationController?.pushViewController(leagueTable, animated: true)
        }else{
            let alert = UIAlertController(title: "Internet Connection", message: "please chech your internet connection", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default,handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
        
    }
    
    
}



extension SportViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sprtArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath)as! SportsCollectionViewCell
        let sprt = sprtArr[indexPath.row]

        cell.sprtlabel.text = sprt.sprtname
        cell.sprtImg.image = sprt.sprtimg as UIImage
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as!SprtCollectionReusableView

        headerView.header.text = "Sports"
              return headerView
    }
    func appendSprtArr()
        {
            sprtArr.append(Model.init (sprtimg: UIImage(named: "1")!, sprtname: "football"))
            sprtArr.append(Model.init (sprtimg: UIImage(named: "2")!, sprtname: "basketball"))
            sprtArr.append(Model.init (sprtimg: UIImage(named: "3")!, sprtname: "cricket"))
            sprtArr.append(Model.init (sprtimg: UIImage(named: "4")!, sprtname: "tennis"))
//            sprtArr.append(Model.init (sprtimg: UIImage(named: "5")!, sprtname: "baseball"))
//            sprtArr.append(Model.init (sprtimg: UIImage(named: "6")!, sprtname: "americanfootball"))
            
        }
    
}



extension SportViewController:UICollectionViewDelegateFlowLayout

{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.499, height: self.view.frame.height*0.24)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width*0.1, height: self.view.frame.height*0.1)
    }
    
    
    
}

