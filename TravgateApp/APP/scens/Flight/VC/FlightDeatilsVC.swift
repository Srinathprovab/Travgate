//
//  FlightDeatilsVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightDeatilsVC: BaseTableVC, FlightDetailsViewModelDelegate {
    
    
    @IBOutlet weak var selectBtnsHolderView: UIView!
    @IBOutlet weak var ittaneryView: BorderedView!
    @IBOutlet weak var ittanerylbl: UILabel!
    @IBOutlet weak var fareBrakDownView: BorderedView!
    @IBOutlet weak var fareBrakDownlbl: UILabel!
    @IBOutlet weak var fareRulesView: BorderedView!
    @IBOutlet weak var fareRuleslbl: UILabel!
    @IBOutlet weak var baggageView: BorderedView!
    @IBOutlet weak var baggagelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    
    
    
    var fd = [[ItinearyFlightDetails]]()
    
    static var newInstance: FlightDeatilsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDeatilsVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
        
        MySingleton.shared.fdvm = FlightDetailsViewModel(self)
        
    }
    
    
    func setUI() {
        
        selectBtnsHolderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        selectBtnsHolderView.layer.cornerRadius = 10
        selectBtnsHolderView.clipsToBounds = true
        
        
        commonTableView.registerTVCells(["TicketIssuingTimeTVCell",
                                         "ItineraryTVCell",
                                         "FRulesTVCell",
                                         "EmptyTVCell",
                                         "BaggageInfoTVCell",
                                         "BaggageInfoImageTVCell",
                                         "FareRulesTVCell",
                                         "FareBreakdownTVCell"])
        
        
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnIttnaryBtnAction(_ sender: Any) {
        ittanneryTap()
    }
    
    
    @IBAction func didTapOnFareBreakDownBtnAction(_ sender: Any) {
        fareBreakdownTap()
    }
    
    @IBAction func didTapOnFareRulesBtnAction(_ sender: Any) {
        fareRulesTap()
    }
    
    @IBAction func didTapOnBaggageBtnAction(_ sender: Any) {
        baggageTap()
    }
    
    
    
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        gotoBookingDetailsVC()
    }
    
    
    
    func gotoBookingDetailsVC() {
        MySingleton.shared.callboolapi = true
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    
    //MARK: - show FARE RULES Content Btn Action
    override func showContentBtnAction(cell: FareRulesTVCell) {
        
        cell.dropdownBool.toggle()
        if cell.dropdownBool  {
            cell.show()
        }else {
            cell.hide()
        }
        
        
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
}


extension FlightDeatilsVC {
    
    func ittanneryTap(){
        
        ittaneryView.backgroundColor = .Buttoncolor
        fareBrakDownView.backgroundColor = .WhiteColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageView.backgroundColor = .WhiteColor
        
        ittanerylbl.textColor = .WhiteColor
        fareBrakDownlbl.textColor = .TitleColor
        fareRuleslbl.textColor = .TitleColor
        baggagelbl.textColor = .TitleColor
        
        setupBookingInformationTVCell()
        
    }
    
    func fareBreakdownTap(){
        
        ittaneryView.backgroundColor = .WhiteColor
        fareBrakDownView.backgroundColor = .Buttoncolor
        fareRulesView.backgroundColor = .WhiteColor
        baggageView.backgroundColor = .WhiteColor
        
        ittanerylbl.textColor = .TitleColor
        fareBrakDownlbl.textColor = .WhiteColor
        fareRuleslbl.textColor = .TitleColor
        baggagelbl.textColor = .TitleColor
        
        setupFareBreakDownTVCell()
    }
    
    func fareRulesTap(){
        
        ittaneryView.backgroundColor = .WhiteColor
        fareBrakDownView.backgroundColor = .WhiteColor
        fareRulesView.backgroundColor = .Buttoncolor
        baggageView.backgroundColor = .WhiteColor
        
        ittanerylbl.textColor = .TitleColor
        fareBrakDownlbl.textColor = .TitleColor
        fareRuleslbl.textColor = .WhiteColor
        baggagelbl.textColor = .TitleColor
        
        callgetFarerulesAPI()
    }
    
    func baggageTap(){
        
        ittaneryView.backgroundColor = .WhiteColor
        fareBrakDownView.backgroundColor = .WhiteColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageView.backgroundColor = .Buttoncolor
        
        ittanerylbl.textColor = .TitleColor
        fareBrakDownlbl.textColor = .TitleColor
        fareRuleslbl.textColor = .TitleColor
        baggagelbl.textColor = . WhiteColor
        
        setupBaggageTVCell()
    }
    
}



extension FlightDeatilsVC {
    
    func callAPI() {
       
        holderView.isHidden = true
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsource
        MySingleton.shared.payload["selectedResultindex"] = MySingleton.shared.selectedResult
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.fdvm?.CALL_FLIGHT_DETAILS_API(dictParam: MySingleton.shared.payload)
        
    }
    
    
    func flightDetails(response: FlightDetailsModel) {
        
        loderBool = false
        hideLoadera()
        
        holderView.isHidden = false
        self.fd = response.flightDetails ?? [[]]
        MySingleton.shared.flightPriceDetails = response.priceDetails
        MySingleton.shared.baggageDetails = response.baggage_details ?? []
        MySingleton.shared.setAttributedTextnew(str1: "\(response.priceDetails?.api_currency ?? "")",
                                                str2: "\(response.priceDetails?.grand_total ?? "")",
                                                lbl: kwdlbl,
                                                str1font: .OpenSansBold(size: 12),
                                                str2font: .OpenSansBold(size: 18),
                                                str1Color: .WhiteColor,
                                                str2Color: .WhiteColor)
        
        DispatchQueue.main.async {[self] in
            ittanneryTap()
        }
    }
    
    
    
    
    
    func setupBookingInformationTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        for (index,element) in fd.enumerated() {
            MySingleton.shared.tablerow.append(TableRow(title: "\(index)",
                                                        moreData: element,
                                                        cellType: .ItineraryTVCell))
        }
        
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.TicketIssuingTimeTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupFareBreakDownTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType: .FareBreakdownTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    func setupBaggageTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        
        for (index,value) in MySingleton.shared.baggageDetails.enumerated() {
            
            
            MySingleton.shared.tablerow.append(TableRow(title:"\(index)",
                                                        
                                                        subTitle: "\(value.origin_loc ?? "")-\(value.destination_loc ?? "")",
                                                        text: value.weight_Allowance,
                                                        buttonTitle: value.cabin_baggage,
                                                        cellType:.BaggageInfoTVCell))
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"After booking you can contact a travel advisor to add extra baggage, subject to the airliness avaliblity & rates.",
                                                    cellType:.BaggageInfoImageTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"0 Kilograms Each Luggage piece cannot exceed the airline's allowed dimensions or size",
                                                    cellType:.BaggageInfoImageTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
        
    }
    
    
}



//MARK: - callgetFarerulesAPI farerulesList
extension FlightDeatilsVC {
    
    
    func callgetFarerulesAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] =  MySingleton.shared.searchid
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: MySingleton.shared.farerulesrefKey)
            if let farerulesrefKeyString = String(data: jsonData, encoding: .utf8) {
                MySingleton.shared.payload["fare_rules_key"] = farerulesrefKeyString
            } else {
                print("Error: Unable to convert JSON data to string")
            }
        } catch {
            print("Error: \(error)")
        }
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: MySingleton.shared.farerulesrefContent)
            if let farerulesrefContentString = String(data: jsonData, encoding: .utf8) {
                MySingleton.shared.payload["fare_rules_content"] = farerulesrefContentString
            } else {
                print("Error: Unable to convert JSON data to string")
            }
        } catch {
            print("Error: \(error)")
        }
        
        MySingleton.shared.payload["booking_source"] =  MySingleton.shared.bookingsource
        MySingleton.shared.fdvm?.CALL_GET_FARERULES_API(dictParam: MySingleton.shared.payload)
        
    }
    
    func farerulesList(response: FareRulesModel) {
        
        MySingleton.shared.fareRulesData = response.data ?? []
        
        DispatchQueue.main.async {
            self.setupFareRulesTVCell()
        }
        
    }
    
    func setupFareRulesTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        if MySingleton.shared.fareRulesData.count > 0 {
            
            self.commonTableView.estimatedRowHeight = 500
            self.commonTableView.rowHeight = 40
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            
            MySingleton.shared.fareRulesData.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(title:i.rule_heading,
                                                            subTitle: i.rule_content?.htmlToString,
                                                            cellType:.FareRulesTVCell))
            }
            
            
            
        }else {
            
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}




//MARK: - addObserver
extension FlightDeatilsVC {
    
    func addObserver() {
        
        NotificationCenter.default.post(name: NSNotification.Name("hideDetails"), object: nil)
        
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
    
    
}
