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
    
    
    var delegate:OperatorsCheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        if MySingleton.shared.enablePaymentButtonBool1 == true {
            check1bool = false
            check1img.image = UIImage(named: "check")
        }
        
        if MySingleton.shared.enablePaymentButtonBool2 == true {
            check2bool = false
            check2img.image = UIImage(named: "check")
        }
        
        if MySingleton.shared.enablePaymentButtonBool1 == true && MySingleton.shared.enablePaymentButtonBool2 == true {
            check1bool = false
            check2bool = false
            check1img.image = UIImage(named: "check")
            check2img.image = UIImage(named: "check")
            
            enableContinueToPaymentBool()
        }
        
        
    }
    
    
    @IBAction func didTapOnMultipleOperatoreBtnAction(_ sender: Any) {
        
        check1bool.toggle()
        
        if check1bool {
            MySingleton.shared.enablePaymentButtonBool1 = true
            check1img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
            MySingleton.shared.enablePaymentButtonBool1 = false
            check1img.image = UIImage(named: "uncheck")
            enableContinueToPaymentBool()
        }
        
        
    }
    
    
    @IBAction func didTapOnPaymentCeheckBoxBtnAction(_ sender: Any) {
       
        check2bool.toggle()
        
        if check2bool {
            MySingleton.shared.enablePaymentButtonBool2 = true
            check2img.image = UIImage(named: "check")
            enableContinueToPaymentBool()
        }else {
            MySingleton.shared.enablePaymentButtonBool2 = false
            check2img.image = UIImage(named: "uncheck")
            enableContinueToPaymentBool()
        }
        
        
    }
    
    
    func enableContinueToPaymentBool() {
        delegate?.enableContinuetoPaymentBtn(cell: self)
    }
}
