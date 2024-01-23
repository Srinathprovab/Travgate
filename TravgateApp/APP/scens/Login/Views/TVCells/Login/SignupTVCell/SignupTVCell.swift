//
//  SignupTVCell.swift
//  TravgateApp
//
//  Created by FCI on 12/01/24.
//

import UIKit


protocol SignupTVCellDelegate {
    func didTapOnRegisterCloseBtnAction(cell:SignupTVCell)
    func didTapOnSignupBtnAction(cell:SignupTVCell)
    func editingTextField(tf:UITextField)
}

class SignupTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confPassTF: UITextField!
    @IBOutlet weak var passshowBtn: UIButton!
    @IBOutlet weak var confPassBtn: UIButton!
    @IBOutlet weak var signupbtn: UIButton!
    
    
    @IBOutlet weak var fnameview: UIView!
    @IBOutlet weak var lnameview: UIView!
    @IBOutlet weak var mobileview: UIView!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passview: UIView!
    @IBOutlet weak var confPassview: UIView!
    
    
    var showbool1 = false
    var showbool2 = false
    var delegate:SignupTVCellDelegate?
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
        
        passTF.isSecureTextEntry = true
        confPassTF.isSecureTextEntry = true
        signupbtn.layer.cornerRadius = 6
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: passTF)
        setupTF(tf: confPassTF)
        
    }
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    override func updateUI() {
        
    }
    
    
    @objc func editingText(textField:UITextField) {
        
        
        switch textField.tag {
        case 1:
            fnameview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 2:
            lnameview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 12:
            mobileview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 11:
            emailview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 3:
            passview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
            
        case 4:
            confPassview.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
            
        default:
            break
        }
        
        
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    @IBAction func didTapOnRegisterCloseBtnAction(_ sender: Any) {
        delegate?.didTapOnRegisterCloseBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnPassShowBtnAction(_ sender: Any) {
        passTF.resignFirstResponder()
        showbool1.toggle()
        if showbool1 {
            passshowBtn.setImage(UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            passTF.isSecureTextEntry = false
        }else {
            passshowBtn.setImage(UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            passTF.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func didTapOnConfPassBtnAction(_ sender: Any) {
        confPassTF.resignFirstResponder()
        showbool2.toggle()
        if showbool2 {
            confPassBtn.setImage(UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            confPassTF.isSecureTextEntry = false
        }else {
            confPassBtn.setImage(UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            confPassTF.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func didTapOnSignupBtnAction(_ sender: Any) {
        delegate?.didTapOnSignupBtnAction(cell: self)
    }
    
    
}




extension SignupTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == mobileTF {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        }else if textField == emailTF {
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else {
            let maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        
        
    }
    
    
}
