//
//  HotelBookingDetailsVC.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit



extension HotelBookingDetailsVC {
    
    func addObserver() {
        
        MySingleton.shared.guestbool = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(addon(_:)), name: NSNotification.Name("addon"), object: nil)
        
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
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = MySingleton.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        
        //        MySingleton.shared.setAttributedTextnew(str1: "\(formattedTime)",
        //                                                str2: "",
        //                                                lbl: sessionTimelbl,
        //                                                str1font: .OpenSansMedium(size: 12),
        //                                                str2font: .OpenSansMedium(size: 12),
        //                                                str1Color: .BooknowBtnColor,
        //                                                str2Color: .BooknowBtnColor)
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    @objc func addon(_ ns: NSNotification) {
        
        // Convert selectedAddonTotalPrice to Decimal
        let selectedAddonTotalPriceDecimal = Decimal(MySingleton.shared.selectedAddonTotalPrice)
        
        // Convert grand total to Decimal
        guard let grandTotalString = MySingleton.shared.roompaxesdetails[0].net,
              let grandTotalDecimal = Decimal(string: grandTotalString) else {
            return // Handle the case where grand total cannot be converted to Decimal
        }
        
        // Add totalkwdvalue to grand total
        let updatedGrandTotal = grandTotalDecimal + selectedAddonTotalPriceDecimal
        
        
        updateTotalAmount(updatedGrandTotal: updatedGrandTotal)
        
    }
    
    func updateTotalAmount(updatedGrandTotal:Decimal) {
        
        // Update totalAmount label
        kwdlbl.text = "\(MySingleton.shared.roompaxesdetails[0].currency ?? ""):\(updatedGrandTotal)"
        
        
    }
    
}



class HotelBookingDetailsVC: BaseTableVC, LoginViewModelDelegate, RegisterViewModelDelegate, HotelBookingViewModelDelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var kwdlbl: UILabel!
    
    static var newInstance: HotelBookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelBookingDetailsVC
        return vc
    }
    
    var regViewModel: RegisterViewModel?
    //  var mbviewmodel:MBViewModel?
    var hdvm:HotelBookingVM?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        addObserver()
        
        if callapibool == true {
            callHotelMobileBookingAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.loginvm = LoginViewModel(self)
        MySingleton.shared.registervm = RegisterViewModel(self)
        //  self.mbviewmodel = MBViewModel(self)
        self.hdvm = HotelBookingVM(self)
        MySingleton.shared.delegate = self
    }
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["BookingHotelDetailsTVCell",
                                         "EmptyTVCell",
                                         "HotelBookingCancellationpolicyTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "GuestTVCell",
                                         "AddonTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "PrimaryContactInfoTVCell",
                                         "RegisterNowTableViewCell",
                                         "LoginDetailsTableViewCell",
                                         "HotelFareSummaryTVCell",
                                         "ContactInformationTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "UserSpecificationTVCell"])
        
        
        
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        // dismiss(animated: false)
        search_same_input()
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
        MySingleton.shared.nationalityCode = cell.nationalityCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    //MARK: - tapOnContinuetoPaymentBtnAction
    @IBAction func tapOnContinuetoPaymentBtnAction(_ sender: Any) {
        didTapOnContinuetoPaymentBtnAction()
    }
    
    
    //MARK: - AddDeatilsOfGuestTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    //MARK: - didTapOnAddonServiceBtnAction
    override func didTapOnAddonServiceBtnAction(cell: AddonTVCell) {
        reloadFareSummaryCell()
    }
    
    
    func reloadFareSummaryCell() {
        if let fareSummaryCellIndex = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .HotelFareSummaryTVCell }) {
            let indexPath = IndexPath(row: fareSummaryCellIndex, section: 0)
            commonTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    //MARK: - didTapOnRegisterNowOrLoginButtonAction
    override func didTapOnRegisterNowOrLoginButtonAction(cell: RegisterSelectionLoginTableViewCell) {
        commonTableView.reloadData()
    }
    
    
    //MARK: - PrimaryContactInfoTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: PrimaryContactInfoTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        //  MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    override func didTapOnGuestBtnAction(cell:PrimaryContactInfoTVCell) {
        MySingleton.shared.guestbool = true
        showToast(message: "Successfully Registered!..")
        setuptv()
    }
    
    
    override func didTapOnLoginBtnAction(cell:PrimaryContactInfoTVCell) {
        
        if MySingleton.shared.payemail.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.regpassword.isEmpty == true {
            showToast(message: "Enter Password")
        }else {
            callLoginAPI()
        }
        
    }
    
    
    override func didTapOnRegisterBtnAction(cell:PrimaryContactInfoTVCell) {
        
        if MySingleton.shared.payemail.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.paymobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if MySingleton.shared.paymobilecountrycode.isEmpty == true {
            showToast(message: "Please Select Country Code")
        }else if MySingleton.shared.regpassword.isEmpty == true {
            showToast(message: "Enter Password")
        }else {
            callRegisterAPI()
        }
        
    }
}

//MARK: - setupUI
extension HotelBookingDetailsVC {
    
    
    
    
    //MARK: - setuptv
    func setuptv() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.BookingHotelDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.HotelBookingCancellationpolicyTVCell))
        
        
        let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloggedBool == false {
            
            if MySingleton.shared.guestbool == false {
                
                MySingleton.shared.tablerow.append(TableRow(cellType:.RegisterSelectionLoginTableViewCell))
                MySingleton.shared.tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
                
            }
            
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Guest Details",
                                                    cellType:.TotalNoofTravellerTVCell))
        
        for i in 1...MySingleton.shared.hoteladultscount {
            MySingleton.shared.positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)",
                                         key: "adult",
                                         characterLimit:MySingleton.shared.positionsCount,
                                         cellType: .AddDeatilsOfGuestTVCell)
            
            MySingleton.shared.tablerow.append(travellerCell)
            
        }
        
        
        if MySingleton.shared.hotelchildcount != 0 {
            for i in 1...MySingleton.shared.hotelchildcount {
                MySingleton.shared.positionsCount += 1
                MySingleton.shared.tablerow.append(TableRow(title:"Child \(i)"
                                                            ,key:"child",
                                                            characterLimit:MySingleton.shared.positionsCount,
                                                            cellType:.AddDeatilsOfGuestTVCell))
                
            }
        }
        
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.UserSpecificationTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.AddonTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.HotelFareSummaryTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 30, cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}





//MARK: - callHotelMobileBookingAPI
extension HotelBookingDetailsVC {
    
    func callHotelMobileBookingAPI() {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["search_id"] = hsearchid
        MySingleton.shared.payload["booking_source"] = hbookingsource
        MySingleton.shared.payload["token"] = htoken
        MySingleton.shared.payload["token_key"] = htokenkey
        MySingleton.shared.payload["rateKey"] = selectedrRateKeyArray
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.payload["room_selected"] = roomselected
        
        
        self.hdvm?.CALL_HOTEL_MOBILE_BOOKING_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func hotelBookingDetails(response: HotelBookingModel) {
        
        
        loderBool = false
        hideLoadera()
        MySingleton.shared.hotel_user_specification.removeAll()
        
        MySingleton.shared.bhotelDetials = response.data?.hotel_details
        MySingleton.shared.hotel_user_specification = response.data?.user_specification ?? []
        MySingleton.shared.roompaxesdetails = response.data?.room_paxes_details ?? []
        MySingleton.shared.hotelAddonServices = response.data?.addon_services ?? []
        
        
        MySingleton.shared.setAttributedTextnew(str1: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "",
                                                str2: String(format: "%.2f", response.data?.hotel_total_price ?? 0.0) ,
                                                lbl: kwdlbl,
                                                str1font: .LatoBold(size: 12),
                                                str2font: .LatoBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        DispatchQueue.main.async {
            self.setuptv()
        }
    }
    
    
}

//MARK: - search_same_input
extension HotelBookingDetailsVC {
    
    
    func search_same_input() {
        
        NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        MySingleton.shared.payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        
        MySingleton.shared.payload["hotel_checkin"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.payload["hotel_checkout"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        
        MySingleton.shared.payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        MySingleton.shared.payload["adult"] = adtArray
        MySingleton.shared.payload["child"] = chArray
        
        
        if defaults.string(forKey: UserDefaultsKeys.hotelchildcount) == "0" {
            
            MySingleton.shared.payload["childAge_1"] = [""]
            
        }else {
            
            for roomIndex in 0..<totalRooms {
                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                    var childAges: [String] = Array(repeating: "0", count: numChildren)
                    
                    if numChildren > 2 {
                        childAges.append("0")
                    }
                    
                    MySingleton.shared.payload["childAge_\(roomIndex + 1)"] = childAges
                }
            }
            
        }
        
        
        
        
        MySingleton.shared.payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode)
        
        
        //        MySingleton.shared.payload["language"] = "english"
        //        MySingleton.shared.payload["search_source"] = "Mobile_IOS"
        //        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        //        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationalitycode) == nil {
            showToast(message: "Please Select Nationality.")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: MySingleton.shared.payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoHotelResultVC()
            
        }
        
    }
    
    
    func gotoHotelResultVC() {
        
        loderBool = true
        callapibool = true
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        //   vc.countrycode = self.countrycode
        vc.payload =  MySingleton.shared.payload
        present(vc, animated: true)
    }
    
}



//MARK: - callLoginAPI callRegisterAPI
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


//MARK: - didTapOnContinuetoPaymentBtnAction
extension HotelBookingDetailsVC {
    
    
    func didTapOnContinuetoPaymentBtnAction() {
        hotelTapPayNow()
    }
    
    func hotelTapPayNow() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        
        
        var callpaymenthotelbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        //        let laedpassengerArrayString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        //        let spcialReqArrayStr = "[\"" + selectedSpecificatonArray.joined(separator: "\",\"") + "\"]"
        
        
        MySingleton.shared.payload["token"] = htoken
        MySingleton.shared.payload["booking_source"] = hbookingsource
        MySingleton.shared.payload["promo_code"] = ""
        MySingleton.shared.payload["redeem_points_post"] = "0"
        MySingleton.shared.payload["reward_usable"] = "0"
        MySingleton.shared.payload["reward_earned"] = "0"
        MySingleton.shared.payload["reducing_amount"] = "0"
        MySingleton.shared.payload["passenger_type"] = passengertypeString
        MySingleton.shared.payload["name_title"] = mrtitleString
        MySingleton.shared.payload["first_name"] = firstnameString
        MySingleton.shared.payload["last_name"] = lastNameString
        MySingleton.shared.payload["billing_country"] = MySingleton.shared.nationalityCode
        MySingleton.shared.payload["billing_email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["passenger_contact"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["country_code"] = MySingleton.shared.paymobilecountrycode
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        // Check additional conditions
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if MySingleton.shared.payemail == "" {
            showToast(message: "Enter Email Address")
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if MySingleton.shared.paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if MySingleton.shared.paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if fnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if lnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if MySingleton.shared.checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            self.hdvm?.CALL_HOTEL_PRE_MOBILE_BOOKING_API(dictParam:  MySingleton.shared.payload)
        }
        
    }
    
    
    func hotelpreBookingDetails(response: HotelMBPModel) {
        print(response.data?.post_data?.url ?? "")
    }
    
    
}




extension HotelBookingDetailsVC {
    
    
    //MARK: - callRegisterAPI registerSucess
    
    func callRegisterAPI() {
        
        basicloderBool = true
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["first_name"] = "firstname"
        MySingleton.shared.payload["last_name"] = "lastname"
        MySingleton.shared.payload["email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.payload["phone"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["country_code"] = MySingleton.shared.paymobilecountrycode
        
        MySingleton.shared.registervm?.CALL_USER_REGISTER_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    
    func registerSucess(response: RegisterModel) {
        
        basicloderBool = false
        
        
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            
            MySingleton.shared.guestbool = true
            showToast(message: "Register Sucess")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setuptv()
            }
        }
    }
    
    
    
    
    
    //MARK: - callLoginAPI loginSucess
    
    func callLoginAPI() {
        
        basicloderBool = true
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["username"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.loginvm?.CALL_USER_LOGIN_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    func loginSucess(response: LoginModel) {
        
        
        basicloderBool = false
        
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            MySingleton.shared.guestbool = true
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.logindetails?.user_id, forKey: UserDefaultsKeys.userid)
            
            
            defaults.set(response.logindetails?.email, forKey: UserDefaultsKeys.useremail)
            defaults.set(response.logindetails?.phone, forKey: UserDefaultsKeys.usermobile)
            defaults.set(response.logindetails?.country_code, forKey: UserDefaultsKeys.usermobilecode)
            
            MySingleton.shared.payemail = response.logindetails?.email ?? ""
            MySingleton.shared.paymobile = response.logindetails?.phone ?? ""
            MySingleton.shared.paymobilecountrycode = response.logindetails?.country_code ?? ""
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setuptv()
            }
        }
        
    }
}
