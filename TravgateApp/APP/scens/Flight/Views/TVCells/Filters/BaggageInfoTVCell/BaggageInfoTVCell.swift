//
//  BaggageInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 14/02/24.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cityslbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
       
        
        if cellInfo?.title == "0" {
            titlelbl.text = "Departure"
        }else {
            titlelbl.text = "Return"
        }
        
        
        cityslbl.text = cellInfo?.subTitle ?? ""
    }
    
}
