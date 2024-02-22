//
//  AddonTVCell.swift
//  Travgate
//
//  Created by FCI on 22/02/24.
//

import UIKit


enum Addson {
    case whatsApp
    case flexiblebooking
    case pricechange
    case notification
    case nothing
}


protocol AddonTVCellDelegate {
    func didTapOnAddonServiceBtnAction(cell:AddonTVCell)
}

class AddonTVCell: TableViewCell {
    
    @IBOutlet weak var addsonTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var delegate:AddonTVCellDelegate?
    var addsonTitleArray = ["WhatsApp services",
                            "Flexible Booking",
                            "Price Change",
                            "Notification"]
    
    var addsonImageArray = ["addon1",
                            "addon2",
                            "addon3",
                            "addon4"]
    
    
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
    }
    
    override func updateUI() {
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.addonServices.count * 110)
    }
    
}


extension AddonTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        addsonTV.register(UINib(nibName: "AddsOnInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addsonTV.delegate = self
        addsonTV.dataSource = self
        addsonTV.tableFooterView = UIView()
        addsonTV.showsHorizontalScrollIndicator = false
        addsonTV.separatorStyle = .singleLine
        addsonTV.isScrollEnabled = false
        addsonTV.separatorStyle = .none
        addsonTV.allowsMultipleSelection = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.addonServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddsOnInfoTVCell {
            
            cell.selectionStyle = .none
            cell.titlelbl.text = MySingleton.shared.addonServices[indexPath.row].display_title
            
            cell.addonLogo.sd_setImage(with: URL(string: MySingleton.shared.addonServices[indexPath.row].image ?? ""), completed: nil)
            
            cell.kwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(MySingleton.shared.addonServices[indexPath.row].price ?? "0")"
            
            
            
            //            if cell.titlelbl.text == "Notification" {
            //                cell.checkimg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            //
            //                MySingleton.shared.addonSelectedArray.append("\(cell.titlelbl.text ?? "")")
            //                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            //
            //            }
            
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddsOnInfoTVCell {
            cell.checkimg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            
            let price = Decimal(string: MySingleton.shared.addonServices[indexPath.row].price ?? "0") ?? 0
            MySingleton.shared.selectedAddonTotalPrice += (NSDecimalNumber(decimal: price).intValue)

            MySingleton.shared.addonSelectedArray.append("\(cell.titlelbl.text ?? "")")
            print(MySingleton.shared.selectedAddonTotalPrice)
            
           
            NotificationCenter.default.post(name: NSNotification.Name("addon"), object: nil)
            
            delegate?.didTapOnAddonServiceBtnAction(cell: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddsOnInfoTVCell {
            cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            
            let price = Decimal(string: MySingleton.shared.addonServices[indexPath.row].price ?? "0") ?? 0
            MySingleton.shared.selectedAddonTotalPrice -= (NSDecimalNumber(decimal: price).intValue)

            if let index = MySingleton.shared.addonSelectedArray.firstIndex(of: cell.titlelbl.text ?? "") {
                          MySingleton.shared.addonSelectedArray.remove(at: index)
                      }
            print(MySingleton.shared.selectedAddonTotalPrice)
            NotificationCenter.default.post(name: NSNotification.Name("addon"), object: nil)
            delegate?.didTapOnAddonServiceBtnAction(cell: self)
        }
    }
    
    
}
