//
//  DashboardVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class DashboardVC: BaseTableVC {
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {[self] in
            observeNotification()
        }
        
        DispatchQueue.main.async {[self] in
            callIndexPageAPI()
        }
       
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        MySingleton.shared.indexpagevm = IndexPageViewModel(self)
        
    }
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["TabSelectTVCell",
                                         "PopularDestinationsTVCell",
                                         "TopcityGuidesTVCell",
                                         "SpecialOffersTVCell",
                                         "EmptyTVCell"])
        
       
    }
    
    
    func setupTableViewCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.TabSelectTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.PopularDestinationsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.TopcityGuidesTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SpecialOffersTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnMenuBtnAction(cell: TabSelectTVCell) {
        print("didTapOnMenuBtnAction")
    }
    
    override func didTapOnSelectCurrencyBtnAction(cell: TabSelectTVCell) {
        gotoSelectLanguageVC()
    }
    
    override func didTapOnFlightTabSelectBtnAction(cell: TabSelectTVCell) {
        defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
        gotoFlightSearchVC()
    }
    
    override func didTapOnHotelTabSelect(cell: TabSelectTVCell) {
        print("didTapOnHotelTabSelect")
    }
    
    override func didTapOnMoreServiceBtnAction(cell: TabSelectTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnClosebtnAction(cell: TabSelectTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnVisabtnAction(cell: TabSelectTVCell) {
        print("didTapOnVisabtnAction")
    }
    
    override func didTapOnInsurancebtnAction(cell: TabSelectTVCell) {
        print("didTapOnInsurancebtnAction")
    }
    
    override func didTapOnTransfersbtnAction(cell: TabSelectTVCell) {
        print("didTapOnTransfersbtnAction")
    }
    
    override func didTapOnActivitiesbtnAction(cell: TabSelectTVCell) {
        print("didTapOnActivitiesbtnAction")
    }
    
    override func didTapOnCruisebtnAction(cell: TabSelectTVCell) {
        print("didTapOnCruisebtnAction")
    }
    
    override func didTapOnAutopaybtnAction(cell: TabSelectTVCell) {
        print("didTapOnAutopaybtnAction")
    }
    
    
    
}


extension DashboardVC:IndexPageViewModelDelegate {
    
    
    func callIndexPageAPI() {
        MySingleton.shared.indexpagevm?.CALL_INDEX_PAGE_API(dictParam: [:])
    }
    
    
    func indexPageDetails(response: IndexPagemodel) {
        
        MySingleton.shared.topFlightDetails = response.topFlightDetails ?? []
        MySingleton.shared.topHotelDetails = response.topHotelDetails ?? []
        MySingleton.shared.deail_code_list = response.deail_code_list ?? []
        
        DispatchQueue.main.async {[self] in
            setupTableViewCells()
        }
        
    }
    
    
    
}



extension DashboardVC {
    
    func observeNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCurrency), name: Notification.Name("selectedCurrency"), object: nil)
    }
    
    
    @objc func selectedCurrency() {
        commonTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
    }
    
    func gotoSelectLanguageVC() {
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func gotoFlightSearchVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
