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
        img.layer.cornerRadius = 4
    }
    
}
