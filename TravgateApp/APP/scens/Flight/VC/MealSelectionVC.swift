//
//  MealSelectionVC.swift
//  Travgate
//
//  Created by FCI on 18/04/24.
//

import UIKit

class MealSelectionVC: BaseTableVC {
    
    
    @IBOutlet weak var continuetoPaymentBtnView: UIView!
    @IBOutlet weak var gifimg: UIImageView!
    
    
    static var newInstance: MealSelectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MealSelectionVC
        return vc
    }
    
    var mealsCodeA = [String]()
    var ssrCodeA = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
        
        
    }
    
    
    func setUI() {
        
        gifimg.isHidden = true
        continuetoPaymentBtnView.backgroundColor = .Buttoncolor
        continuetoPaymentBtnView.isUserInteractionEnabled = false
        guard let gifURL = Bundle.main.url(forResource: "pay", withExtension: "gif") else { return }
        guard let imageData = try? Data(contentsOf: gifURL) else { return }
        guard let image = UIImage.gifImageWithData(imageData) else { return }
        gifimg.image = image
        
        continuetoPaymentBtnView.isUserInteractionEnabled = false
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["OperatorsCheckBoxTVCell",
                                         "BookingDetailsFlightDataTVCell",
                                         "EmptyTVCell",
                                         "SelectMealTVCell",
                                         "NewSpecialAssistanceTVCell"])
        
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            loderBool = false
            hideLoadera()
            setupBookingInformationTVCell()
        }
        
        
    }
    
    
    //MARK: - didTapOnFlightDetails BookingDetailsFlightDataTVCell
    override func didTapOnFlightDetails(cell: BookingDetailsFlightDataTVCell) {
        MySingleton.shared.callboolapi = true
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - enableContinuetoPaymentBtn
    override func enableContinuetoPaymentBtn(cell: OperatorsCheckBoxTVCell) {
        
        if MySingleton.shared.enablePaymentButtonBool1 == true && MySingleton.shared.enablePaymentButtonBool2 == true {
            
            continuetoPaymentBtnView.backgroundColor = .BooknowBtnColor
            continuetoPaymentBtnView.isUserInteractionEnabled = true
            gifimg.isHidden = false
            
        }else {
            
            continuetoPaymentBtnView.backgroundColor = .Buttoncolor
            continuetoPaymentBtnView.isUserInteractionEnabled = false
            gifimg.isHidden = true
            
        }
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        travelerArray.removeAll()
        MySingleton.shared.positionsCount = 0
        MySingleton.shared.enablePaymentButtonBool1 = false
        MySingleton.shared.enablePaymentButtonBool2 = false
        
        sameInputs_Again_CallSaerchAPI()
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnContinuetoBookBtnAction(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            gotoSelectPaymentMethodsVC()
        }
        
    }
    
    func gotoSelectPaymentMethodsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    
    
    
    
    override func didTapOnCheckBoxBtnAction(cell: SelectMealTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnCheckBoxBtnAction(cell: NewSpecialAssistanceTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnServiceBtnAction(cell: NewSpecialAssistanceTVCell) {
        commonTableView.reloadData()
    }
    
    
    
}


extension MealSelectionVC {
    
    
    
    func setupBookingInformationTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        
        if (MySingleton.shared.mpbFlightData?.summary?.count ?? 0) > 0 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.BookingDetailsFlightDataTVCell,
                                                        data1: MySingleton.shared.mpbFlightData?.summary))
            
        }
        
        if MySingleton.shared.addMealBool == true {
            
            mealsCodeA.removeAll()
            travelerArray.forEach { i in
                mealsCodeA.append("")
            }
            
            let mealsCodeAString = "[\"" + mealsCodeA.joined(separator: "\",\"") + "\"]"
            MySingleton.shared.payload["selected_meals_code"] = mealsCodeAString
            MySingleton.shared.tablerow.append(TableRow(cellType:.SelectMealTVCell))
        }
        
        if MySingleton.shared.addSpecialAssistanceBool == true {
            
            ssrCodeA.removeAll()
            travelerArray.forEach { i in
                ssrCodeA.append("")
            }
            
            let ssrCodeAString = "[\"" + ssrCodeA.joined(separator: "\",\"") + "\"]"
            MySingleton.shared.payload["selected_special_assistance_code"] = ssrCodeAString
            MySingleton.shared.tablerow.append(TableRow(cellType:.NewSpecialAssistanceTVCell))
            
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.OperatorsCheckBoxTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
}


//MARK: - addObserver
extension MealSelectionVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointrnetreload), name: Notification.Name("nointrnetreload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
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
    
    
}




//MARK: - sameInputs_Again_CallSaerchAPI
extension MealSelectionVC {
    
    
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
