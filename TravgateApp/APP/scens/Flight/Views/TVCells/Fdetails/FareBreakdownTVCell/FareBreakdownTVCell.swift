//
//  FareBreakdownTVCell.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import UIKit

class FareBreakdownTVCell: TableViewCell {
    
    @IBOutlet weak var adultBasepricelbl: UILabel!
    @IBOutlet weak var childBasepricelbl: UILabel!
    @IBOutlet weak var infantBasepricelbl: UILabel!
    @IBOutlet weak var adulttaxlbl: UILabel!
    @IBOutlet weak var childtaxlbl: UILabel!
    @IBOutlet weak var infanttaxlbl: UILabel!
    @IBOutlet weak var adultTotalpricelbl: UILabel!
    @IBOutlet weak var childTotalpricelbl: UILabel!
    @IBOutlet weak var infanTotalpricelbl: UILabel!
    @IBOutlet weak var adultPassengersbl: UILabel!
    @IBOutlet weak var childPassengerslbl: UILabel!
    @IBOutlet weak var infanPassengerslbl: UILabel!
    @IBOutlet weak var adultSubTotalpricelbl: UILabel!
    @IBOutlet weak var childSubTotalpricelbl: UILabel!
    @IBOutlet weak var infanSubTotalpricelbl: UILabel!
    
    @IBOutlet weak var adultView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var infantView: UIView!
    @IBOutlet weak var adultBasepriceView: UIView!
    @IBOutlet weak var childBasepriceView: UIView!
    @IBOutlet weak var infantBasepriceView: UIView!
    @IBOutlet weak var adulttaxlView: UIView!
    @IBOutlet weak var childtaxView: UIView!
    @IBOutlet weak var infanttaxView: UIView!
    @IBOutlet weak var adultTotalpriceView: UIView!
    @IBOutlet weak var childTotalpriceView: UIView!
    @IBOutlet weak var infanTotalpriceView: UIView!
    @IBOutlet weak var adultPassengersView: UIView!
    @IBOutlet weak var childPassengersView: UIView!
    @IBOutlet weak var infantPassView: UIView!
    @IBOutlet weak var adultSubTotalpriceView: UIView!
    @IBOutlet weak var childSubTotalpriceView: UIView!
    @IBOutlet weak var infanSubTotalpriceView: UIView!
    
    @IBOutlet weak var totalDiscountlbl: UILabel!
    @IBOutlet weak var totalAfterDiscountlbl: UILabel!
    @IBOutlet weak var totalTripCostlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        totalDiscountlbl.text = "\(MySingleton.shared.flightPriceDetails?.api_currency ?? ""):\(MySingleton.shared.flightPriceDetails?.admin_discount ?? "")"
        totalAfterDiscountlbl.text = "\(MySingleton.shared.flightPriceDetails?.api_currency ?? ""):\(MySingleton.shared.flightPriceDetails?.grand_total ?? "")"
        totalTripCostlbl.text = "\(MySingleton.shared.flightPriceDetails?.api_currency ?? ""):\(MySingleton.shared.flightPriceDetails?.grand_total ?? "")"
        
        showlbl(lbl: adultBasepricelbl, value:  MySingleton.shared.flightPriceDetails?.adultsBasePrice ?? "", v: adultBasepriceView)
        showlbl(lbl: adulttaxlbl, value:  MySingleton.shared.flightPriceDetails?.adultsTaxPrice ?? "", v: adulttaxlView)
        showlbl(lbl: adultTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.adultsTotalPrice ?? "", v: adultTotalpriceView)
        showlbl(lbl: adultPassengersbl, value:  "X \(MySingleton.shared.adultsCount)", v: adultPassengersView)
        showlbl(lbl: adultSubTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.sub_total_adult ?? "", v: adultSubTotalpriceView)
        
        
        if MySingleton.shared.childCount == 0 {
            hidelbl(v: childView)
            hidelbl(v: childBasepriceView)
            hidelbl(v: childtaxView)
            hidelbl(v: childTotalpriceView)
            hidelbl(v: childPassengersView)
            hidelbl(v: childSubTotalpriceView)
        }else {
            showlbl(lbl: childBasepricelbl, value:  MySingleton.shared.flightPriceDetails?.childBasePrice ?? "", v: childBasepriceView)
            showlbl(lbl: childtaxlbl, value:  MySingleton.shared.flightPriceDetails?.childTaxPrice ?? "", v: childtaxView)
            showlbl(lbl: childTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.childTotalPrice ?? "", v: childSubTotalpriceView)
            showlbl(lbl: childPassengerslbl, value:  "X \(MySingleton.shared.childCount)", v: childPassengersView)
            showlbl(lbl: childSubTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.sub_total_child ?? "", v: childSubTotalpriceView)
        }
        
        if MySingleton.shared.infantsCount == 0 {
            hidelbl(v: infantView)
            hidelbl(v: infantBasepriceView)
            hidelbl(v: infanttaxView)
            hidelbl(v: infanTotalpriceView)
            hidelbl(v: infantPassView)
            hidelbl(v: infanSubTotalpriceView)
        }else {
            showlbl(lbl: infantBasepricelbl, value:  MySingleton.shared.flightPriceDetails?.infantBasePrice ?? "", v: infantBasepriceView)
            showlbl(lbl: infanttaxlbl, value:  MySingleton.shared.flightPriceDetails?.infantTaxPrice ?? "", v: infanttaxView)
            showlbl(lbl: infanTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.infantTotalPrice ?? "", v: infanTotalpriceView)
            showlbl(lbl: infanPassengerslbl, value:  "X \(MySingleton.shared.infantsCount)", v: infantPassView)
            showlbl(lbl: infanSubTotalpricelbl, value:  MySingleton.shared.flightPriceDetails?.sub_total_infant ?? "", v: infanSubTotalpriceView)
        }
        
    }
    
    
    
    
    
    func hidelbl(v:UIView) {
        v.isHidden = true
    }
    
    func showlbl(lbl:UILabel,value:String,v:UIView) {
        v.isHidden = false
        lbl.text = value
    }
    
    
    
    
    
}
