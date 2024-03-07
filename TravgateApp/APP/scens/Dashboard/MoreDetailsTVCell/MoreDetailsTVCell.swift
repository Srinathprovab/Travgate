//
//  MoreDetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import UIKit

class MoreDetailsTVCell: TableViewCell {

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
        titlelbl.attributedText = MySingleton.shared.moreDetailsData?.page_description?.htmlToAttributedString
    }
    
}
