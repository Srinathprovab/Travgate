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
                                         "PopularDestinationsTVCell",
                                         "TopcityGuidesTVCell",
                                         "SpecialOffersTVCell",
                                         "EmptyTVCell",
                                         "MoreServiceTVCell"])
        
        setupTableViewCells()
    }
    
    
    func setupTableViewCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.TabSelectTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.MoreServiceTVCell))
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
        print("didTapOnSelectCurrencyBtnAction")
    }
    
    override func didTapOnFlightTabSelectBtnAction(cell: TabSelectTVCell) {
        print("didTapOnFlightTabSelectBtnAction")
    }
    
    override func didTapOnHotelTabSelect(cell: TabSelectTVCell) {
        print("didTapOnHotelTabSelect")
    }
    
    override func didTapOnMoreServiceBtnAction(cell: TabSelectTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnClosebtnAction(cell: MoreServiceTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnVisabtnAction(cell: MoreServiceTVCell) {
        print("didTapOnVisabtnAction")
    }
    
    override func didTapOnInsurancebtnAction(cell: MoreServiceTVCell) {
        print("didTapOnInsurancebtnAction")
    }
    
    override func didTapOnTransfersbtnAction(cell: MoreServiceTVCell) {
        print("didTapOnTransfersbtnAction")
    }
    
    override func didTapOnActivitiesbtnAction(cell: MoreServiceTVCell) {
        print("didTapOnActivitiesbtnAction")
    }
    
    override func didTapOnCruisebtnAction(cell: MoreServiceTVCell) {
        print("didTapOnCruisebtnAction")
    }
    
    override func didTapOnAutopaybtnAction(cell: MoreServiceTVCell) {
        print("didTapOnAutopaybtnAction")
    }
    
    
    
}
