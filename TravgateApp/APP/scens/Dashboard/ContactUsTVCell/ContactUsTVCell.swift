//
//  ContactUsTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 02/11/23.
//

import UIKit
import MaterialComponents
import DropDown


protocol ContactUsTVCellDelegate {
    
    func editingTextField(tf:UITextField)
    func didTapOnAddressBtnAction(cell:ContactUsTVCell)
    func didTapOnMailBtnAction(cell:ContactUsTVCell)
    func didTapOnPhoneBtnAction(cell:ContactUsTVCell)
    func didTapOnSubmitBtnAction(cell:ContactUsTVCell)
    func textViewDidChange(textView:UITextView)
    func didTapOnCountryCodeBtnAction(cell:ContactUsTVCell)
    
}

class ContactUsTVCell: TableViewCell, UITextViewDelegate {
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    
    var cname = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var requestBool = false
    var placeHolder = String()
    var delegate:ContactUsTVCellDelegate?
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
        loadCountryNamesAndCode()
    }
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        MySingleton.shared.countrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    func setupUI() {
        
        
       
        
        
        setupTF(tf: nameTF)
        setupTF(tf: emailTF)
        setupTF(tf: mobileTF)
        setupTF(tf: countryCodeTF)
        
        
        setupdescView()
        
        
        setupDropDown()
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        mobileTF.keyboardType = .numberPad
        
        countryCodeTF.textColor = .AppLabelColor
        //        countryCodeTF.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        //        countryCodeTF.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        
    }
    
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    func setupdescView() {
        
        messageTextView.layer.cornerRadius = 6
        messageTextView.clipsToBounds = true
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        messageTextView.text = ""
        messageTextView.delegate = self
        messageTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        messageTextView.setPlaceholder(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnAddressBtnAction(_ sender: Any) {
        delegate?.didTapOnAddressBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMailBtnAction(_ sender: Any) {
        delegate?.didTapOnMailBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnPhoneBtnAction(_ sender: Any) {
        delegate?.didTapOnPhoneBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSubmitBtnAction(_ sender: Any) {
        delegate?.didTapOnSubmitBtnAction(cell: self)
    }
    
    
}




extension UITextView{
    
    func setPlaceholder(ph:String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = ""
        placeholderLabel.font = UIFont.OpenSansRegular(size: 16)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = .SubtitleColor
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}



extension ContactUsTVCell {
    
    func setupDropDown() {
        
        dropDown.textColor = .AppLabelColor
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeTF
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeTF.frame.size.height + 25)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.cname = self?.countryNames[index] ?? ""
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
        }
        
    }
    
    
    @objc func searchTextBegin(textField: MDCOutlinedTextField) {
        textField.text = ""
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: MDCOutlinedTextField) {
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
        
        countryNames.removeAll()
        countrycodesArray.removeAll()
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        dropDown.dataSource = countryNames
        dropDown.show()
        
    }
    
}



extension ContactUsTVCell {
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == mobileTF {
            mobilenoMaxLength = cname.getMobileNumberMaxLength() ?? 8
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }else {
            mobilenoMaxLength = 50
        }
        
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= mobilenoMaxLength
    }
}
