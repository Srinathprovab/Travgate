//
//  AddUpcomingInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 08/03/24.
//

import UIKit

class AddUpcomingInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
