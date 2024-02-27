//
//  HolidayContactdetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit
import DropDown

protocol HolidayContactdetailsTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnSubmitEnquiryBtnAction(cell:HolidayContactdetailsTVCell)
    func didTapOnRequestCallBackBtnAction(cell:HolidayContactdetailsTVCell)
    func didTapOnAddPeopleBtnAction(cell:HolidayContactdetailsTVCell)
    func donedatePicker(cell:HolidayContactdetailsTVCell)
    func cancelDatePicker(cell:HolidayContactdetailsTVCell)
    
}

class HolidayContactdetailsTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var travelFromTF: UITextField!
    @IBOutlet weak var travelToTF: UITextField!
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var addPeopleBtn: UIButton!
    @IBOutlet weak var enquireyBtn: UIButton!
    @IBOutlet weak var requestCallBtn: UIButton!
    @IBOutlet weak var titleDropDownBtn: UIButton!
    @IBOutlet weak var fnametitlelbl: UILabel!
    @IBOutlet weak var totalPassengerlbl: UILabel!
    
    let travelFromDatePicker = UIDatePicker()
    let travelToDatePicker = UIDatePicker()
    var countryCodeDropDown = DropDown()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countryNamesWithCodeArray = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var nationalityCodeArray = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    var cname = String()
    var delegate:HolidayContactdetailsTVCellDelegate?
    var titleDropdown = DropDown()
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
        totalPassengerlbl.text = defaults.string(forKey: UserDefaultsKeys.cruistotalpassengercount) ?? "1 Passenger"
        
        travelFromTF.text = defaults.string(forKey: UserDefaultsKeys.fromtravelDate) ?? "Select Date"
        
        travelToTF.text = defaults.string(forKey: UserDefaultsKeys.totravelDate) ?? "Select Date"
        
        MySingleton.shared.travelfrom = travelFromTF.text ?? ""
        MySingleton.shared.travelto = travelToTF.text ?? ""
    }
    
    
    
    func setupUI() {
        
        setupTF(tf: fnameTF, tag: 1)
        setupTF(tf: emailTF, tag: 2)
        setupTF(tf: mobileTF, tag: 3)
        setupTF(tf: travelFromTF, tag: 4)
        setupTF(tf: travelToTF, tag: 5)
        setupTF(tf: countryCodeTF, tag: 6)
        
        
        titleDropDownBtn.addTarget(self, action: #selector(didTapOnTitleDropDownBtnAction(_:)), for: .touchUpInside)
        enquireyBtn.addTarget(self, action: #selector(didTapOnSubmitEnquiryBtnAction(_:)), for: .touchUpInside)
        requestCallBtn.addTarget(self, action: #selector(didTapOnRequestCallBackBtnAction(_:)), for: .touchUpInside)
        addPeopleBtn.addTarget(self, action: #selector(didTapOnAddPeopleBtnAction(_:)), for: .touchUpInside)
        
        
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        setupCountryCodeDropDown()
        setuptitleDropdown()
        showdepDatePicker()
        showreturndepDatePicker()
    }
    
    func setupTF(tf:UITextField,tag:Int) {
        tf.tag = tag
        tf.font = .OpenSansRegular(size: 14)
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    @objc func didTapOnTitleDropDownBtnAction(_ sender:UIButton) {
        titleDropdown.show()
    }
    
    @objc func didTapOnSubmitEnquiryBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSubmitEnquiryBtnAction(cell: self)
    }
    
    @objc func didTapOnRequestCallBackBtnAction(_ sender:UIButton) {
        delegate?.didTapOnRequestCallBackBtnAction(cell: self)
    }
    
    
    @objc func didTapOnAddPeopleBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAddPeopleBtnAction(cell: self)
    }
    
}


extension HolidayContactdetailsTVCell {
    
    //MARK: - setupNationalityDropDown
    func setuptitleDropdown() {
        
        titleDropdown.dataSource = ["Mr","Mrs","Miss"]
        titleDropdown.direction = .bottom
        titleDropdown.backgroundColor = .WhiteColor
        titleDropdown.anchorView = self.titleDropDownBtn
        titleDropdown.bottomOffset = CGPoint(x: 0, y: titleDropDownBtn.frame.size.height + 10)
        titleDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.fnametitlelbl.text = item
            self?.fnameTF.becomeFirstResponder()
            MySingleton.shared.mrtitle = item
        }
    }
}








//MARK: - setupAirlineDropDown
extension HolidayContactdetailsTVCell {
    
    
    //MARK: - setupVisaDestinationDropDown
    func setupCountryCodeDropDown() {
        
        countryCodeDropDown.direction = .bottom
        countryCodeDropDown.backgroundColor = .WhiteColor
        countryCodeDropDown.anchorView = self.countryCodeTF
        countryCodeDropDown.bottomOffset = CGPoint(x: 0, y: countryCodeTF.frame.size.height + 10)
        countryCodeDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.mobileTF.becomeFirstResponder()
            self?.mobileTF.text = ""
            self?.cname = self?.countryNames[index] ?? ""
            MySingleton.shared.cruiseCountryCode = self?.countrycodesArray[index] ?? ""
            //   self?.countrycodeView.layer.borderColor = UIColor.AppBorderColor.cgColor
            
        }
    }
    
    
    //MARK: - searchTextBegin  searchTextChanged  loadCountryNamesAndCode
    @objc func searchTextBegin(textField: UITextField) {
        
        
        if textField == travelFromTF {
            travelFromTF.text = ""
        }else if textField == travelToTF {
            travelToTF.text = ""
        }else {
            countryCodeTF.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = MySingleton.shared.countrylist
            loadCountryNamesAndCode()
            countryCodeDropDown.show()
        }
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText, tf: textField)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText, tf: textField)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String,tf:UITextField) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        countryCodeDropDown.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        nationalityCodeArray.removeAll()
        countryNamesWithCodeArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countryNamesWithCodeArray.append("\(i.name ?? "") \(i.country_code ?? "")")
            countrycodesArray.append(i.country_code ?? "")
            nationalityCodeArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            countryCodeDropDown.dataSource = countryNamesWithCodeArray
        }
    }
    
}





extension HolidayContactdetailsTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        travelFromDatePicker.datePickerMode = .date
        travelFromDatePicker.minimumDate = Date()
        travelFromDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            travelFromDatePicker.date = calDepDate
            
            if self.travelToTF.text == "Select Date" {
                travelToDatePicker.date = calDepDate
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.travelFromTF.inputAccessoryView = toolbar
        self.travelFromTF.inputView = travelFromDatePicker
        
    }
    
    
    
    //MARK: - showreturndepDatePicker
    func showreturndepDatePicker(){
        //Formate Date
        travelToDatePicker.datePickerMode = .date
        travelToDatePicker.minimumDate = Date()
        travelToDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
            travelToDatePicker.date = rcalDepDate
            
            
            if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || self.travelToTF.text == "Select Date" {
                travelToDatePicker.date = rcalDepDate
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.travelToTF.inputAccessoryView = toolbar
        self.travelToTF.inputView = travelToDatePicker
        
    }
    
    
    
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}





extension HolidayContactdetailsTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == mobileTF {
            mobilenoMaxLength = cname.getMobileNumberMaxLength() ?? 8
            let maxLength = mobilenoMaxLength
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        }else if textField == emailTF {
            let maxLength = 100
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
