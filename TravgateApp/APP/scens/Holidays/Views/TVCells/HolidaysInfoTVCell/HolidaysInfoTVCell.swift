//
//  HolidaysInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

class HolidaysInfoTVCell: UITableViewCell {
    
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    var cruiseKey = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        img.layer.cornerRadius = 6
        bottomView.addBlackGradient()
    }
    
}


extension UIView {
    func addBlackGradient() {
        // Create gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // Define colors
        let blackColorWithAlpha2 = UIColor.black.withAlphaComponent(0.0).cgColor
        let blackColorWithAlpha6 = UIColor.black.withAlphaComponent(0.2).cgColor
        
        // Set gradient colors
        gradientLayer.colors = [blackColorWithAlpha2, blackColorWithAlpha2, blackColorWithAlpha6, blackColorWithAlpha6]
        
        // Set gradient locations
        gradientLayer.locations = [0.0, 0.5, 0.5, 1.0]
        
        // Add gradient to view's layer
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

