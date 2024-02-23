//
//  VisaTVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit
import DropDown


protocol VisaTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnSubmitEnquiryBtnAction(cell:VisaTVCell)
    func didTapOnPassengersBtnAction(cell:VisaTVCell)
    func didTapOnNationalityBtnAction(cell:VisaTVCell)
    func donedatePicker(cell:VisaTVCell)
    func cancelDatePicker(cell:VisaTVCell)
    
}

class VisaTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var dateoftravelTF: UITextField!
    @IBOutlet weak var residencyTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var destinationTF: UITextField!
    @IBOutlet weak var remarkTF: UITextField!
    @IBOutlet weak var captchShowlbl: UILabel!
    @IBOutlet weak var captchTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passengersBtn: UIButton!
    @IBOutlet weak var totalPassengerlbl: UILabel!
    
    
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var countrycodeView: UIView!
    @IBOutlet weak var dateoftravelView: UIView!
    @IBOutlet weak var residencyView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var remarkView: UIView!
    @IBOutlet weak var captchView: UIView!
    
    var cname = String()
    var mobilenoMaxLength = Int()
    var nationalityDropDown = DropDown()
    var resendencyDropDown = DropDown()
    var visaDestinationDropDown = DropDown()
    var countryCodeDropDown = DropDown()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countryNamesWithCodeArray = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var nationalityCodeArray = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    let dateOfTravelPicker = UIDatePicker()
    
    var delegate:VisaTVCellDelegate?
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
        
        generateCaptcha()
        
        totalPassengerlbl.text = defaults.string(forKey: UserDefaultsKeys.visatotalpassengercount) ?? "1 Passenger"
    }
    
    func setupUI() {
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: countrycodeTF)
        setupTF(tf: dateoftravelTF)
        setupTF(tf: residencyTF)
        setupTF(tf: nationalityTF)
        setupTF(tf: destinationTF)
        setupTF(tf: remarkTF)
        setupTF(tf: captchTF)
        
        submitBtn.layer.cornerRadius = 6
        submitBtn.addTarget(self, action: #selector(didTapOnSubmitEnquiryBtnAction(_:)), for: .touchUpInside)
        passengersBtn.addTarget(self, action: #selector(didTapOnPassengersBtnAction(_:)), for: .touchUpInside)
        
        
        
        nationalityTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        nationalityTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        residencyTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        residencyTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        destinationTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        destinationTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        setupNationalityDropDown()
        setupResendencyDropDown()
        setupVisaDestinationDropDown()
        setupCountryCodeDropDown()
        showdepDatePicker()
        
    }
    
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        
       
        
        switch textField.tag {
        case 1:
            fnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 2:
            lnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 3:
            emailView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 4:
            countrycodeView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 5:
            mobileView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 10:
            remarkView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 11:
            captchView.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
            
        default:
            break
        }
        
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    
    @objc func didTapOnSubmitEnquiryBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSubmitEnquiryBtnAction(cell:self)
    }
    
    @objc func didTapOnPassengersBtnAction(_ sender:UIButton) {
        delegate?.didTapOnPassengersBtnAction(cell:self)
    }
    
}






//MARK: - setupAirlineDropDown
extension VisaTVCell {
    
    //MARK: - setupNationalityDropDown
    func setupNationalityDropDown() {
        
        nationalityDropDown.direction = .bottom
        nationalityDropDown.backgroundColor = .WhiteColor
        nationalityDropDown.anchorView = self.nationalityTF
        nationalityDropDown.bottomOffset = CGPoint(x: 0, y: nationalityTF.frame.size.height + 10)
        nationalityDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.nationalityTF.text = item
            self?.nationalityTF.resignFirstResponder()
            MySingleton.shared.visaNationalityCode = self?.nationalityCodeArray[index] ?? ""
            self?.nationalityView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self?.delegate?.didTapOnNationalityBtnAction(cell: self!)
        }
    }
    
    
    //MARK: - setupResendencyDropDown
    func setupResendencyDropDown() {
        
        resendencyDropDown.direction = .bottom
        resendencyDropDown.backgroundColor = .WhiteColor
        resendencyDropDown.anchorView = self.residencyTF
        resendencyDropDown.bottomOffset = CGPoint(x: 0, y: residencyTF.frame.size.height + 10)
        resendencyDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.residencyTF.text = item
            self?.residencyTF.resignFirstResponder()
            MySingleton.shared.visaResidencyCode = self?.nationalityCodeArray[index] ?? ""
            self?.residencyView.layer.borderColor = UIColor.AppBorderColor.cgColor

            
        }
    }
    
    
    //MARK: - setupVisaDestinationDropDown
    func setupVisaDestinationDropDown() {
        
        visaDestinationDropDown.direction = .bottom
        visaDestinationDropDown.backgroundColor = .WhiteColor
        visaDestinationDropDown.anchorView = self.destinationTF
        visaDestinationDropDown.bottomOffset = CGPoint(x: 0, y: destinationTF.frame.size.height + 10)
        visaDestinationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.destinationTF.text = item
            self?.destinationTF.resignFirstResponder()
            MySingleton.shared.visaDestinationCode = self?.nationalityCodeArray[index] ?? ""
            
            self?.destinationView.layer.borderColor = UIColor.AppBorderColor.cgColor

        }
    }
    
    
    //MARK: - setupVisaDestinationDropDown
    func setupCountryCodeDropDown() {
        
        countryCodeDropDown.direction = .bottom
        countryCodeDropDown.backgroundColor = .WhiteColor
        countryCodeDropDown.anchorView = self.countrycodeTF
        countryCodeDropDown.bottomOffset = CGPoint(x: 0, y: countrycodeTF.frame.size.height + 10)
        countryCodeDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.becomeFirstResponder()
            self?.mobileTF.text = ""
            self?.cname = self?.countryNames[index] ?? ""
            MySingleton.shared.visaCountryCode = self?.countrycodesArray[index] ?? ""
            self?.countrycodeView.layer.borderColor = UIColor.AppBorderColor.cgColor

        }
    }
    
    
    //MARK: - searchTextBegin  searchTextChanged  loadCountryNamesAndCode
    @objc func searchTextBegin(textField: UITextField) {
        
        if textField == nationalityTF {
            nationalityTF.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = MySingleton.shared.countrylist
            loadCountryNamesAndCode()
            nationalityDropDown.show()
        }else if textField == residencyTF {
            residencyTF.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = MySingleton.shared.countrylist
            loadCountryNamesAndCode()
            resendencyDropDown.show()
        }else if textField == destinationTF {
            destinationTF.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = MySingleton.shared.countrylist
            loadCountryNamesAndCode()
            visaDestinationDropDown.show()
        }else if textField == countrycodeTF {
            countrycodeTF.text = ""
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
        
        
        if tf == nationalityTF {
            loadCountryNamesAndCode()
            nationalityDropDown.show()
        }else if tf == residencyTF {
            loadCountryNamesAndCode()
            resendencyDropDown.show()
        }else if tf == destinationTF {
            loadCountryNamesAndCode()
            visaDestinationDropDown.show()
        }else if tf == countrycodeTF {
            loadCountryNamesAndCode()
            countryCodeDropDown.show()
        }
        
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
            nationalityDropDown.dataSource = countryNames
            resendencyDropDown.dataSource = countryNames
            visaDestinationDropDown.dataSource = countryNames
            countryCodeDropDown.dataSource = countryNamesWithCodeArray
        }
    }
    
}




extension VisaTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        dateOfTravelPicker.datePickerMode = .date
        dateOfTravelPicker.minimumDate = Date()
        dateOfTravelPicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let travelDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.travelDate) ?? "") {
            dateOfTravelPicker.date = travelDate
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.dateoftravelTF.inputAccessoryView = toolbar
        self.dateoftravelTF.inputView = dateOfTravelPicker
        
    }
    
    
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}



extension VisaTVCell {
    
    
    
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



extension VisaTVCell {
    
    func generateCaptcha() {
        // Generate a random arithmetic expression (you can customize this logic)
        let captchaExpression = generateRandomCaptchaExpression()
        
        // Display the captcha in the label
        captchShowlbl.text = captchaExpression
        
        // Clear user input field
        captchTF.text = ""
    }
    
    
    func generateRandomCaptchaExpression() -> String {
        // Customize this method to generate a random arithmetic expression
        let num1 = Int.random(in: 1...50)
        let num2 = Int.random(in: 1...50)
        return "\(num1) + \(num2)"
    }
    
    func evalCaptchaExpression(_ expression: String) -> Int? {
        // Evaluate the arithmetic expression
        let components = expression.components(separatedBy: " + ")
        guard components.count == 2,
              let num1 = Int(components[0]),
              let num2 = Int(components[1]) else {
            // Handle the case where the expression is not in the expected format
            return nil
        }
        return num1 + num2
    }
}
