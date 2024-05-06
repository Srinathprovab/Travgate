//
//  FareListVC.swift
//  Travgate
//
//  Created by FCI on 04/05/24.
//

import UIKit

class FareListVC: BaseTableVC, SelectFareViewModelDelegate {
    
    
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var selectdeplbl: UILabel!
    
    
    static var newInstance: FareListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Fare.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FareListVC
        return vc
    }
    
    var keyString = String()
    var selectedFares: [SelectFare] = []
    
    override func viewWillAppear(_ animated: Bool) {
        callGetFareListAPI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.farelistvm = SelectFareViewModel(self)
    }
    
    func setupUI() {
        
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            retBtn.isHidden = true
        }else {
            retBtn.isHidden = false
        }
        setupBtn(btn: depBtn, title1: "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "")-\(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")")
        setupBtn(btn: retBtn, title1: "\(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")-\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "")")
        
        commonTableView.registerTVCells(["SelectFareInfoTVCell",
                                         "EmptyTVCell"])
        
        
        tapOnDep()
    }
    
    
    func setupBtn(btn:UIButton,title1:String) {
        btn.setTitle(title1, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        tapOnDep()
    }
    
    func tapOnDep() {
        
        depBtn.backgroundColor = UIColor.Buttoncolor
        depBtn.setTitleColor(.WhiteColor, for: .normal)
        retBtn.backgroundColor = UIColor.WhiteColor
        retBtn.setTitleColor(.TitleColor, for: .normal)
        
        selectdeplbl.text = "Select Fare for departure"
        btnTapString = "departure"
        
        setupTVcells()
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        taponReturn()
    }
    
    func taponReturn() {
        
        depBtn.backgroundColor = UIColor.WhiteColor
        depBtn.setTitleColor(.TitleColor, for: .normal)
        retBtn.backgroundColor = UIColor.Buttoncolor
        retBtn.setTitleColor(.WhiteColor, for: .normal)
        
        selectdeplbl.text = "Select Fare for Return"
        btnTapString = "return"
        
        setupTVcells()
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    override func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell) {
        
    }
    
    override func didTapOnSelectFareBtnAction(cell: SelectFareInfoTVCell) {
        
        // Create a SelectFare instance
        let fare1 = SelectFare(fareName: cell.fareNamelbl.text,
                               cabinClass: cell.classlbl.text,
                               RefundableType: cell.refundTypelbl.text,
                               Baggage: cell.baggagelbl.text,
                               Price: cell.pricelbl.text,
                               amount: cell.fareamount,
                               selectedBool: true,
                               journyType: cell.journyType)
        
        
        MySingleton.shared.selectedFares.append(fare1)
        keyString = cell.journyType
        
        
        
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            gotoFinalFareListVC()
        }else {
            gotoSelectedFaresVC()
        }
        
        
    }
    
    
    func gotoSelectedFaresVC() {
        guard let vc = SelectFareListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyString = self.keyString
        present(vc, animated: false)
    }
    
    func gotoFinalFareListVC() {
        guard let vc = FinalFareListVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyString = self.keyString
        present(vc, animated: false)
    }
    
    
}


extension FareListVC {
    
    
    
    func callGetFareListAPI() {
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["serialized_journeyKey"] = MySingleton.shared.farekey
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsource
        
        MySingleton.shared.farelistvm?.CALL_GET_FARLIST_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func fareListResponse(response: SelectFareModel) {
        
        loderBool = false
        hideLoadera()
        
        
        response.j_flight_list?.forEach({ i in
            MySingleton.shared.fareFlightlistArray = i.first?.fareFamily?.onward ?? []
            MySingleton.shared.fareReturnFlightlistArray = i.first?.fareFamily?.freturn ?? []
        })
        
        DispatchQueue.main.async {
            self.setupTVcells()
        }
    }
    
    
    
    
    func setupTVcells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        if btnTapString == "departure" {
            MySingleton.shared.fareFlightlistArray.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(title:"Extra",
                                                            subTitle: i.productClass,
                                                            text: "Pay to Cancel upto 24 hours prior to departure",
                                                            headerText: "departure",
                                                            buttonTitle: "Carry-on (\(i.carryOnBaggage ?? "") Checked in (\(i.checkedBaggage ?? ""))",
                                                            key1:"unselected",
                                                            tempText: "\(i.price?.api_total_display_fare ?? 0.0)",
                                                            cellType:.SelectFareInfoTVCell))
                
            }
        }else {
            MySingleton.shared.fareReturnFlightlistArray.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(title:"Extra",
                                                            subTitle: i.productClass,
                                                            text: "Pay to Cancel upto 24 hours prior to departure",
                                                            headerText: "return",
                                                            buttonTitle: "Carry-on (\(i.carryOnBaggage ?? "") Checked in (\(i.checkedBaggage ?? ""))",
                                                            key1:"unselected",
                                                            tempText: "\(i.price?.api_total_display_fare ?? 0.0)",
                                                            cellType:.SelectFareInfoTVCell))
                
            }
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
