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

class SelectedAddonService {
    var title: String
    var price: String
    
    init(title: String, price: String) {
        self.title = title
        self.price = price
    }
}



protocol AddonTVCellDelegate {
    func didTapOnAddonServiceBtnAction(cell:AddonTVCell)
}

class AddonTVCell: TableViewCell {
    
    @IBOutlet weak var addsonTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var delegate:AddonTVCellDelegate?
   
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
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            tvHeight.constant = CGFloat(MySingleton.shared.addonServices.count * 110)
        }else {
            tvHeight.constant = CGFloat(MySingleton.shared.hotelAddonServices.count * 110)
        }
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
       
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            return MySingleton.shared.addonServices.count
        }else {
            return MySingleton.shared.hotelAddonServices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddsOnInfoTVCell {
            
            cell.selectionStyle = .none
           
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                cell.titlelbl.text = MySingleton.shared.addonServices[indexPath.row].display_title
                cell.subtitlelbl.text = MySingleton.shared.addonServices[indexPath.row].details
                
                cell.addonLogo.sd_setImage(with: URL(string: MySingleton.shared.addonServices[indexPath.row].image ?? ""), completed: nil)
                
                cell.kwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(MySingleton.shared.addonServices[indexPath.row].price ?? "0")"
                
                
                
                
                
            }else {
                cell.titlelbl.text = MySingleton.shared.hotelAddonServices[indexPath.row].display_title
                cell.subtitlelbl.text = MySingleton.shared.hotelAddonServices[indexPath.row].details
                cell.addonLogo.sd_setImage(with: URL(string: MySingleton.shared.hotelAddonServices[indexPath.row].image ?? ""), completed: nil)
                
                cell.kwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD") \(MySingleton.shared.hotelAddonServices[indexPath.row].price ?? "0")"
            }
            
            c = cell
            
        }
        return c
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddsOnInfoTVCell {
            
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                cell.checkimg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
                
                let price = Decimal(string: MySingleton.shared.addonServices[indexPath.row].price ?? "0") ?? 0.0
                MySingleton.shared.selectedAddonTotalPrice += (NSDecimalNumber(decimal: price).intValue)
                
                print(MySingleton.shared.selectedAddonTotalPrice)
              
                
                let selectedTitle = MySingleton.shared.addonServices[indexPath.row].display_title ?? ""
                    let selectedPrice = MySingleton.shared.addonServices[indexPath.row].price ?? "0"
                    
                    let selectedAddon = SelectedAddonService(title: selectedTitle, price: selectedPrice)
                MySingleton.shared.selectedAddonServices.append(selectedAddon)
                
                
            }else {
                cell.checkimg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
                
                let price = Decimal(string: MySingleton.shared.hotelAddonServices[indexPath.row].price ?? "0") ?? 0
                MySingleton.shared.selectedAddonTotalPrice += (NSDecimalNumber(decimal: price).intValue)
                
            
                
                MySingleton.shared.addonSelectedArray.append("\(cell.titlelbl.text ?? "")")
                print(MySingleton.shared.selectedAddonTotalPrice)
                print(MySingleton.shared.afterAddonAmountAdded)
            }
            
            
            
            
            // Post notification
            NotificationCenter.default.post(name: NSNotification.Name("addon"), object: nil)
            delegate?.didTapOnAddonServiceBtnAction(cell: self)
        }
    }

    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddsOnInfoTVCell {
            
            
            
            let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
            if tabselect == "Flight" {
                cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
                
                let price = Decimal(string: MySingleton.shared.addonServices[indexPath.row].price ?? "0") ?? 0
                MySingleton.shared.selectedAddonTotalPrice -= (NSDecimalNumber(decimal: price).intValue)
               
                print(MySingleton.shared.selectedAddonTotalPrice)
                
                
                let deselectedTitle = MySingleton.shared.addonServices[indexPath.row].display_title ?? ""
                    let deselectedPrice = MySingleton.shared.addonServices[indexPath.row].price ?? "0"
                    
                let deselectedAddon = SelectedAddonService(title: deselectedTitle , price: deselectedPrice)
                    
                    // Find the index of the deselected addon in selectedAddonServices
                if let index = MySingleton.shared.selectedAddonServices.firstIndex(where: { $0.title == deselectedAddon.title && $0.price == deselectedAddon.price }) {
                        // Remove the deselected addon from the array
                        MySingleton.shared.selectedAddonServices.remove(at: index)
                    }
                
                
                
            }else {
                cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
                
                let price = Decimal(string: MySingleton.shared.hotelAddonServices[indexPath.row].price ?? "0") ?? 0
                MySingleton.shared.selectedAddonTotalPrice -= (NSDecimalNumber(decimal: price).intValue)
               
                if let index = MySingleton.shared.addonSelectedArray.firstIndex(of: cell.titlelbl.text ?? "") {
                    MySingleton.shared.addonSelectedArray.remove(at: index)
                }
                print(MySingleton.shared.selectedAddonTotalPrice)
                print(MySingleton.shared.afterAddonAmountAdded)
            }
            
            
            NotificationCenter.default.post(name: NSNotification.Name("addon"), object: nil)
            delegate?.didTapOnAddonServiceBtnAction(cell: self)
            
        }
    }
    
    
}
