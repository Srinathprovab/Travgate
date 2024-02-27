//
//  HolidaysImagesCVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

class HolidaysImagesCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = 4
    }

}
