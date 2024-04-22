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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
}


extension SelectFareVC {
    
    func setupUI() {
        commonTableView.registerTVCells(["SelectFareTVCell",
                                         "EmptyTVCell"])
        
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
