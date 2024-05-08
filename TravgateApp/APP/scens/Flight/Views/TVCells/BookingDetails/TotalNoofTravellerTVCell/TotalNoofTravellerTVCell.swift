//
//  TotalNoofTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 13/07/23.
//

import UIKit

class TotalNoofTravellerTVCell: TableViewCell {

    @IBOutlet weak var totalNoOfTravellerCountlbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalNoOfTravellerCountlbl.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            totalNoOfTravellerCountlbl.text = "No Of Traveller : \(cellInfo?.subTitle ?? "")"
        }
    }
    
}
