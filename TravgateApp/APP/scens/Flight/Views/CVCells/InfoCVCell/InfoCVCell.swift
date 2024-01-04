//
//  InfoCVCell.swift
//  TravgateApp
//
//  Created by FCI on 04/01/24.
//

import UIKit

class InfoCVCell: UICollectionViewCell {

    @IBOutlet weak var checkimg: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)

    }

}
