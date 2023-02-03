//
//  SecondViewController.swift
//  SportApp
//
//  Created by Mahmoud on 31/01/2023.
//

import UIKit

class SportViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    
    var sprtArr = [Model]()
    
    
    
    @IBOutlet weak var header: UILabel!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sprtArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath)as! SportsCollectionViewCell
        let sprt = sprtArr[indexPath.row]
//        cell.sprtImg = sprt.sprtimg
        cell.sprtlabel.text = sprt.sprtname
        cell.backgroundColor = UIColor.black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.495, height: self.view.frame.height*0.2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width*0.1, height: self.view.frame.height*0.1)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as!SprtCollectionReusableView

        headerView.header.text = "Sports"
              return headerView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        SprtCollectionView.delegate = self
        SprtCollectionView.dataSource = self
        
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
        sprtArr.append(Model(sprtimg: "1", sprtname: "football"))
        sprtArr.append(Model(sprtimg: "3", sprtname: "Basketball"))
      
    }
    @IBOutlet weak var SprtCollectionView: UICollectionView!
    

 

}
