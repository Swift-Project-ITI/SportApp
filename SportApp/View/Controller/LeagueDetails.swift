//
//  LeagueDetails.swift
//  SportApp
//
//  Created by Abdallah ismail on 06/02/2023.
//

import UIKit
import Kingfisher
class LeagueDetails: UIViewController {

    @IBOutlet weak var ResultsCollectionView: UICollectionView!

    @IBOutlet weak var eventCollectionView: UICollectionView!
    var evntModel: ViewModel!
    var DetailsUrl : String?
    var ResultsUrls : String?
    var results : [Results] = []
    var evnts : [Events] = []
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

     ResultsCollectionView.delegate = self
     ResultsCollectionView.dataSource = self
//     eventCollectionView.delegate = self
//     eventCollectionView.dataSource = self
        evntModel = ViewModel()
        evntModel.EventUrl = self.DetailsUrl
        evntModel.ResultUrl = self.ResultsUrls
        evntModel.getEvents()
        evntModel.getResults()
        evntModel.evntbindData = {()in
        self.renderVieww()
        
            }
        evntModel.resultbindData = {()in
        self.renderViewresult()
        
            }
    }
    
    func renderVieww(){
        DispatchQueue.main.async {
            self.evnts = self.evntModel.Evnts
            self.eventCollectionView.reloadData()
         
        }
    }
    
    
    func renderViewresult(){
        DispatchQueue.main.async {
          
            self.results = self.evntModel.evntResult
            self.ResultsCollectionView.reloadData()
         
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
         } else {
             return results.count
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

          else {
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
    }
    

    
}



extension LeagueDetails:UICollectionViewDelegateFlowLayout

{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.8, height: self.view.frame.height*0.2)
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


