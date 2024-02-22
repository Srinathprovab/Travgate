//
//  InternationalTravelInsuranceTVCell.swift
//  Travgate
//
//  Created by FCI on 22/02/24.
//

import UIKit

class InternationalTravelInsuranceTVCell: TableViewCell {
    
    
    @IBOutlet weak var emergencyBtn: UIButton!
    @IBOutlet weak var emergencySelectImg: UIImageView!
    @IBOutlet weak var riskBtn: UIButton!
    @IBOutlet weak var riskSelectImg: UIImageView!

    
    
    var emergencyBool = false
    var riskBool = false
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
        emergencyBtn.addTarget(self, action: #selector(didTapOnSelectEmergencyBtnAction), for: .touchUpInside)
        
        riskBtn.addTarget(self, action: #selector(didTapOnSelectRiskBtnAction), for: .touchUpInside)
    }
    
    
    
    @objc func didTapOnSelectEmergencyBtnAction() {
        emergencySelectImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        riskSelectImg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    @objc func didTapOnSelectRiskBtnAction() {
        riskSelectImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        emergencySelectImg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    
}
