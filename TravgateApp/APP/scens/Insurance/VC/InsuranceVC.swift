//
//  InsuranceVC.swift
//  TravgateApp
//
//  Created by FCI on 12/02/24.
//

import UIKit

class InsuranceVC: BaseTableVC, GetInsuranceItemsVMDelegate {
  
    
    
    static var newInstance: InsuranceVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsuranceVC
        return vc
    }
    
    
    var keystr = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.getInsuranceItemsVM = GetInsuranceItemsVM(self)
    }
    
    
    
    
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
    override func donedatePicker(cell:InsurenceSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:InsurenceSearchTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    override func didTapOnInsurenceSearchBtnAction(cell: InsurenceSearchTVCell) {
        
        
        
        if MySingleton.shared.insurencetravelcode == "" {
            showToast(message: "Select Travel ")
        }else if MySingleton.shared.insurencwhomcode == "" {
            showToast(message: "Select Whom ")
        }else if MySingleton.shared.insurenczonecode == "" {
            showToast(message: "Select Zone")
        }else if MySingleton.shared.insurencmultitripscode == "" {
            showToast(message: "Select Trips")
        }else if MySingleton.shared.insurenceDepDate == "" {
            showToast(message: "Select Travel Date")
        }else {
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["age"] = MySingleton.shared.insurencetravelcode
            MySingleton.shared.payload["whom"] = MySingleton.shared.insurencwhomcode
            MySingleton.shared.payload["zone"] = MySingleton.shared.insurenczonecode
            MySingleton.shared.payload["trip_type"] = MySingleton.shared.insurencmultitripscode
            MySingleton.shared.payload["travel_date"] = MySingleton.shared.insurenceDepDate
            MySingleton.shared.payload["arival_date"] = MySingleton.shared.insurenceArrivalDate
            MySingleton.shared.payload["pax_count"] = MySingleton.shared.insurencePaxCount
       
            MySingleton.shared.getInsuranceItemsVM?.CALL_GET_INSURENCE_MOBILE_PRE_INSURENCE_API(dictParam: MySingleton.shared.payload)
        }
        
       
        
    }
    
    
    func preInsurenceSearchResponse(response: GetInsuranceItemsModel) {
        showToast(message: response.message ?? "")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            gotoInsurancePlaneVC()
        }
    }
    
    
    func gotoInsurancePlaneVC() {
        guard let vc = InsurancePlaneVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}


extension InsuranceVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["InsurenceSearchTVCell",
                                         "EmptyTVCell"])
        
        
        
    }
    
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.InsurenceSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}




extension InsuranceVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        withwhomtitleArray.removeAll()
        withwhomcodeArray.removeAll()
        
        multitripstittleArray.removeAll()
        multitripscodeArray.removeAll()
        
        zonetitleArray.removeAll()
        zonecodeArray.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [unowned self] in
            callgetWhomAPI()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            callgetZoneAPI()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [unowned self] in
            callgetAgeAPI()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            setupTVCells()
        }
    }
    
    
    func callgetWhomAPI(){
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["item_name"] = "select_whom"
        MySingleton.shared.getInsuranceItemsVM?.CALL_GET_INSURENCE_WHOM_ITEMS_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func insurenceWhomItemlist(response: GetInsuranceItemsModel) {
        zonetitleArray.append("Select")
        zonecodeArray.append("Select")
        
        response.data?.forEach({ i in
            zonetitleArray.append(i.title ?? "")
            zonecodeArray.append(i.code ?? "")
        })
    }
    
    
    func callgetZoneAPI(){
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["item_name"] = "select_zone"
        MySingleton.shared.getInsuranceItemsVM?.CALL_GET_INSURENCE_ZONE_ITEMS_API(dictParam: MySingleton.shared.payload)
    }
    
    func insurenceZoneItemlist(response: GetInsuranceItemsModel) {
        multitripstittleArray.append("Select")
        multitripscodeArray.append("Select")
        
        response.data?.forEach({ i in
            multitripstittleArray.append(i.title ?? "")
            multitripscodeArray.append(i.code ?? "")
        })
    }
    
    
    func callgetAgeAPI(){
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["item_name"] = "select_age"
        MySingleton.shared.getInsuranceItemsVM?.CALL_GET_INSURENCE_AGE_ITEMS_API(dictParam: MySingleton.shared.payload)
    }
    func insurenceAgeItemlist(response: GetInsuranceItemsModel) {
        withwhomtitleArray.append("Select")
        withwhomcodeArray.append("Select")
        response.data?.forEach({ i in
            withwhomtitleArray.append(i.title ?? "")
            withwhomcodeArray.append(i.code ?? "")
        })
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
