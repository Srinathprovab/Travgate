//
//  SelectFareVC.swift
//  Travgate
//
//  Created by FCI on 22/04/24.
//

import UIKit

class SelectFareVC: BaseTableVC {
    
    
    static var newInstance: SelectFareVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFareVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        callGetFareListAPI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        commonTableView.registerTVCells(["SelectFareTVCell",
                                         "EmptyTVCell"])
        
        
    }
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnSelectFareBtnAction(cell: SelectFareTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnCloseFareBtnAction(cell: SelectFareTVCell) {
        commonTableView.reloadData()
    }
    
   
    
    
    
    
}


extension SelectFareVC {
    

    
    func callGetFareListAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["search_id"] = MySingleton.shared.searchid
        MySingleton.shared.payload["serialized_journeyKey"] = MySingleton.shared.farekey
        MySingleton.shared.payload["booking_source"] = MySingleton.shared.bookingsource
        
    
        setupTVcells()
    }
    
    func setupTVcells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectFareTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
