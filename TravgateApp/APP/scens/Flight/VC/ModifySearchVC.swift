//
//  ModifySearchVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class ModifySearchVC: BaseTableVC {
    
    
    
    @IBOutlet weak var onewayView: BorderedView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripView: BorderedView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: BorderedView!
    @IBOutlet weak var multicitylbl: UILabel!
    @IBOutlet weak var closebrn: UIButton!
    
    static var newInstance: ModifySearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    

    
    func onewayTap() {
        onewayView.backgroundColor = .Buttoncolor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .TitleColor
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        setupOnewayTVCells()
    }
    
    func roundtripTap() {
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .Buttoncolor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .TitleColor
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        setupRoundTripTVCells()
    }
    
    func multicityTap() {
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .Buttoncolor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .WhiteColor
        
        // setupOnewayTVCells()
    }
    
    
    
    //MARK: - didTapOnClassBtnAction
    override func didTapOnClassBtnAction(cell:FlightSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnAdvanceOption
    override func didTapOnAdvanceOption(cell: FlightSearchTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:FlightSearchTVCell){
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:FlightSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    
    
    override func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell) {
        onewayTap()
    }
    
    
    override func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {
        didTapOnFlightSearchBtnAction()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        onewayTap()
    }
    
    
    @IBAction func didTapOnRoundTripBtnAction(_ sender: Any) {
        roundtripTap()
    }
    
    
    @IBAction func didTapOnMulticityBtnAction(_ sender: Any) {
        multicityTap()
    }
    
}


extension ModifySearchVC {
    
    
    func setupUI(){
        
        closebrn.imageView?.tintColor = .WhiteColor
        roundtripTap()
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["FlightSearchTVCell",
                                         "EmptyTVCell"])
        
    }
    
    
    func setupOnewayTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"oneway",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func setupRoundTripTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"circle",cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}



extension ModifySearchVC {
    
    func didTapOnFlightSearchBtnAction() {
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        MySingleton.shared.payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        MySingleton.shared.payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        MySingleton.shared.payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        MySingleton.shared.payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        MySingleton.shared.payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
        MySingleton.shared.payload["out_jrn"] = "All Times"
        MySingleton.shared.payload["ret_jrn"] = "All Times"
        MySingleton.shared.payload["direct_flight"] = ""
        MySingleton.shared.payload["psscarrier"] = ""
        MySingleton.shared.payload["search_flight"] = "Search"
        MySingleton.shared.payload["user_id"] = ""
        MySingleton.shared.payload["search_source"] = "Postman"
        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
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
            MySingleton.shared.payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
            
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
        
        
    }
    
    
    func gotoFlightResultVC() {
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = FlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
