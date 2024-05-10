//
//  SelectPaymentMethodsVC.swift
//  Travgate
//
//  Created by FCI on 27/04/24.
//

import UIKit

class SelectPaymentMethodsVC: BaseTableVC, MobileProcessPassengerDetailVMDelegate, MobilePaymentVMDelegate {
    
    
    
    static var newInstance:  SelectPaymentMethodsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectPaymentMethodsVC
        return vc
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.passengerDetailsVM = MobileProcessPassengerDetailVM(self)
        MySingleton.shared.mobilepaymentvm = MobilePaymentVM(self)
        
    }
    
    
    func setupUI() {
        commonTableView.registerTVCells(["BookingDetailsFlightDataTVCell",
                                         "PaymentTypeTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "BDTransfersInf0TVCell",
                                         "EmptyTVCell"])
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect), tabselect == "Flight" {
                setupTVCells()
            }else {
                setupTransfersTVCells()
            }
            
            
        }
        
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
       
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect), tabselect == "Flight" {
            sameInputs_Again_CallSaerchAPI()
        }else {
            dismiss(animated: true)
        }
    }
    
    //MARK: - PaymentTypeTVCell
    override func didTapOnPayNowBtnAction(cell: PaymentTypeTVCell) {
       
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect), tabselect == "Flight" {
            CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API()
        }else {
            showToast(message: "Still Under Development")
        }
    }
    
    
    func MPBDetails(response: MobilePreProcessBookingModel) {
        
    }
    
    
    
    //MARK: - didTapOnFlightDetails BookingDetailsFlightDataTVCell
    override func didTapOnFlightDetails(cell: BookingDetailsFlightDataTVCell) {
        MySingleton.shared.callboolapi = true
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
}



//MARK: - CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API
extension SelectPaymentMethodsVC {
    
    
    func setupTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        
        if (MySingleton.shared.mpbFlightData?.summary?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.BookingDetailsFlightDataTVCell,
                                                        data1: MySingleton.shared.mpbFlightData?.summary))
            
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Lead Passenger",
                                                    key:"payment",
                                                    cellType:.BookedTravelDetailsTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    func CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API() {
        
        MySingleton.shared.loderString = "payment"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        showToast(message: "Still Under Development")
        
        //  MySingleton.shared.passengerDetailsVM?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam:MySingleton.shared.payload)
    }
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MobilePassengerdetailsModel) {
        
        DispatchQueue.main.async {
            BASE_URL = ""
            //   MySingleton.shared.mobilepaymentvm?.CALL_MOBILE_PAYMENT_API(dictParam: [:], url: response.url ?? "")
            
        }
        
    }
    
    
    
    func mobolePaymentDetails(response: PaymentModel) {
        self.gotoLoadWebViewVC(urlStr1: response.data ?? "")
    }
    
    
    func gotoLoadWebViewVC(urlStr1:String) {
        
        //        holderView.isHidden = false
        loderBool = false
        hideLoadera()
        
        
        
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = urlStr1
        present(vc, animated: true)
    }
}




//MARK: - sameInputs_Again_CallSaerchAPI
extension SelectPaymentMethodsVC {
    
    
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



extension SelectPaymentMethodsVC {
    
    func setupTransfersTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PaymentTypeTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.BDTransfersInf0TVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
}
