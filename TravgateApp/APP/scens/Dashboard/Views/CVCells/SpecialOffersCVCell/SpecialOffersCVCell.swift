//
//  SpecialOffersCVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class SpecialOffersCVCell: UICollectionViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var codelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
    }

}
