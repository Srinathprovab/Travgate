//
//  BookingDetailsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/01/24.
//

import UIKit

class BookingDetailsVC: BaseTableVC, MPBViewModelDelegate, MobileSecureBookingViewModelDelegate, LoginViewModelDelegate, RegisterViewModelDelegate, MBViewModelDelegate {
    
    
    
    @IBOutlet weak var sessionlbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    
    
    var regViewModel: RegisterViewModel?
    var mbviewmodel:MBViewModel?
    
    //MARK: - Loading Functions
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.delegate = self
        MySingleton.shared.mpbvm = MPBViewModel(self)
        MySingleton.shared.viewmodel1 = MobileSecureBookingViewModel(self)
        
        
        MySingleton.shared.loginvm = LoginViewModel(self)
        MySingleton.shared.registervm = RegisterViewModel(self)
        
        self.mbviewmodel = MBViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["FareSummaryTVCell",
                                         "EmptyTVCell",
                                         "TDetailsLoginTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "ContactInformationTVCell",
                                         "UsePromoCodesTVCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "InternationalTravelInsuranceTVCell",
                                         "SpecialAssistanceTVCell",
                                         "AddonTVCell",
                                         "RegisterNowTableViewCell",
                                         "LoginDetailsTableViewCell",
                                         "GuestRegisterTableViewCell",
                                         "RegisterSelectionLoginTableViewCell",
                                         "BookingDetailsFlightDataTVCell",
                                         "OperatorsCheckBoxTVCell",
                                         "PrimaryContactInfoTVCell",
                                         "GuestTVCell"])
    }
    
    
    
    
    
    //MARK: - didTapOnFlightDetails BookingDetailsFlightDataTVCell
    override func didTapOnFlightDetails(cell: BookingDetailsFlightDataTVCell) {
        MySingleton.shared.callboolapi = true
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - AddDeatilsOfTravellerTVCell Delegate Methods
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
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
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    override func didTapOnFlyerProgramBtnAction(cell:AddDeatilsOfTravellerTVCell){
        
    }
    
    
    
    //MARK: - ContactInformationTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    override func editingTextField(tf:UITextField){
        
        
        
        switch tf.tag {
        case 1:
            MySingleton.shared.payemail = tf.text ?? ""
            break
            
        case 2:
            MySingleton.shared.paymobile = tf.text ?? ""
            break
            
        case 3:
            MySingleton.shared.regpassword = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    
    //MARK: - didTapOnAddonServiceBtnAction
    override func didTapOnAddonServiceBtnAction(cell: AddonTVCell) {
        reloadFareSummaryCell()
    }
    
    
    func reloadFareSummaryCell() {
        if let fareSummaryCellIndex = MySingleton.shared.tablerow.firstIndex(where: { $0.cellType == .FareSummaryTVCell }) {
            let indexPath = IndexPath(row: fareSummaryCellIndex, section: 0)
            commonTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        travelerArray.removeAll()
        MySingleton.shared.positionsCount = 0
        
        sameInputs_Again_CallSaerchAPI()
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnContinuetoBookBtnAction(_ sender: Any) {
        ContinueToPaymentBtnTap()
    }
    
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        gotoLoginVC()
    }
    
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - PrimaryContactInfoTVCell Delegate Methods
    override func didTapOnCountryCodeBtn(cell: PrimaryContactInfoTVCell) {
        MySingleton.shared.nationalityCode = cell.isoCountryCode
        MySingleton.shared.paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    override func didTapOnGuestBtnAction(cell:PrimaryContactInfoTVCell) {
        MySingleton.shared.guestbool = true
        showToast(message: "Successfully Registered!..")
        
        setupTVCell()
    }
    
    
    override func didTapOnLoginBtnAction(cell:PrimaryContactInfoTVCell) {
        callLoginAPI()
    }
    
    
    override func didTapOnRegisterBtnAction(cell:PrimaryContactInfoTVCell) {
        callRegisterAPI()
    }
    
    
    //MARK: - PaymentModel
    func paymentDetails(response: PaymentModel) {
        
    }
    
    func mobilepreprocessbookingDetails(response: MobilePreProcessBookingModel) {
        
    }
    
    func mobileprocesspassengerDetails(response: MBPModel) {
        
    }
    
    
}



extension BookingDetailsVC {
    
    func callAPI() {
        holderView.isHidden = true
        
        
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        if MySingleton.shared.callboolapi == true {
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["search_id"] =  MySingleton.shared.searchid
            MySingleton.shared.payload["selectedResult"] =  MySingleton.shared.selectedResult
            MySingleton.shared.payload["booking_source"] =  MySingleton.shared.bookingsource
            MySingleton.shared.payload["traceId"] =  MySingleton.shared.traceid
            MySingleton.shared.payload["user_id"] =  defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
            MySingleton.shared.mpbvm?.CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam:MySingleton.shared.payload)
        }
    }
    
    
    func MPBDetails(response: MobilePreProcessBookingModel) {
        holderView.isHidden = false
        loderBool = false
        hideLoadera()
        
        
        
        if response.status == 0 {
            
            self.gotoNoInternetScreen(keystr: "noseat")
            
        }else {
            MySingleton.shared.afterResultsBool = false
            MySingleton.shared.mpbpriceDetails = response.pre_booking_params?.priceDetails
            MySingleton.shared.mpbFlightData = response.flight_data?[0].flight_details
            MySingleton.shared.frequent_flyersArray = response.frequent_flyers ?? []
            MySingleton.shared.addonServices = response.pre_booking_params?.addon_services ?? []
            MySingleton.shared.tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
            MySingleton.shared.accesskeytp = response.access_key_tp ?? ""
            MySingleton.shared.bookingsource = response.booking_source ?? ""
            
            MySingleton.shared.afterAddonAmountAdded = Int(response.pre_booking_params?.priceDetails?.grand_total ?? "0") ?? 0
            
            MySingleton.shared.stopTimer()
            MySingleton.shared.startTimer(time: 900)
            
            DispatchQueue.main.async {[self] in
                setupTVCell()
            }
        }
        
        
    }
    
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.positionsCount = 0
        
        
        if (MySingleton.shared.mpbFlightData?.summary?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.BookingDetailsFlightDataTVCell,
                                                        data1: MySingleton.shared.mpbFlightData?.summary))
            
        }
        
        
        
        if MySingleton.shared.guestbool == false {
            MySingleton.shared.tablerow.append(TableRow(cellType:.PrimaryContactInfoTVCell))
        }
        
        
        
        MySingleton.shared.passengertypeArray.removeAll()
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Traveller Details",
                                                    subTitle: defaults.string(forKey: UserDefaultsKeys.totalTravellerCount),
                                                    cellType:.TotalNoofTravellerTVCell))
        
        
        
        for i in 1...Int(MySingleton.shared.adultsCount) {
            MySingleton.shared.positionsCount += 1
            MySingleton.shared.passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)",
                                         key: "adult",
                                         characterLimit: MySingleton.shared.positionsCount,
                                         cellType: .AddDeatilsOfTravellerTVCell)
            MySingleton.shared.searchTextArray.append("Adult \(i)")
            MySingleton.shared.tablerow.append(travellerCell)
            
        }
        
        
        if Int(MySingleton.shared.childCount)  != 0 {
            for i in 1...Int(MySingleton.shared.childCount)  {
                MySingleton.shared.positionsCount += 1
                MySingleton.shared.passengertypeArray.append("Child")
                MySingleton.shared.tablerow.append(TableRow(title:"Child \(i)",
                                                            key:"child",
                                                            characterLimit: MySingleton.shared.positionsCount,
                                                            cellType:.AddDeatilsOfTravellerTVCell))
                MySingleton.shared.searchTextArray.append("Child \(i)")
            }
        }
        
        if Int(MySingleton.shared.infantsCount)  != 0 {
            for i in 1...Int(MySingleton.shared.infantsCount)  {
                MySingleton.shared.positionsCount += 1
                MySingleton.shared.passengertypeArray.append("Infant")
                MySingleton.shared.tablerow.append(TableRow(title:"Infant \(i)",
                                                            key:"infant",
                                                            characterLimit:  MySingleton.shared.positionsCount,
                                                            cellType:.AddDeatilsOfTravellerTVCell))
                MySingleton.shared.searchTextArray.append("Infant \(i)")
            }
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.UsePromoCodesTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.InternationalTravelInsuranceTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SpecialAssistanceTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.AddonTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.FareSummaryTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.OperatorsCheckBoxTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}





extension BookingDetailsVC {
    
    
    func ContinueToPaymentBtnTap() {
        loderBool = true
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        
        
        // Check if there are any rows in section 0
        if commonTableView.numberOfRows(inSection: 0) == 0 {
            callpaymentbool = false
        } else {
            // Iterate over the cells if there are rows in section 0
            
            let positionsCount = commonTableView.numberOfRows(inSection: 0)
            for position in 0..<positionsCount {
                // Fetch the cell for the given position
                if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                    
                    if cell.titleTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.titleView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                        
                    } else {
                        // Textfield is not empty
                    }
                    
                    if cell.fnameTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.fnameView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                        cell.fnameView.layer.borderColor = UIColor.red.cgColor
                        fnameCharBool = false
                    }else {
                        fnameCharBool = true
                    }
                    
                    if cell.lnameTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.lnameView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                        cell.lnameView.layer.borderColor = UIColor.red.cgColor
                        lnameCharBool = false
                    } else {
                        // Textfield is not empty
                        lnameCharBool = true
                    }
                    
                    
                    if cell.dobTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.dobView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                    
                    if cell.passportnoTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                    
                    if cell.passportIssuingCountryTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                    
                    if cell.passportExpireDateTF.text?.isEmpty == true {
                        // Textfield is empty
                        cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                        callpaymentbool = false
                    } else {
                        // Textfield is not empty
                    }
                    
                }
            }
            
            // Check if there are any rows in section 0
            if positionsCount == 0 {
                callpaymentbool = false
            }
        }
        
        
        // Iterate over travelerArray to check if any required field is empty
        for traveler in travelerArray {
            if traveler.firstName == nil || traveler.firstName?.isEmpty == true ||
                traveler.lastName == nil || traveler.lastName?.isEmpty == true ||
                traveler.dob == nil || traveler.dob?.isEmpty == true ||
                traveler.passportno == nil || traveler.passportno?.isEmpty == true ||
                traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true ||
                traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true {
                callpaymentbool = false
                break // Exit loop if any field is empty
            } else if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }  else if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
        }
        
        
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        //   let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        // let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + MySingleton.shared.passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["tmp_flight_pre_booking_id"] = MySingleton.shared.tmpFlightPreBookingId
        MySingleton.shared.payload["access_key"] = MySingleton.shared.accesskeytp
        MySingleton.shared.payload["access_key_tp"] =  MySingleton.shared.accesskeytp
        MySingleton.shared.payload["insurance_policy_type"] = "0"
        MySingleton.shared.payload["insurance_policy_option"] = "0"
        MySingleton.shared.payload["insurance_policy_cover_type"] = "0"
        MySingleton.shared.payload["insurance_policy_duration"] = "0"
        MySingleton.shared.payload["isInsurance"] = "0"
        MySingleton.shared.payload["selectedResult"] = MySingleton.shared.selectedResult
        MySingleton.shared.payload["redeem_points_post"] = "1"
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsource
        MySingleton.shared.payload["promocode_val"] = ""
        MySingleton.shared.payload["promocode_code"] = ""
        MySingleton.shared.payload["mealsAmount"] = "0"
        MySingleton.shared.payload["baggageAmount"] = "0"
        
        
        // Assign string representations toMySingleton.shared.payload dictionary
        MySingleton.shared.payload["lead_passenger"] = laedpassengerString
        MySingleton.shared.payload["gender"] = genderString
        MySingleton.shared.payload["passenger_nationality"] = passportIssuingCountryString
        MySingleton.shared.payload["name_title"] = mrtitleString
        MySingleton.shared.payload["first_name"] = firstnameString
        MySingleton.shared.payload["middle_name"] = middlenameString
        MySingleton.shared.payload["last_name"] = lastNameString
        MySingleton.shared.payload["date_of_birth"] = dobString
        MySingleton.shared.payload["passenger_passport_number"] = passportnoString
        MySingleton.shared.payload["passenger_passport_issuing_country"] = passportIssuingCountryString
        MySingleton.shared.payload["passenger_passport_expiry"] = passportExpireDateString
        MySingleton.shared.payload["passenger_type"] = passengertypeArrayString
        
        
        MySingleton.shared.payload["Frequent"] = "\([["Select"]])"
        MySingleton.shared.payload["ff_no"] = "\([[""]])"
        
        MySingleton.shared.payload["address2"] = "ecity"
        MySingleton.shared.payload["billing_address_1"] = "DA"
        MySingleton.shared.payload["billing_state"] = "ASDAS"
        MySingleton.shared.payload["billing_city"] = "sdfsd"
        MySingleton.shared.payload["billing_zipcode"] = "sdf"
        
        MySingleton.shared.payload["billing_email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["passenger_contact"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["billing_country"] = MySingleton.shared.nationalityCode
        MySingleton.shared.payload["country_mobile_code"] = MySingleton.shared.paymobilecountrycode
        MySingleton.shared.payload["insurance"] = "0"
        MySingleton.shared.payload["tc"] = "on"
        MySingleton.shared.payload["booking_step"] = "book"
        MySingleton.shared.payload["payment_method"] = "PNHB1"
        MySingleton.shared.payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        MySingleton.shared.payload["insurance_name"] = ""
        MySingleton.shared.payload["insurance_code"] = ""
        MySingleton.shared.payload["insurance_totalprice"] = ""
        MySingleton.shared.payload["insurance_baseprice"] = ""
        MySingleton.shared.payload["hidseatprice"] = ""
        MySingleton.shared.payload["device_source"] = "MOBILE(A)"
        
        
        // Check additional conditions
        if !callpaymentbool {
            showToast(message: "Add Details")
            return
        }else if MySingleton.shared.passportExpireDateBool == false {
            showToast(message: "Invalid expiry. Passport expires within the next 3 months.")
            return
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
            return
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
            return
        }else if MySingleton.shared.payemail == "" {
            showToast(message: "Enter Email Address")
            return
        }else if MySingleton.shared.payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
            return
        }else if MySingleton.shared.paymobile == "" {
            showToast(message: "Enter Mobile No")
            return
        }else if MySingleton.shared.paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
            return
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
            return
        }else {
            
            MySingleton.shared.afterResultsBool = true
            loderBool = true
            showLoadera()
            
            MySingleton.shared.mpbvm?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam:MySingleton.shared.payload)
        }
    }
    
    
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MobilePassengerdetailsModel) {
        
        DispatchQueue.main.async {
            BASE_URL = ""
            MySingleton.shared.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: "\(response.url ?? "")")
        }
        
    }
    
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        
        loderBool = false
        hideLoadera()
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            
            MySingleton.shared.payload.removeAll()
            
            //        amount:100.00
            //        currency_code:KWD
            //        pg_codes:knet-test
            //        type:e_commerce
            //        mailto:customer_email:s@provab.com
            //        customer_first_name:Sudhir
            //        customer_last_name:Singh
            //        customer_phone:8840955727
            //        language:en
            //        extra:"full_name":"Kamran","ticket_information":"Tciket-1"
            //        order_no:SSA3312348
            //payment_type:one_off
            
            
            MySingleton.shared.payload["amount"] = String(format: "%.2f", Double(MySingleton.shared.mpbpriceDetails?.grand_total ?? "") ?? 0.0)
            MySingleton.shared.payload["currency_code"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
            MySingleton.shared.payload["pg_codes"] = "knet-test"
            MySingleton.shared.payload["type"] = "e_commerce"
            MySingleton.shared.payload["customer_email"] = MySingleton.shared.payemail
            MySingleton.shared.payload["customer_first_name"] = "srinath"
            MySingleton.shared.payload["customer_last_name"] = "provab"
            MySingleton.shared.payload["customer_phone"] = MySingleton.shared.paymobile
            MySingleton.shared.payload["language"] = "en"
            MySingleton.shared.payload["extra"] = ""
            
            
            let random5DigitNumber = generateRandomNumber()
            MySingleton.shared.payload["order_no"] = "\(random5DigitNumber)"
            
            MySingleton.shared.mpbvm?.CALL_MOBILE_PAYMENT_API(dictParam: MySingleton.shared.payload, url: response.pay_url ?? "")
        }
        
        
    }
    
    
    
    func mobolePaymentDetails(response: PaymentModel) {
        
        
        MySingleton.shared.merchantid = response.order_no ?? ""
        MySingleton.shared.sessionid = response.session_id ?? ""
        
        DispatchQueue.main.async {
            self.gotoOttuPaymentGatewayVC()
        }
        
        
    }
    
    
    func generateRandomNumber() -> Int {
        let randomNumber = Int.random(in: 10000...99999)
        return randomNumber
    }
    
    func gotoOttuPaymentGatewayVC() {
        guard let vc = OttuPaymentGatewayVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        
        BASE_URL = ""
        MySingleton.shared.payload["search_id"] = response.data?.search_id
        MySingleton.shared.payload["app_reference"] = response.data?.app_reference
        MySingleton.shared.payload["promocode_val"] = response.data?.promocode_val
        MySingleton.shared.payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: MySingleton.shared.payload, url: "https://travrun.com/pro_new/mobile/index.php/flight/mobile_pre_payment_confirmation")
        }
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            BASE_URL = ""
            mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: [:], url: response.url ?? "")
        }
        
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            DispatchQueue.main.async {
                BASE_URL = ""
                MySingleton.shared.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
            }
        }
        
    }
    
    
    
}




//MARK: - addObserver
extension BookingDetailsVC:TimerManagerDelegate {
    
    func addObserver() {
        
        MySingleton.shared.guestbool = false
        MySingleton.shared.selectedAddonServices.removeAll()
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if MySingleton.shared.callboolapi == true {
            callAPI()
        }
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func nointrnetreload() {
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
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
    
    //MARK: - gotoNoInternetScreen
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = MySingleton.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        
        MySingleton.shared.setAttributedTextnew(str1: "Your Session Expires In : ",
                                                str2: "\(formattedTime)",
                                                lbl: sessionlbl,
                                                str1font: .OpenSansMedium(size: 12),
                                                str2font: .OpenSansMedium(size: 12),
                                                str1Color: .TitleColor,
                                                str2Color: .BooknowBtnColor)
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}


//MARK: - sameInputs_Again_CallSaerchAPI
extension BookingDetailsVC {
    
    
    func sameInputs_Again_CallSaerchAPI() {
        
        MySingleton.shared.payload.removeAll()
        
        
        
        MySingleton.shared.payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1"
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        MySingleton.shared.payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        MySingleton.shared.payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        MySingleton.shared.payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        MySingleton.shared.payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        MySingleton.shared.payload["depature"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
        MySingleton.shared.payload["out_jrn"] = "All Times"
        MySingleton.shared.payload["ret_jrn"] = "All Times"
        MySingleton.shared.payload["direct_flight"] = MySingleton.shared.directflightString
        MySingleton.shared.payload["carrier"] = ""
        MySingleton.shared.payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.fcariercode) ?? "ALL"
        MySingleton.shared.payload["search_flight"] = "Search"
        MySingleton.shared.payload["search_source"] = "Mobile_IOS"
        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        if defaults.string(forKey: UserDefaultsKeys.journeyType) == "oneway" {
            
            MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            MySingleton.shared.payload["return"] = ""
            
            if defaults.string(forKey: UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.toCity) == nil {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else {
                gotoFlightResultVC()
            }
            
        }else {
            MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            // MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
            MySingleton.shared.payload["return"] = MySingleton.shared.convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd/MM/yyyy")
            
            if defaults.string(forKey: UserDefaultsKeys.fromCity) == nil {
                showToast(message: "Enter From City")
            }else if defaults.string(forKey: UserDefaultsKeys.toCity) == nil {
                showToast(message: "Enter To City")
            }else if defaults.string(forKey: UserDefaultsKeys.calDepDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calDepDate) == nil {
                showToast(message: "Add Departure Date")
            }else if defaults.string(forKey: UserDefaultsKeys.calRetDate) == "Add Date" || defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil {
                showToast(message: "Add Return Date")
            }else {
                gotoFlightResultVC()
            }
            
            
            
            
        }
        
        
        func gotoFlightResultVC() {
            MySingleton.shared.callboolapi = true
            MySingleton.shared.afterResultsBool = false
            defaults.set(false, forKey: "flightfilteronce")
            guard let vc = FlightResultVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
    
    
    
    
}



extension BookingDetailsVC {
    
    //MARK: - callRegisterAPI registerSucess
    
    func callRegisterAPI() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["email"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.payload["phone"] = MySingleton.shared.paymobile
        MySingleton.shared.payload["country_code"] = MySingleton.shared.paymobilecountrycode
        
        print( MySingleton.shared.payload)
        
        
        MySingleton.shared.registervm?.CALL_USER_REGISTER_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    
    func registerSucess(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            
            //            defaults.set(true, forKey: UserDefaultsKeys.regStatus)
            //            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            MySingleton.shared.guestbool = true
            showToast(message: "Register Sucess")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                setupTVCell()
            }
        }
    }
    
    
    
    //MARK: - callLoginAPI loginSucess
    
    func callLoginAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["username"] = MySingleton.shared.payemail
        MySingleton.shared.payload["password"] = MySingleton.shared.regpassword
        MySingleton.shared.loginvm?.CALL_USER_LOGIN_API(dictParam:  MySingleton.shared.payload)
        
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
                setupTVCell()
                
            }
        }
    }
}
