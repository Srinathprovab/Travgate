//
//  OperatorsCheckBoxTVCell.swift
//  Travgate
//
//  Created by FCI on 05/04/24.
//

import UIKit

class OperatorsCheckBoxTVCell: TableViewCell {

    
    @IBOutlet weak var check1img: UIImageView!
    @IBOutlet weak var check2img: UIImageView!
    
    var check1bool = false
    var check2bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
