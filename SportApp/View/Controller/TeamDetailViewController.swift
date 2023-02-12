//
//  TeamDetailViewController.swift
//  SportApp
//
//  Created by Abdallah ismail on 12/02/2023.
//

import UIKit

class TeamDetailViewController: UIViewController {
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamCoach: UILabel!
    @IBOutlet weak var teamName: UILabel!
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var player :[Player] = []
    var detailModel: ViewModel?
    @IBOutlet weak var teamDetailCollection: UICollectionView!
    var teamDetailsUrl : String?
    
    var details : [TeamDetail] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        detailModel = ViewModel()
        teamDetailCollection.delegate = self
        teamDetailCollection.dataSource = self
      
    
        detailModel?.teamDetailsURL = self.teamDetailsUrl
        detailModel?.getTeamsdetails()
        detailModel?.detailsbindData = {()in
            self.renderAfterTeamdetails()
            
        }

        
    }
    
    func renderAfterTeamdetails(){
        DispatchQueue.main.async {
            self.details = self.detailModel?.detailsTeam ?? []
            self.player = (self.detailModel?.detailsTeam[self.player.count].players)!
            self.teamDetailCollection.reloadData()
            self.teamName.text =  self.detailModel?.detailsTeam[0].team_name
            self.teamCoach.text =  self.detailModel?.detailsTeam[0].coaches![0].coach_name
            let teamimg = URL(string:self.detailModel?.detailsTeam[0].team_logo ?? "https://apiv2.allsportsapi.com//logo//players//100288_diego-bri.jpg")
            self.teamLogo?.kf.setImage(with:teamimg)
        }
      
    }
}
extension TeamDetailViewController:UICollectionViewDelegate {
    
}
extension TeamDetailViewController :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailcell", for:indexPath)as! DetailsCollectionViewCell
        let detiliedteam = player [indexPath.row]
        cell.playerName.text =  detiliedteam.player_name
        cell.playerAge.text = detiliedteam.player_age
        cell.playerNumber.text = detiliedteam.player_number
        cell.playerPostion.text = detiliedteam.player_type
        let playerimg = URL(string:detiliedteam.player_image ?? "https://apiv2.allsportsapi.com//logo//players//100288_diego-bri.jpg")
        cell.playerImg?.kf.setImage(with:playerimg)
        return cell
    }

    
}



extension TeamDetailViewController: UICollectionViewDelegateFlowLayout

{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.499, height: self.view.frame.height*0.29)
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


