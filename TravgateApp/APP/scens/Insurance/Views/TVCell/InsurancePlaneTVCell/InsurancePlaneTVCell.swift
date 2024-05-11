//
//  InsurancePlaneTVCell.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

protocol InsurancePlaneTVCellDelegate {
    func didTapOnSelectPlanBtnAction(cell:InsurancePlaneTVCell)
    func didTapOnPremiumDetailsBtnAction(cell:InsurancePlaneTVCell)
}

class InsurancePlaneTVCell: TableViewCell {
    
    
    @IBOutlet weak var selectPlanBtn: UIButton!
    @IBOutlet weak var premiumDetailsBtn: UIButton!
    @IBOutlet weak var pricelbl: UILabel!
    
    
    var delegate:InsurancePlaneTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        if cellInfo?.key == "plan" {
            premiumDetailsBtn.isHidden = true
        }else {
            premiumDetailsBtn.isHidden = false
        }
    }
    
    
    func setupUI(){
        selectPlanBtn.layer.cornerRadius = 4
        premiumDetailsBtn.layer.cornerRadius = 4
        
        MySingleton.shared.setAttributedTextnew(str1: "6.2",
                                                str2: "kwd",
                                                lbl: pricelbl,
                                                str1font: .OpenSansBold(size: 24),
                                                str2font: .OpenSansRegular(size: 12),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
    }
    
    
    @IBAction func didTapOnSelectPlanBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectPlanBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnPremiumDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnPremiumDetailsBtnAction(cell: self)
    }
    
    
}
