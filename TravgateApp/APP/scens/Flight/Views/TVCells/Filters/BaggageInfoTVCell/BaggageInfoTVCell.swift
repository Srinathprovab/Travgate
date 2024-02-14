//
//  BaggageInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 14/02/24.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    
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
    }
    
}
