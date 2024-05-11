//
//  PremiumInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

class PremiumInfoTVCell: TableViewCell {

    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        subtitlelbl.text = cellInfo?.subTitle ?? ""
    }
    
}
