//
//  LoginTVCell.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit


protocol LoginTVCellDelegate {
    func didTapOnSignUpBtnAction(cell:LoginTVCell)
    func didTapOnLoginBtnAction(cell:LoginTVCell)
    func didTapOnForgetPasswordBtnAction(cell:LoginTVCell)
    func didTapOnCloseBtnAction(cell:LoginTVCell)
    func editingTextField(tf:UITextField)
}

class LoginTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passwordview: UIView!
    var passbool = false
    var delegate:LoginTVCellDelegate?
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
        
        holderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
    
        passTF.isSecureTextEntry = true
        loginBtn.layer.cornerRadius = 6
        setupTF(tf: emailTF)
        setupTF(tf: passTF)
    }
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    override func updateUI() {
        
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        if textField.tag == 1 {
            emailview.layer.borderColor = UIColor.AppBorderColor.cgColor
        }else {
            passwordview.layer.borderColor = UIColor.AppBorderColor.cgColor
        }
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnSignUpBtnAction(_ sender: Any) {
        delegate?.didTapOnSignUpBtnAction(cell: self)
    }
    
    @IBAction func didTapOnLoginBtnAction(_ sender: Any) {
        delegate?.didTapOnLoginBtnAction(cell: self)
    }
    
    @IBAction func didTapOnForgetPasswordBtnAction(_ sender: Any) {
        delegate?.didTapOnForgetPasswordBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnShowPasswordBtnAction(_ sender: Any) {
        passbool.toggle()
        if passbool {
            showPasswordBtn.setImage(UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            passTF.isSecureTextEntry = false
        }else {
            showPasswordBtn.setImage(UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            passTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        delegate?.didTapOnCloseBtnAction(cell: self)
    }
    
}




extension LoginTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        switch textField.tag {
        case 11://email
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        case 12://mobile
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        default:
            let maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
    }
    
    
}
