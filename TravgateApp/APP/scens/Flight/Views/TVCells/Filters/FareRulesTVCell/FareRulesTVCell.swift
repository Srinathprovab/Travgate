//
//  FareRulesTVCell.swift
//  Travgate
//
//  Created by FCI on 14/02/24.
//

import UIKit

class FareRulesTVCell: TableViewCell {

    
    
    @IBOutlet weak var infoView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        if cellInfo?.key == "show" {
            infoView.isHidden = false
        }else {
            infoView.isHidden = true
        }
    }
    
}
