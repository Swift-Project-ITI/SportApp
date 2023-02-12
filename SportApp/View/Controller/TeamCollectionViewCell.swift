//
//  TeamCollectionViewCell.swift
//  SportApp
//
//  Created by Mahmoud on 08/02/2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var TeamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureImage(with image: URL?)
    {
        //img.image = image
//        teamImage.layer.cornerRadius = teamImage.bounds.height / 2
//        teamImage.layer.borderWidth = 2
//        teamImage.clipsToBounds = false
//        teamImage.layer.masksToBounds = true
        teamImage.kf.setImage(with: image,placeholder: UIImage(named: "2"))
    }
    func configureLabel(with lab: String?)
    {
        //img.image = image
        self.TeamName.text = lab
    }
}
