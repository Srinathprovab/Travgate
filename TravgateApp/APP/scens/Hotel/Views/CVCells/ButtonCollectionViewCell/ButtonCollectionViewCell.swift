//
//  ButtonCollectionViewCell.swift
//  Travgate
//
//  Created by FCI on 18/03/24.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = 8
        moreBtn.layer.cornerRadius = 8
        
    }

}
