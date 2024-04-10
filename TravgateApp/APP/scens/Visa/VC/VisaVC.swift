//
//  VisaVC.swift
//  TravgateApp
//
//  Created by FCI on 06/02/24.
//

import UIKit

class VisaVC: BaseTableVC, VisaEnquireyViewModelDelegate {
    
    
    static var newInstance: VisaVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? VisaVC
        return vc
    }
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var countrycode = String()
    var travelDateString = String()
    var remarks = String()
    var captchaValue = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.visavm = VisaEnquireyViewModel(self)
    }
    
    
    
    override func editingTextField(tf:UITextField){
        
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 10:
            remarks = tf.text ?? ""
            break
            
        case 5:
            mobile = tf.text ?? ""
            break
            
            
        case 11:
            captchaValue = tf.text ?? ""
            break
            
            
            
            
        default:
            break
        }
    }
    
    
    //MARK: - didTapOnPassengersBtnAction
    override func didTapOnPassengersBtnAction(cell:VisaTVCell) {
        gotoVisaPassengerSelectVC()
    }
    
    func gotoVisaPassengerSelectVC() {
        guard let vc = VisaPassengerSelectVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnSubmitEnquiryBtnAction(cell: VisaTVCell) {
        
         if fname.isEmpty == true {
            showToast(message: "Enter First Name")
            errorTextField(v: cell.fnameView)
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
            errorTextField(v: cell.lnameView)
        }else if email.isEmpty == true {
            showToast(message: "Enter Email Address")
            errorTextField(v: cell.emailView)
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            errorTextField(v: cell.emailView)
        }else if MySingleton.shared.visaCountryCode.isEmpty == true {
            showToast(message: "Enter Country Code")
            errorTextField(v: cell.countrycodeView)
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            errorTextField(v: cell.mobileView)
        }else if travelDateString.isEmpty == true {
            showToast(message: "Enter Date to travel")
            errorTextField(v: cell.dateoftravelView)
        }else if MySingleton.shared.visaNationalityCode.isEmpty == true {
            showToast(message: "Select Nationality")
            errorTextField(v: cell.nationalityView)
        }else if MySingleton.shared.visaResidencyCode.isEmpty == true {
            showToast(message: "Select Residancy")
            errorTextField(v: cell.residencyView)
        }else if MySingleton.shared.visaDestinationCode.isEmpty == true {
            showToast(message: "Select Visa Destination")
            errorTextField(v: cell.destinationView)
        }else if captchaValue.isEmpty == true {
            showToast(message: "Please Enter Captcha")
            errorTextField(v: cell.captchView)
        }else if self.verifyCaptcha() == false {
             showToast(message: "Please Enter Valid Captcha")
             errorTextField(v: cell.captchView)
         }else {
            callAPI()
        }
    }
    
    
    
    
    
    func errorTextField(v:UIView) {
        v.layer.borderColor = UIColor.BooknowBtnColor.cgColor
    }
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:VisaTVCell){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        defaults.set(formatter.string(from: cell.dateOfTravelPicker.date), forKey: UserDefaultsKeys.travelDate)
        
        cell.dateoftravelTF.text = defaults.string(forKey: UserDefaultsKeys.travelDate) ?? "Add Date"
        
        travelDateString =  cell.dateoftravelTF.text ?? ""
        cell.dateoftravelView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        
       
        commonTableView.reloadData()
        self.view.endEditing(true)
        
    }
    
    override func cancelDatePicker(cell:VisaTVCell){
        self.view.endEditing(true)
    }
    
    
}


extension VisaVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["VisaTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.VisaTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension VisaVC {
    
    
    func callAPI() {
        
        
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["first_name"] = fname
        MySingleton.shared.payload["last_name"] = lname
        MySingleton.shared.payload["email"] = email
        MySingleton.shared.payload["phonecode"] = MySingleton.shared.visaCountryCode
        MySingleton.shared.payload["phone_number"] = mobile
        MySingleton.shared.payload["nationality"] = MySingleton.shared.visaNationalityCode
        MySingleton.shared.payload["residency"] = MySingleton.shared.visaResidencyCode
        MySingleton.shared.payload["destination"] = MySingleton.shared.visaDestinationCode
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.visaadultCount)
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.visachildCount)
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.visainfantsCount)
        MySingleton.shared.payload["remark"] = remarks
        MySingleton.shared.payload["travel_date"] = travelDateString
        
        MySingleton.shared.visavm?.CALL_VISA_ENQUIREY_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func visaEnquireySucess(response: LoginModel) {
        
        showToast(message: response.msg ?? "")
        if response.status == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.dismiss(animated: true)
            }
        }
        
        
    }
    
    
    
    
}



extension VisaVC {
    
    
    func verifyCaptcha() -> Bool {
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? VisaTVCell{
            // Get the user input
            guard let userInput = cell.captchTF.text else {
                // Handle the case where user input is not available
                return false
            }

            // Get the captcha displayed on the label
            guard let captchaExpression = cell.captchShowlbl.text else {
                // Handle the case where captcha text is not available
                return false
            }

            // Evaluate the captcha expression
            if let expectedResult = cell.evalCaptchaExpression(captchaExpression),
               let userInputInt = Int(userInput),
               expectedResult == userInputInt {
                // Return true if captcha matches
                return true
            } else {
                // Return false if captcha does not match
                return false
            }
        }
        
        return false
        
    }
    
    
}




extension VisaVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
