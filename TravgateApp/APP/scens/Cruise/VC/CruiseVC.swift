//
//  CruiseVC.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import UIKit

class CruiseVC: BaseTableVC, CruiseViewModelDelegate {
    
    
    static var newInstance: CruiseVC? {
        let storyboard = UIStoryboard(name: Storyboard.Cruise.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CruiseVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.cruisevm = CruiseViewModel(self)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    //MARK: - didTapOnCruisePackageBtnAction
    override func didTapOnCruisePackageBtnAction(cell: CruisePackegesTVCell) {
        MySingleton.shared.cruiseKeyStr = cell.cruiseKey
        gotoCruiseDetailsVC()
    }
    
    
    func gotoCruiseDetailsVC() {
        guard let vc = CruiseDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}



extension CruiseVC {
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["CruisePackegesTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    func callAPI() {
        
        MySingleton.shared.afterResultsBool = true
       
        MySingleton.shared.cruisevm?.CALL_CRUISE_LIST_API(dictParam: [:])
    }
    
    func cruiseList(response: CruiseModel) {
        
        MySingleton.shared.cruiseList = response.data ?? []
        MySingleton.shared.cruise = response
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:"",cellType:.CruisePackegesTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    
}

extension CruiseVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        if callapibool == true {
            callAPI()
        }
        
       
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

