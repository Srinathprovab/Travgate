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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        totalNoOfTravellerCountlbl.text = "No Of Traveller : \(cellInfo?.subTitle ?? "")"
    }
    
}
