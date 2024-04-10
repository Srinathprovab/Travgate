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
    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var addonView: UIView!
    @IBOutlet weak var addonValue: UILabel!
    @IBOutlet weak var addonView1: UIView!
    @IBOutlet weak var addonserviceTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
   
   
    var afteraddontotalamount : Decimal = 0
    
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
        setupTV()
        topview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        topview.layer.cornerRadius = 8
        topview.clipsToBounds = true
        
        let grandTotalString = MySingleton.shared.mpbpriceDetails?.grand_total ?? ""
        let grandTotalDecimal = Decimal(string: grandTotalString) ?? Decimal(0.0)

        updateTotalAmount(updatedGrandTotal: grandTotalDecimal)

    }
    
    
    override func updateUI() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(addon(_:)), name: NSNotification.Name("addon"), object: nil)

        
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
        
        
       
        
        
        if MySingleton.shared.selectedAddonServices.count > 0 {
            tvHeight.constant = CGFloat((MySingleton.shared.selectedAddonServices.count * 30))
            addonView.isHidden = false
            addonView1.isHidden = false
            addonserviceTV.reloadData()
        }else {
            tvHeight.constant = 0
            addonView.isHidden = true
            addonView1.isHidden = true
            addonserviceTV.reloadData()
        }
        
    }
    
    
    
    func updateTotalAmount(updatedGrandTotal:Decimal) {
        // Update totalAmount label
        totalAmount.text = "\(MySingleton.shared.mpbpriceDetails?.api_currency ?? ""):\(updatedGrandTotal)"
        
    }
    
    
    @objc func addon(_ ns: NSNotification) {
        
        
        addonValue.text = ""
        
        // Update addonValue label
        addonValue.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""): \(MySingleton.shared.selectedAddonTotalPrice)"
        
        // Convert selectedAddonTotalPrice to Decimal
        let selectedAddonTotalPriceDecimal = Decimal(MySingleton.shared.selectedAddonTotalPrice)
        
        // Convert grand total to Decimal
        guard let grandTotalString = MySingleton.shared.mpbpriceDetails?.grand_total,
              let grandTotalDecimal = Decimal(string: grandTotalString) else {
            return // Handle the case where grand total cannot be converted to Decimal
        }

        // Add totalkwdvalue to grand total
        let updatedGrandTotal = grandTotalDecimal + selectedAddonTotalPriceDecimal
        updateTotalAmount(updatedGrandTotal: updatedGrandTotal)
        
    }

    
    func hide(v:UIView){
        v.isHidden = true
    }
    
    func show(v:UIView) {
        v.isHidden = false
    }
    
    
    
    
}



extension FareSummaryTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        addonserviceTV.register(UINib(nibName: "AddOnTitleTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addonserviceTV.delegate = self
        addonserviceTV.dataSource = self
        addonserviceTV.tableFooterView = UIView()
        addonserviceTV.showsHorizontalScrollIndicator = false
        addonserviceTV.separatorStyle = .singleLine
        addonserviceTV.isScrollEnabled = false
        addonserviceTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.selectedAddonServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddOnTitleTVCell {
            
            cell.selectionStyle = .none
            cell.titlelbl.text = MySingleton.shared.selectedAddonServices[indexPath.row].title
            cell.pricelbl.text = MySingleton.shared.selectedAddonServices[indexPath.row].price
            
            c = cell
            
        }
        return c
    }
    
}
