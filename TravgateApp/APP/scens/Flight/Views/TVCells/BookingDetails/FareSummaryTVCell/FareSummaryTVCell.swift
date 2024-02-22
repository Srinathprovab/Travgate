//
//  FareSummaryTVCell.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import UIKit

class FareSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var adultView: UIView!
    @IBOutlet weak var adultfare: UILabel!
    @IBOutlet weak var adulttax: UILabel!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var childfare: UILabel!
    @IBOutlet weak var childtax: UILabel!
    @IBOutlet weak var infantview: UIView!
    @IBOutlet weak var infantfare: UILabel!
    @IBOutlet weak var infanttax: UILabel!
    @IBOutlet weak var adultValuelbl: UILabel!
    @IBOutlet weak var childValuelbl: UILabel!
    @IBOutlet weak var infantValuelbl: UILabel!
    @IBOutlet weak var adultPasslbl: UILabel!
    @IBOutlet weak var childPasslbl: UILabel!
    @IBOutlet weak var infantPasslbl: UILabel!
    @IBOutlet weak var check1img: UIImageView!
    @IBOutlet weak var check2img: UIImageView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var addonValue: UILabel!
    
    var check1bool = false
    var check2bool = false
    var totalkwdvalue: Decimal = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        topview.layer.cornerRadius = 8
        topview.clipsToBounds = true

    }
    
    
    override func updateUI() {
        
        
        adultPasslbl.text = "Traveller x\(MySingleton.shared.adultsCount) Adult"
        childPasslbl.text = "Traveller x\(MySingleton.shared.childCount) Child"
        infantPasslbl.text = "Traveller x\(MySingleton.shared.infantsCount) Infant"
        
        adultValuelbl.text = "\(MySingleton.shared.mpbpriceDetails?.api_currency ?? ""):\(MySingleton.shared.mpbpriceDetails?.adultsTotalPrice ?? "")"
        adultfare.text = "\(MySingleton.shared.mpbpriceDetails?.adultsBasePrice ?? "")"
        adulttax.text = "\(MySingleton.shared.mpbpriceDetails?.adultsTaxPrice ?? "")"
        
        childValuelbl.text = "\(MySingleton.shared.mpbpriceDetails?.api_currency ?? ""):\(MySingleton.shared.mpbpriceDetails?.childTotalPrice ?? "")"
        childfare.text = "\(MySingleton.shared.mpbpriceDetails?.childBasePrice ?? "")"
        childtax.text = "\(MySingleton.shared.mpbpriceDetails?.childTaxPrice ?? "")"
        
        infantValuelbl.text = "\(MySingleton.shared.mpbpriceDetails?.api_currency ?? ""):\(MySingleton.shared.mpbpriceDetails?.infantTotalPrice ?? "")"
        infantfare.text = "\(MySingleton.shared.mpbpriceDetails?.infantBasePrice ?? "")"
        infanttax.text = "\(MySingleton.shared.mpbpriceDetails?.infantTaxPrice ?? "")"
        totalAmount.text = "\(MySingleton.shared.mpbpriceDetails?.api_currency ?? ""):\(MySingleton.shared.mpbpriceDetails?.grand_total ?? "")"
        
        if MySingleton.shared.childCount == 0 {
            hide(v: childView)
        }else {
            show(v: childView)
        }
        
        if MySingleton.shared.infantsCount == 0 {
            hide(v: infantview)
        }else {
            show(v: infantview)
        }
        
        
        if MySingleton.shared.addonSelectedArray.count > 0 {
            addonView.isHidden = false
        }else {
            addonView.isHidden = true
            totalkwdvalue = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(addon(_:)), name: NSNotification.Name("addon"), object: nil)
    }
    
   

    @objc func addon(_ ns: NSNotification) {
        
        totalkwdvalue = Decimal(MySingleton.shared.selectedAddonTotalPrice)
        addonValue.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""): \(totalkwdvalue)"
    }
    
    
    func hide(v:UIView){
        v.isHidden = true
    }
    
    func show(v:UIView) {
        v.isHidden = false
    }
    
    
    @IBAction func didTapOnMultipleOperatoreBtnAction(_ sender: Any) {
        check1bool.toggle()
        if check1bool {
            check1img.image = UIImage(named: "check")
        }else {
            check1img.image = UIImage(named: "uncheck")
        }
    }
    
    @IBAction func didTapOnPaymentCeheckBoxBtnAction(_ sender: Any) {
        check2bool.toggle()
        if check2bool {
            check2img.image = UIImage(named: "check")
        }else {
            check2img.image = UIImage(named: "uncheck")
        }
    }
    
}
