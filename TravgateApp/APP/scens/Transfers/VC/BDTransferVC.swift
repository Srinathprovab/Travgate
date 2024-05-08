//
//  BDTransferVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class BDTransferVC: BaseTableVC {
    
    
    
    static var newInstance: BDTransferVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BDTransferVC
        return vc
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



extension BDTransferVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["BDTransfersInf0TVCell",
                                         "EmptyTVCell"])
        setupVisaTVCells(keystr: "oneway")
        
    }
    
    
    
    
    func setupVisaTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:keystr,
                                                    cellType:.BDTransfersInf0TVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}
