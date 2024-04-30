//
//  PrimaryContactInfoTVCell.swift
//  Travgate
//
//  Created by FCI on 08/04/24.
//

import UIKit
import DropDown


protocol PrimaryContactInfoTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnCountryCodeBtn(cell:PrimaryContactInfoTVCell)
    func didTapOnRegisterBtnAction(cell:PrimaryContactInfoTVCell)
    func didTapOnGuestBtnAction(cell:PrimaryContactInfoTVCell)
    func didTapOnLoginBtnAction(cell:PrimaryContactInfoTVCell)
}


class PrimaryContactInfoTVCell: TableViewCell {
    
    @IBOutlet weak var mobileHolderView: UIView!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var showpassBtn: UIButton!
    
    
    var delegate:PrimaryContactInfoTVCellDelegate?
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
    var billingCountryName = String()
    var showpasswordbool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        filterdcountrylist =  MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        
        
        setupDropDown()
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        regBtn.setTitle("Register", for: .normal)
        guestBtn.setTitle("Continue as Guest", for: .normal)
        
        if MySingleton.shared.tapRegorLogonBool == false {
            mobileHolderView.isHidden = false
            guestBtn.isHidden = false
            regBtn.setTitle("Register", for: .normal)
            guestBtn.setTitle("Continue as Guest", for: .normal)
        }else {
           
            mobileHolderView.isHidden = true
            guestBtn.isHidden = true
            regBtn.setTitle("Login", for: .normal)
        }
        
    }
    
    
    func setuUI() {
        regBtn.layer.cornerRadius = 6
        guestBtn.layer.cornerRadius = 6
        setupTF(textfield: countrycodeTF)
        setupTF(textfield: mobileTF)
        setupTF(textfield: emailTF)
        setupTF(textfield: passTF)
        mobileHolderView.isHidden = false
        passTF.isSecureTextEntry = true
        
        countrycodeTF.delegate = self
        countrycodeTF.setLeftPaddingPoints(15)
        countrycodeTF.font = UIFont.OpenSansRegular(size: 14)
        countrycodeTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        countrycodeTF.keyboardType = .default
        emailTF.keyboardType = .emailAddress
        mobileTF.keyboardType = .numberPad
        passTF.keyboardType = .default
        
    }
    
    
    func setupTF(textfield:UITextField) {
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.BorderColor.cgColor
        textfield.layer.cornerRadius = 4
        textfield.delegate = self
        textfield.setLeftPaddingPoints(15)
        textfield.font = UIFont.OpenSansRegular(size: 14)
        textfield.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
        
        if textField == mobileTF {
            if let text = textField.text {
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
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    @IBAction func didTapOnRegisterBtnAction(_ sender: Any) {
        
//        if (sender as AnyObject).titleLabel?.text == "Login" {
//            delegate?.didTapOnLoginBtnAction(cell: self)
//        }else {
//            delegate?.didTapOnRegisterBtnAction(cell: self)
//        }
        
        
        if (sender as AnyObject).titleLabel.text == "Login" {
            delegate?.didTapOnLoginBtnAction(cell: self)
        }else {
            delegate?.didTapOnRegisterBtnAction(cell: self)
        }
        
    }
    
    
    
    @IBAction func didTapOnGuestBtnAction(_ sender: Any) {
        delegate?.didTapOnGuestBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnShowPasswordBtnAction(_ sender: Any) {
        showpasswordbool.toggle()
        if showpasswordbool {
            showpassBtn.setImage(UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor), for: .normal)
            passTF.isSecureTextEntry = false
        }else {
            showpassBtn.setImage(UIImage(named: "hidepass"), for: .normal)
            passTF.isSecureTextEntry = true
        }
    }
    
}

extension PrimaryContactInfoTVCell {
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countrycodeTF
        dropDown.bottomOffset = CGPoint(x: 0, y: countrycodeTF.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countrycodeTF.textColor = .TitleColor
            
            
            
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


extension PrimaryContactInfoTVCell {
    
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
