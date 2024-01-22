//
//  SearchHotelVC.swift
//  TravgateApp
//
//  Created by FCI on 17/01/24.
//

import UIKit

class SearchHotelVC: BaseTableVC {
    
    
    @IBOutlet weak var logoimg: UIImageView!
    
    
    static var newInstance: SearchHotelVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    //MARK: - didTapOnClassBtnAction
    override func didTapOnClassBtnAction(cell:FlightSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    //MARK: - didTapOnAdvanceOption
    override func didTapOnAdvanceOption(cell: FlightSearchTVCell) {
        commonTableView.reloadData()
    }
    
    
    
    override func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell) {
        didTapOnFlightSearchBtnAction()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:HotelSearchTVCell){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        defaults.set(formatter.string(from: cell.checkinDatePicker.date), forKey: UserDefaultsKeys.checkin)
        defaults.set(formatter.string(from: cell.checkoutDatePicker.date), forKey: UserDefaultsKeys.checkout)
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:HotelSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - didTapOnAddRoomsBtnAction
    override func didTapOnAddRoomsBtnAction(cell:HotelSearchTVCell) {
        guard let vc = AddRoomsGuestsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectNationlatiyBtnAction
    override func didTapOnSelectNationlatiyBtnAction(cell:HotelSearchTVCell) {
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnSelectNoofNightsBtnAction
    override func didTapOnSelectNoofNightsBtnAction(cell:HotelSearchTVCell) {
        
    }
    
}


extension SearchHotelVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["HotelSearchTVCell",
                                         "EmptyTVCell"])
        
        setupOnewayTVCells()
        
    }
    
    
    
    func setupOnewayTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:"oneway",cellType:.HotelSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension SearchHotelVC {
    
    
    func didTapOnFlightSearchBtnAction() {
        MySingleton.shared.payload.removeAll()
        

    }
    
    
    func gotoFlightResultVC() {
        MySingleton.shared.callboolapi = true
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = FlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



extension SearchHotelVC {
    
    func addObserver() {
        
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
    
    
}
