//
//  HotelFareSummaryTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

class HotelFareSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var faresummeryView: UIView!
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotellocationlbl: UILabel!
    @IBOutlet weak var chickinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var roomlbl: UILabel!
    @IBOutlet weak var kedlbl: UILabel!
    @IBOutlet weak var checkboximg: UIImageView!
    
    
    
    var checkBool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        faresummeryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        faresummeryView.layer.cornerRadius = 8
    }
    
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        // checkboximg.image = UIImage(named: checkBool ? "check" : "uncheck")
        
        
        checkBool.toggle()
        if checkBool {
            checkboximg.image = UIImage(named: "check")
        }else {
            checkboximg.image = UIImage(named: "uncheck")
        }
    }
    
    
}
