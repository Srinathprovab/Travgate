//
//  TopcityGuidesCVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class TopcityGuidesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
    }

}
