//
//  OperatorsCheckBoxTVCell.swift
//  Travgate
//
//  Created by FCI on 05/04/24.
//

import UIKit
protocol OperatorsCheckBoxTVCellDelegate {
    func enableContinuetoPaymentBtn(cell:OperatorsCheckBoxTVCell)
}

class OperatorsCheckBoxTVCell: TableViewCell {

    
    @IBOutlet weak var check1img: UIImageView!
    @IBOutlet weak var check2img: UIImageView!
    
    var check1bool = false
    var check2bool = false
    var enablePaymentButtonBool1 = false
    var enablePaymentButtonBool2 = false
    
    var delegate:OperatorsCheckBoxTVCellDelegate?
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
            enablePaymentButtonBool1 = true
            check1img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
            enablePaymentButtonBool1 = false
            check1img.image = UIImage(named: "uncheck")
        }
    }
    
    
    @IBAction func didTapOnPaymentCeheckBoxBtnAction(_ sender: Any) {
        check2bool.toggle()
        if check2bool {
            enablePaymentButtonBool2 = true
            check2img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
            enablePaymentButtonBool2 = false
            check2img.image = UIImage(named: "uncheck")
            enableContinueToPaymentBool()
        }
    }
    
    
    func enableContinueToPaymentBool() {
        delegate?.enableContinuetoPaymentBtn(cell: self)
    }
}
