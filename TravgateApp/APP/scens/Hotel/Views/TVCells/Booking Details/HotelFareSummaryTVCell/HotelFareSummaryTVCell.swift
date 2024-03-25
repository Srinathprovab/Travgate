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
    @IBOutlet weak var kwdpricelbl: UILabel!
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
    
    
    override func updateUI() {
        hotelnamelbl.text = MySingleton.shared.roompaxesdetails[0].room_name
        chickinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin)
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout)
        roomlbl.text = "\(MySingleton.shared.roompaxesdetails[0].no_of_rooms ?? 0)"
        let pricewithcurrency = MySingleton.shared.roompaxesdetails[0].net
        
        
        MySingleton.shared.setAttributedTextnew(str1: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "",
                                                str2: "\(String(format: "%.2f", Double(pricewithcurrency ?? "0.0") ?? 0.0))" ,
                                                lbl: kwdpricelbl,
                                                str1font: .LatoBold(size: 12),
                                                str2font: .LatoBold(size: 18),
                                                str1Color: .AppBtnColor,
                                                str2Color: .AppBtnColor)
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
            MySingleton.shared.checkTermsAndCondationStatus = true
        }else {
            checkboximg.image = UIImage(named: "uncheck")
            MySingleton.shared.checkTermsAndCondationStatus = false
        }
    }
    
    
}
