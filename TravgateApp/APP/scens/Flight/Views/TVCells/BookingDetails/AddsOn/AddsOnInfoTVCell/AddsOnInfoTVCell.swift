//
//  AddsOnInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 22/02/24.
//

import UIKit

class AddsOnInfoTVCell: UITableViewCell {

    
    @IBOutlet weak var addonLogo: UIImageView!
    @IBOutlet weak var checkimg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
