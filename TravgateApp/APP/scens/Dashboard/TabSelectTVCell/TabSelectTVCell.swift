//
//  TabSelectTVCell.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit




protocol TabSelectTVCellDelegate {
    
    func didTapOnMenuBtnAction(cell:TabSelectTVCell)
    func didTapOnSelectCurrencyBtnAction(cell:TabSelectTVCell)
    func didTapOnFlightTabSelectBtnAction(cell:TabSelectTVCell)
    func didTapOnHotelTabSelect(cell:TabSelectTVCell)
    func didTapOnMoreServiceBtnAction(cell:TabSelectTVCell)
    
}


class TabSelectTVCell: TableViewCell {
    
    
    @IBOutlet weak var currencylbl: UILabel!
    
    
    
    var delegate:TabSelectTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        currencylbl.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD"
    }
    
    @IBAction func didTapOnSelectCurrencyBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectCurrencyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnFlightTabSelectBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightTabSelectBtnAction(cell: self)
    }
    
    @IBAction func didTapOnHotelTabSelect(_ sender: Any) {
        delegate?.didTapOnHotelTabSelect(cell: self)
    }
    
    
    @IBAction func didTapOnMenuBtnAction(_ sender: Any) {
        delegate?.didTapOnMenuBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMoreServiceBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("moreservice"), object: nil)
        delegate?.didTapOnMoreServiceBtnAction(cell: self)
    }
    
}
