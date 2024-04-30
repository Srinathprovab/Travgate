//
//  LoginDetailsTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit
import Toast_Swift
import DropDown

protocol LoginDetailsTableViewCellDelegate {
    func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String, countryCode: String)
}

class LoginDetailsTableViewCell: TableViewCell {
    
    @IBOutlet weak var counryCodeView: UIView!
    @IBOutlet weak var phoneNumberTextfld: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var registerNowButton: UIButton!
    @IBOutlet weak var emailTextFld: UITextField!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var passwordTxtfld: UITextField!
    
    var maxLength = 8
    var country_val = String()
    var email = String()
    var phone = String()
    var pass = String()
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var billingCountryName = String()
    
    var nationalityCode = String()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var isoCountryCode = String()
    var delegate: LoginDetailsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emailTextFld.placeholder = "Email Address"
        phoneNumberTextfld.placeholder = "Phone Number"
        passwordTxtfld.placeholder = "Password"
        emailTextFld.layer.borderWidth = 0.7
        emailTextFld.setLeftPaddingPoints(10)
        phoneNumberTextfld.setLeftPaddingPoints(10)
        passwordTxtfld.setLeftPaddingPoints(10)
        countryCodeTextField.setLeftPaddingPoints(10)
        emailTextFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTextFld.layer.cornerRadius = 4
        middleView.isHidden = false
        registerNowButton.setTitle("Register Now", for: .normal)
        passwordTxtfld.layer.borderWidth = 0.7
        passwordTxtfld.setLeftPaddingPoints(10)
        passwordTxtfld.layer.borderColor = HexColor("#B8B8B8").cgColor
        passwordTxtfld.layer.cornerRadius = 4
        registerNowButton.layer.cornerRadius = 4
        setupDropDown()
        registerNowButton.backgroundColor = HexColor("#EE1935").withAlphaComponent(0.3)
        emailTextFld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        phoneNumberTextfld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        passwordTxtfld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        countryCodeTextField.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTextField.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTextField.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingDidBegin)
        countryCodeTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingDidBegin)
        phoneNumberTextfld.addTarget(self, action: #selector(editingText(textField:)), for: .editingDidBegin)
        phoneNumberTextfld.delegate = self
    }
    
    override func updateUI() {
        filterdcountrylist = MySingleton.shared.countrylist
        loadCountryNamesAndCode()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        self.phone = phoneNumberTextfld.text!
        self.email = emailTextFld.text!
        self.pass = passwordTxtfld.text!
        self.country_val = self.countryCodeTextField.text ?? ""
        
        if email == "" {
            showToastMsg(message: "Enter Email Adress")
        } else if email.isValidEmail() == false {
            showToastMsg(message: "Enter Valid Email")
        } else if phone == "" {
            showToastMsg(message: "Enter Phone Number")
        } else if pass == "" {
            showToastMsg(message: "Enter Password")
        } else if country_val == "" {
            showToastMsg(message: "Enter Country Code")
        } else {
            registerNowButton.backgroundColor = HexColor("#EE1935")
        }
    }
    
    
    func setupDropDown() {
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.counryCodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: counryCodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
//            self?.countryCodeLbl.text = ""
            self?.countryCodeTextField.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
        
            self?.countryCodeTextField.text = self?.countrycodesArray[index] ?? ""
            MySingleton.shared.paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTextField.resignFirstResponder()
        }
    }
    
    @objc func editingText(textField:UITextField) {
        self.country_val = self.countryCodeTextField.text ?? ""
            if textField == phoneNumberTextfld {
                if let text = textField.text {
                    let length = text.count
                    if length != maxLength {
                        phoneNumberTextfld.layer.borderColor = UIColor.red.cgColor
                        mobilenoMaxLengthBool = false
                    }else{
                        phoneNumberTextfld.layer.borderColor = UIColor.AppBorderColor.cgColor
                        mobilenoMaxLengthBool = true
                    }
                   
                } else {
                    phoneNumberTextfld.layer.borderColor = UIColor.red.cgColor
                    mobilenoMaxLengthBool = false
                }
            }
//            delegate?.editingTextField(tf: textField)
    }
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
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
    
    
    @IBAction func guestButtonAction(_ sender: Any) {
        
        if (emailTextFld.text != nil) && passwordTxtfld.text != "" && phoneNumberTextfld.text != "" &&  countryCodeTextField.text != ""
        {
            print("countrycode....\(country_val)")
            delegate?.RegisterNowButtonAction(cell: self, email: email, pass: pass, phone: phone, countryCode: self.country_val)
        } else {
            showToastMsg(message: "Enter the details")
        }
    }
    
}

extension LoginDetailsTableViewCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == phoneNumberTextfld {
             maxLength = self.billingCountryName.getMobileNumberMaxLength() ?? 8
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
        }else {
             maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
}
