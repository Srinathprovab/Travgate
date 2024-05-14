//
//  PriceSummaryTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

protocol PriceSummaryTVCellDelegate {
    func didTapOnRemoveTravelInsuranceBtn(cell:PriceSummaryTVCell)
    func didTapOnRemovePromoCodeBtnAction(cell:PriceSummaryTVCell)
}

class PriceSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var flexibleView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var whatsAppView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var flexiblePriceLbl: UILabel!
    @IBOutlet weak var whatsAppPriceLbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var psImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tvHolderView: UIView!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var totalPaymentlbl: UILabel!
    @IBOutlet weak var totalPaymentValuelbl: UILabel!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var travellerAdultTV: UITableView!
    @IBOutlet weak var promoview: UIView!
    
    var delegate:PriceSummaryTVCellDelegate?
    var key = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
        addonView.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        if whatsAppCheck == true {
            whatsAppView.isHidden = false
        } else {
            whatsAppView.isHidden = true
        }
        
        if priceCheck == true {
            priceView.isHidden = false
        } else {
            priceView.isHidden = true
        }
        
        if notificationCheck == true {
            notificationView.isHidden = false
        } else {
            notificationView.isHidden = true
        }
        
        if flexibleCheck == true {
            flexibleView.isHidden = false
        } else {
            flexibleView.isHidden = true
        }
        
        
        if whatsAppCheck == false && priceCheck  == false && notificationCheck  == false && flexibleCheck  == false {
            addonView.isHidden = true
        } else {
            addonView.isHidden = false
        }
        
        
        self.key =  cellInfo?.key ?? ""
        MySingleton.shared.setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                             str2: String(cellInfo?.covetedAmnt ?? 0.00),
                             lbl: totalPaymentValuelbl,
                             str1font: .OpenSansMedium(size: 14),
                             str2font: .InterBold(size: 20),
                             str1Color: .AppLabelColor,
                             str2Color: .AppLabelColor)
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
            
            if selectedTab == "Flight" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        
                        
                    } else if journeyType == "circle"{
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    } else {
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }
                }
                
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
                
            }
        }
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0{
            tvheight.constant = 115
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0{
            tvheight.constant = 115 * 2
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0{
            tvheight.constant = 115 * 2
        }else {
            tvheight.constant = 115 * 3
        }
        
        
        if MySingleton.shared.promocodebool == true {
            promoview.isHidden = false
        }else {
            promoview.isHidden = true
        }
        
    }
    
    func setupUI(){
    
        whatsAppPriceLbl.text =  "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(whatsAppPrice)"
        flexiblePriceLbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(flexiblePrie)"
        notificationLabel.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(notificationPrice)"
        priceChangeLabel.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(priceChange)"
        setupViews(v: holderView, radius: 8, color: .WhiteColor)
        setupViews(v: ulView, radius: 0, color: .clear)
        setupLabels(lbl: titlelbl, text: "   Fare Summary", textcolor: .white, font: .InterSemiBold(size: 18))
        setupLabels(lbl: totalPaymentlbl, text: "Total Amount", textcolor: HexColor("#515151"), font: .InterMedium(size: 16))
      
        flexibleAmount = Int(flexiblePrie) ?? 0
        whatsAppAmount = Int(whatsAppPrice) ?? 0
        priceChangeAmount = Int(priceChange) ?? 0
        notificationAmount = Int(notificationPrice) ?? 0
        
        addonAmount = flexibleAmount + whatsAppAmount + priceChangeAmount + notificationAmount
        
        
    }
    
    func setupTV() {
        tvheight.constant = 342
        let nib = UINib(nibName: "TravellerAdultTVCell", bundle: nil)
        travellerAdultTV.register(nib, forCellReuseIdentifier: "cell")
        travellerAdultTV.delegate = self
        travellerAdultTV.dataSource = self
        travellerAdultTV.isScrollEnabled = false
        travellerAdultTV.showsHorizontalScrollIndicator = false
        travellerAdultTV.tableFooterView = UIView()
        travellerAdultTV.separatorStyle = .none
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @IBAction func didTapOnRemovePromoCodeBtnAction(_ sender: Any) {
        delegate?.didTapOnRemovePromoCodeBtnAction(cell: self)
    }
    
}


extension PriceSummaryTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0{
            return 1
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0{
            return 2
        }else if adultsCount > 0 && childCount == 0 && infantsCount > 0{
            return 2
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TravellerAdultTVCell {
            cell.selectionStyle = .none
            
            
            if indexPath.row == 0 {
                cell.adultCountlbl.text = "Traveller x \(adultsCount)(Adult)"
//                cell.adultKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")  \(AdultsTotalPrice)"
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: (AdultsTotalPrice),
                                     lbl: cell.adultKWDlbl,
                                     str1font: .InterSemiBold(size: 14),
                                     str2font: .InterSemiBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: (Adults_Base_Price),
                                     lbl: cell.fareKWDlbl,
                                     str1font: .InterSemiBold(size: 12),
                                     str2font: .InterSemiBold(size: 14),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2:(Adults_Tax_Price),
                                     lbl: cell.taxesKWDlbl,
                                     str1font: .InterSemiBold(size: 12),
                                     str2font: .InterSemiBold(size: 14),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
            }else if indexPath.row == 1 {
               
                 if adultsCount > 0 && childCount > 0 && infantsCount == 0{
                     cell.adultCountlbl.text = "Traveller x \(childCount)(Child)"
                     
                     setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                          str2: (ChildTotalPrice),
                                          lbl: cell.adultKWDlbl,
                                          str1font: .InterSemiBold(size: 14),
                                          str2font: .InterSemiBold(size: 16),
                                          str1Color: .AppLabelColor,
                                          str2Color: .AppLabelColor)
//                     
                     setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                          str2:(Childs_Base_Price),
                                          lbl: cell.fareKWDlbl,
                                          str1font: .InterSemiBold(size: 12),
                                          str2font: .InterSemiBold(size: 14),
                                          str1Color: .AppLabelColor,
                                          str2Color: .AppLabelColor)
                     
                     
                     setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                          str2: Childs_Tax_Price,
                                          lbl: cell.taxesKWDlbl,
                                          str1font: .InterSemiBold(size: 12),
                                          str2font: .InterSemiBold(size: 14),
                                          str1Color: .AppLabelColor,
                                          str2Color: .AppLabelColor)
                     
                     
                    
                }else if adultsCount > 0 && childCount == 0 && infantsCount > 0{
                    
                    cell.adultCountlbl.text = "Traveller x \(infantsCount)(Infant)"
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: InfantTotalPrice,
                                         lbl: cell.adultKWDlbl,
                                         str1font: .InterSemiBold(size: 14),
                                         str2font: .InterSemiBold(size: 16),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: Infants_Base_Price,
                                         lbl: cell.fareKWDlbl,
                                         str1font: .InterSemiBold(size: 12),
                                         str2font: .InterSemiBold(size: 14),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                    
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: Infants_Tax_Price,
                                         lbl: cell.taxesKWDlbl,
                                         str1font: .InterSemiBold(size: 12),
                                         str2font: .InterSemiBold(size: 14),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                }else {
                    cell.adultCountlbl.text = "Traveller x \(childCount)(Child)"
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: String(format: "%.2f", Double(ChildTotalPrice) ?? 0.0),
                                         lbl: cell.adultKWDlbl,
                                         str1font: .InterSemiBold(size: 12),
                                         str2font: .InterSemiBold(size: 14),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: String(format: "%.2f", Double(Childs_Base_Price) ?? 0.0),
                                         lbl: cell.fareKWDlbl,
                                         str1font: .InterSemiBold(size: 12),
                                         str2font: .InterSemiBold(size: 14),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                    
                    
                    setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                         str2: String(format: "%.2f", Double(Childs_Tax_Price) ?? 0.0),
                                         lbl: cell.taxesKWDlbl,
                                         str1font: .InterSemiBold(size: 12),
                                         str2font: .InterSemiBold(size: 14),
                                         str1Color: .AppLabelColor,
                                         str2Color: .AppLabelColor)
                    
                    
                }
               
            }else {
                cell.adultCountlbl.text = "Traveller x \(infantsCount)(Infant)"
               
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(InfantTotalPrice) ?? 0.0),
                                     lbl: cell.adultKWDlbl,
                                     str1font: .InterSemiBold(size: 14),
                                     str2font: .InterSemiBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Infants_Base_Price) ?? 0.0),
                                     lbl: cell.fareKWDlbl,
                                     str1font: .InterSemiBold(size: 12),
                                     str2font: .InterSemiBold(size: 14),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Infants_Tax_Price) ?? 0.0),
                                     lbl: cell.taxesKWDlbl,
                                     str1font: .InterSemiBold(size: 12),
                                     str2font: .InterSemiBold(size: 14),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
            }
            
            
            
            if self.key == "hotel"  {
                cell.farelbl.text = ""
                cell.fareKWDlbl.text = ""
            } else {
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                      NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
}
