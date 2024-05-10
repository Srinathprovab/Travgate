//
//  ViewTicketInfoVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class ViewTicketInfoVC: BaseTableVC {
    
    static var newInstance: ViewTicketInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewTicketInfoVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
            loderBool = false
            hideLoadera()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
   
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}



extension ViewTicketInfoVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["SelectedSportInfoTVCell",
                                         "SportsStadiumTVCell",
                                         "EmptyTVCell"])
        setupVisaTVCells()
        
    }
    
    
    func setupVisaTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedSportInfoTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsStadiumTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
   
}
