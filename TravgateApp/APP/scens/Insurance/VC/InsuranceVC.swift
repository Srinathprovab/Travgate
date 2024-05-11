//
//  InsuranceVC.swift
//  TravgateApp
//
//  Created by FCI on 12/02/24.
//

import UIKit

class InsuranceVC: BaseTableVC {
    
    
    
    static var newInstance: InsuranceVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsuranceVC
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
    
    
    
    
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    //MARK: - InsurenceSearchTVCell Delegate Methodes
    override func didTapOnWhoTravellingBtnAction(cell:InsurenceSearchTVCell) {
        print("\(cell.travellinglbl.text ?? "")")
    }
    
    override func didTapOnWithWhomTravellingBtnAction(cell:InsurenceSearchTVCell) {
        print("\(cell.withWhomTravellinglbl.text ?? "")")
    }
    
    override func didTapOnTravelZoneBtnAction(cell:InsurenceSearchTVCell) {
        print("\(cell.travelZonelbl.text ?? "")")
    }
    
    
    override func didTapOnMultiTripslblBtnAction(cell:InsurenceSearchTVCell) {
        print("\(cell.multiTripslbl.text ?? "")")
    }
    
    override func donedatePicker(cell:InsurenceSearchTVCell){
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:InsurenceSearchTVCell) {
        self.view.endEditing(true)
    }
    
    override func didTapOnAddAdditionalTravellerBtnAction(cell:InsurenceSearchTVCell) {
        print("\(cell.additionalTravelerslbl.text ?? "")")
    }
    
    
    override func didTapOnInsurenceSearchBtnAction(cell: InsurenceSearchTVCell) {
        gotoInsurancePlaneVC()
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
        
        setupTVCells()
        
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
    
    
    func callAPI() {
        print("callAPI")
    }
    
}

extension InsuranceVC {
    
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
