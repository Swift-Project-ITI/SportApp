//
//  SportTableViewCell.swift
//  SportApp
//
//  Created by Mahmoud on 03/02/2023.
//

import UIKit
import Kingfisher
class SportTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func configureImage(with image: URL?)
    {
        //img.image = image
        leagueImage.layer.cornerRadius = leagueImage.bounds.height / 2
        leagueImage.layer.borderWidth = 2
        leagueImage.clipsToBounds = false
        leagueImage.layer.masksToBounds = true
        leagueImage.kf.setImage(with: image,placeholder: UIImage(named: "load"))
    }
    func configureLabel(with lab: String?)
    {
        //img.image = image
        self.leagueLabel.text = lab
    }
}
