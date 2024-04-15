//
//  RegisterSelectionLoginTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

protocol RegisterSelectionLoginTableViewCellDelegate {
    func didTapOnRegisterNowOrLoginButtonAction(cell: RegisterSelectionLoginTableViewCell)
}

class RegisterSelectionLoginTableViewCell: TableViewCell {
    
    @IBOutlet weak var registerRadioImage: UIImageView!
    @IBOutlet weak var loginRadioImage: UIImageView!
    
    
    var delegate: RegisterSelectionLoginTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        registerRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnRegisterNowOrLoginButtonAction(_ sender: Any) {
        
       
        if (sender as AnyObject).tag == 1 {
            registerRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            loginRadioImage.image = UIImage(named: "radiounselected")
            MySingleton.shared.tapRegorLogonBool = false
        }else {
            loginRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            registerRadioImage.image = UIImage(named: "radiounselected")
            MySingleton.shared.tapRegorLogonBool = true
        }
        
        delegate?.didTapOnRegisterNowOrLoginButtonAction(cell: self)
    }
    
    
    
    
}
