//
//  TermsAgreeTVCell.swift
//  Travgate
//
//  Created by FCI on 09/05/24.
//

import UIKit

class TermsAgreeTVCell: TableViewCell {
    
    @IBOutlet weak var checkboximg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
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
        titlelbl.text = cellInfo?.title ?? ""
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
