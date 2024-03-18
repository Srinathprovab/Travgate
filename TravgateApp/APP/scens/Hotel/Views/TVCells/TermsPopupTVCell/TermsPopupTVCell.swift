//
//  TermsPopupTVCell.swift
//  Travgate
//
//  Created by FCI on 14/03/24.
//

import UIKit

class TermsPopupTVCell: TableViewCell {
    
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
        subtitlelbl.text = cellInfo?.subTitle ?? ""
    }
    
}
