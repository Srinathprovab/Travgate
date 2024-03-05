//
//  ImportentInfoSubTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 27/11/23.
//

import UIKit

class ImportentInfoSubTableViewCell: UITableViewCell {

    
    @IBOutlet weak var departurelbl: UILabel!
    
    @IBOutlet weak var baggarelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    
    @IBOutlet weak var classlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
