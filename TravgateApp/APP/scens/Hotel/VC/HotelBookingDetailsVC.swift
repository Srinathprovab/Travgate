//
//  HotelBookingDetailsVC.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

class HotelBookingDetailsVC: BaseTableVC, LoginViewModelDelegate, RegisterViewModelDelegate, MBViewModelDelegate, HotelBookingViewModelDelegate {
    
    
    
    static var newInstance: HotelBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelBookingDetailsVC
        return vc
    }
    
    var regViewModel: RegisterViewModel?
    var mbviewmodel:MBViewModel?
    var hdvm:HotelBookingVM?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if MySingleton.shared.callboolapi == true {
            callHotelMobileBookingAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.loginvm = LoginViewModel(self)
        MySingleton.shared.registervm = RegisterViewModel(self)
        self.mbviewmodel = MBViewModel(self)
        self.hdvm = HotelBookingVM(self)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {callapibool = false
        dismiss(animated: false)
    }
    
    
    
    //MARK: - GuestTVCell RegisterNowTableViewCell RegisterNowButtonAction
    override func GuestRegisterNowButtonAction(cell: GuestTVCell, email: String, pass: String, phone: String, countryCode: String) {
        
        defaults.set(true, forKey: UserDefaultsKeys.regStatus)
        defaults.set(email, forKey: UserDefaultsKeys.useremail)
        defaults.set(countryCode, forKey: UserDefaultsKeys.countryCode)
        defaults.set(phone, forKey: UserDefaultsKeys.usermobile)
        showToast(message: "Sucessfully Registered!..")
        
        commonTableView.reloadData()
        
        
    }
    override func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String) {
        callLoginAPI(email: email, pass: pass)
    }
    
    
    
    override func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String, countryCode: String) {
        
        defaults.set(true, forKey: UserDefaultsKeys.regStatus)
        defaults.set(email, forKey: UserDefaultsKeys.useremail)
        defaults.set(countryCode, forKey: UserDefaultsKeys.countryCode)
        defaults.set(phone, forKey: UserDefaultsKeys.usermobile)
        showToast(message: "Successfully Registered!..")
        
        commonTableView.reloadData()
        
    }
    
    
    
    override func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radiounselected")
        cell.loginRadioImage.image = UIImage(named: "radiounselected")
        cell.guestRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        self.mbviewmodel?.section = .guestLogin
        
        setuptv()
        
    }
    override func registerButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        cell.loginRadioImage.image = UIImage(named: "radiounselected")
        cell.guestRadioImage.image = UIImage(named: "radiounselected")
        self.mbviewmodel?.section = .register
        
        setuptv()
    }
    override func loginButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radiounselected")
        cell.loginRadioImage.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        cell.guestRadioImage.image = UIImage(named: "radiounselected")
        self.mbviewmodel?.section = .login
        
        
        setuptv()
    }
    
    
    
    
    //MARK: - MBViewModel Delegate methods
    func mobilepreprocessbookingDetails(response: MobilePreProcessBookingModel) {
        
    }
    
    func mobileprocesspassengerDetails(response: MBPModel) {
        
    }
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        
    }
    
    
    
    //MARK: - ContactInformationTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            MySingleton.shared.payemail = tf.text ?? ""
        }else {
            MySingleton.shared.paymobile = tf.text ?? ""
        }
    }
    
    
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    
}


extension HotelBookingDetailsVC {
    
    //MARK: - setupUI
    func setupUI() {
        
        commonTableView.registerTVCells(["BookingHotelDetailsTVCell",
                                         "EmptyTVCell",
                                         "HotelBookingCancellationpolicyTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "GuestTVCell",
                                         "RegisterNowTableViewCell",
                                         "LoginDetailsTableViewCell",
                                         "HotelFareSummaryTVCell",
                                         "ContactInformationTVCell",
                                         "UserSpecificationTVCell"])
        
        
        
    }
    
    //MARK: - setuptv
    func setuptv() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.BookingHotelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.HotelBookingCancellationpolicyTVCell))
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            //  MySingleton.shared.tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
            mbviewmodel?.section = .guestLogin
            
            MySingleton.shared.tablerow.append(TableRow(height: 14,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
            MySingleton.shared.tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            MySingleton.shared.tablerow.append(TableRow(height: 12,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
            if self.mbviewmodel?.section == .guestLogin {
                MySingleton.shared.tablerow.append(TableRow(cellType: .GuestTVCell))
                MySingleton.shared.tablerow.append(TableRow(height: 12,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
            }  else if self.mbviewmodel?.section == .login {
                MySingleton.shared.tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(height: 12,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
            } else if self.mbviewmodel?.section == .register {
                MySingleton.shared.tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(height: 12,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
            }
            
        }else {
            MySingleton.shared.tablerow.append(TableRow(height: 12,bgColor:.AppHolderViewColor, cellType:.EmptyTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.UserSpecificationTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.HotelFareSummaryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}



extension HotelBookingDetailsVC {
    func registerSucess(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            showToast(message: "Register Sucess")
            defaults.set(true, forKey: UserDefaultsKeys.regStatus)
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setuptv()
            }
        }
    }
    
    
    func loginSucess(response: LoginModel) {
        print(response)
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            //  defaults.set(response.email, forKey: UserDefaultsKeys.useremail)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            //            defaults.set(response.contry_code, forKey: UserDefaultsKeys.countryCode)
            //            defaults.set(response.contact, forKey: UserDefaultsKeys.usermobile)
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setuptv()
                
            }
        }
    }
}


//MARK: - call Profile Details API

extension HotelBookingDetailsVC {
    func callLoginAPI(email: String, pass: String) {
        MySingleton.shared.payload["username"] = email
        MySingleton.shared.payload["password"] = pass
        MySingleton.shared.loginvm?.CALL_USER_LOGIN_API(dictParam:  MySingleton.shared.payload)
        // callProfileDetailsAPI()
    }
    
    func callRegisterAPI(email: String, pass: String, mobile: String, countryCode: String) {
        MySingleton.shared.payload["email"] = email
        MySingleton.shared.payload["password"] = pass
        MySingleton.shared.payload["phone"] = mobile
        MySingleton.shared.payload["country_code"] = countryCode
        MySingleton.shared.registervm?.CALL_USER_REGISTER_API(dictParam:  MySingleton.shared.payload)
        // callProfileDetailsAPI()
    }
    
    
}


extension HotelBookingDetailsVC {
    
    func callHotelMobileBookingAPI() {
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["search_id"] = hsearchid
        MySingleton.shared.payload["booking_source"] = hbookingsource
        MySingleton.shared.payload["token"] = htoken
        MySingleton.shared.payload["token_key"] = htokenkey
        MySingleton.shared.payload["rateKey"] = selectedrRateKeyArray
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
       
        
        
        self.hdvm?.CALL_HOTEL_MOBILE_BOOKING_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func hotelBookingDetails(response: HotelBookingModel) {
        DispatchQueue.main.async {
            self.setuptv()
        }
    }
    
    
}
