//
//  RegisterNowTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23. 
//

import UIKit
import Toast_Swift

protocol RegisterNowTableViewCellDelegate {
    func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String)
}

class RegisterNowTableViewCell: TableViewCell {

    @IBOutlet weak var phoneNumberTextfld: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var registerNowButton: UIButton!
    @IBOutlet weak var emailTextFld: UITextField!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var passwordTxtfld: UITextField!
    var email = String()
    var pass = String()
    
    var delegate: RegisterNowTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        emailTextFld.placeholder = "Email Address"
        passwordTxtfld.placeholder = "Password"
        registerNowButton.setTitle("Login", for: .normal)
        emailTextFld.layer.borderWidth = 0.7
        emailTextFld.setLeftPaddingPoints(10)
        phoneNumberTextfld.setLeftPaddingPoints(10)
        passwordTxtfld.setLeftPaddingPoints(10)
        countryCodeTextField.setLeftPaddingPoints(10)
        emailTextFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTextFld.layer.cornerRadius = 4
        
        passwordTxtfld.layer.borderWidth = 0.7
        passwordTxtfld.setLeftPaddingPoints(10)
        passwordTxtfld.layer.borderColor = HexColor("#B8B8B8").cgColor
        passwordTxtfld.layer.cornerRadius = 4
        registerNowButton.layer.cornerRadius = 4
        registerNowButton.backgroundColor = HexColor("#EE1935").withAlphaComponent(0.3)
        emailTextFld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
//        phoneNumberTextfld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        passwordTxtfld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
    }
    
    override func updateUI() {
        if cellInfo?.key == "register" {
            middleView.isHidden = true
           
        } else {
            middleView.isHidden = false
            registerNowButton.setTitle("login", for: .normal)
           
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        self.pass = passwordTxtfld.text!
        self.email = emailTextFld.text!
        
        self.pass = passwordTxtfld.text!
        self.email = emailTextFld.text!
        if email == "" {
            showToastMsg(message: "Enter Email Adress")
        } else if email.isValidEmail() == false {
            showToastMsg(message: "Enter Valid Email")
        } else if pass == "" {
            showToastMsg(message: "Enter Password")
        } else {
            registerNowButton.backgroundColor = HexColor("#EE1935")
        }
    }
    
    func showToastMsg(message: String) {
        var style = ToastStyle()
        style.messageAlignment = .center
        style.backgroundColor = UIColor.black
        style.messageFont = UIFont.OpenSansMedium(size: 16)
        style.messageColor = UIColor.WhiteColor
        
        ToastManager.shared.style = style
        ToastManager.shared.position = .bottom
        self.contentView.makeToast(message, duration: 4)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
    
        if (emailTextFld.text != nil) && passwordTxtfld.text != ""
        {
            delegate?.loginNowButtonAction(cell: self, email: email, pass: pass)
        } else {
            showToastMsg(message: "Enter the details")
        }
    }
    
}
