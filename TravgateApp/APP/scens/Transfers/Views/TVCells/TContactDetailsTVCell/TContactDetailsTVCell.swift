//
//  TContactDetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 09/05/24.
//

import UIKit
import DropDown

protocol TContactDetailsTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnCountryCodeBtn(cell:TContactDetailsTVCell)
}

class TContactDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var mobileTFView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    
    
    var billingCountryName = String()
    var maxLength = 8
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    var nationalityCode = String()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var isoCountryCode = String()
    
    var delegate:TContactDetailsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        filterdcountrylist =  MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        
        
        
        
        if MySingleton.shared.guestbool == true {
            emailTF.text =  MySingleton.shared.payemail
            mobileTF.text = MySingleton.shared.paymobile
            countrycodeTF.text =  MySingleton.shared.paymobilecountrycode
        }
        
        let usersignIn = defaults.object(forKey: UserDefaultsKeys.regStatus) as? Bool
        if usersignIn == true {
            if let email = defaults.string(forKey: UserDefaultsKeys.useremail) {
                MySingleton.shared.payemail = email
                emailTF.text =  MySingleton.shared.payemail
            }
            
            if let mobile = defaults.string(forKey: UserDefaultsKeys.usermobile) {
                MySingleton.shared.paymobile = mobile
                mobileTF.text = MySingleton.shared.paymobile
            }
            
            if let code = defaults.string(forKey: UserDefaultsKeys.countryCode) {
                MySingleton.shared.paymobilecountrycode = code
                countrycodeTF.text =  MySingleton.shared.paymobilecountrycode
            }
            
            mobilenoMaxLengthBool = true
        }
        
        let userLoggedIn1 = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool
        if userLoggedIn1 == true{
            if let email = defaults.string(forKey: UserDefaultsKeys.useremail) {
                MySingleton.shared.payemail = email
                emailTF.text = MySingleton.shared.payemail
            }
            
            if let mobile = defaults.string(forKey: UserDefaultsKeys.usermobile) {
                MySingleton.shared.paymobile = mobile
                mobileTF.text = MySingleton.shared.paymobile
            }
            
            if let code = defaults.string(forKey: UserDefaultsKeys.usermobilecode) {
                MySingleton.shared.paymobilecountrycode = code
                countrycodeTF.text = MySingleton.shared.paymobilecountrycode
            }
            
            mobilenoMaxLengthBool = true
            
        }else {
            defaults.setValue(false, forKey: UserDefaultsKeys.regStatus)
        }
        
        
    }
    
    
    func setupUI() {
        
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: fullnameTF)
        setupTF(tf: countrycodeTF)
        
        setupDropDown()
        
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.font = .InterRegular(size: 14)
        tf.setLeftPaddingPoints(15)
        tf.textColor = .TitleColor
        tf.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
    }
    
    @objc func editingTextField(_ tf:UITextField) {
        
        if tf == mobileTF {
            if let text = tf.text {
                let length = text.count
                if length != maxLength {
                    
                    mobilenoMaxLengthBool = false
                }else{
                    
                    mobilenoMaxLengthBool = true
                }
                
            } else {
                
                mobilenoMaxLengthBool = false
            }
        }
        
        delegate?.editingTextField(tf:tf)
    }
    
}



extension TContactDetailsTVCell {
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.mobileTFView
        dropDown.bottomOffset = CGPoint(x: 0, y: mobileTFView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            MySingleton.shared.paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
            
        }
    }
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist =  MySingleton.shared.countrylist
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
        filterdcountrylist =  MySingleton.shared.countrylist.filter { thing in
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
    
    
    
}


extension TContactDetailsTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        
        
        if textField == mobileTF {
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
