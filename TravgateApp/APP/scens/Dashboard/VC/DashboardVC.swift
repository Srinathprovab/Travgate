//
//  DashboardVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class DashboardVC: BaseTableVC {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["TabSelectTVCell",
                                         "PopularDestinationsTVCell"])
        setupTableViewCells()
    }
    
    
    func setupTableViewCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.TabSelectTVCell))
        MySingleton.shared.tablerow.append(TableRow(key:"flight",cellType:.PopularDestinationsTVCell))
        MySingleton.shared.tablerow.append(TableRow(key:"hotel",cellType:.PopularDestinationsTVCell))

        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnMenuBtnAction(cell: TabSelectTVCell) {
        print("didTapOnMenuBtnAction")
    }
    
    override func didTapOnSelectCurrencyBtnAction(cell: TabSelectTVCell) {
        print("didTapOnSelectCurrencyBtnAction")
    }
    
    override func didTapOnFlightTabSelectBtnAction(cell: TabSelectTVCell) {
        print("didTapOnFlightTabSelectBtnAction")
    }
    
    override func didTapOnHotelTabSelect(cell: TabSelectTVCell) {
        print("didTapOnHotelTabSelect")
    }
    
    override func didTapOnMoreServiceBtnAction(cell: TabSelectTVCell) {
        print("didTapOnMoreServiceBtnAction")
    }
    
}
