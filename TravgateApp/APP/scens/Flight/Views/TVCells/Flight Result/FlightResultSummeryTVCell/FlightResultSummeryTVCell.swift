//
//  FlightResultSummeryTVCell.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightResultSummeryTVCell: UITableViewCell {

    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var luggagelbl: UILabel!
    @IBOutlet weak var worklbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var baggageView: UIStackView!
    @IBOutlet weak var flightDetailsTapBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
