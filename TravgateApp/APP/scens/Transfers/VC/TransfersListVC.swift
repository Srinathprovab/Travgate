//
//  TransfersListVC.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

class TransfersListVC: BaseTableVC {
    
    
    static var newInstance: TransfersListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Transfers.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TransfersListVC
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
       print("didTapOnSortBtnAction")
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func didTapOnBookNowBtnAction(cell: TransfersInf0TVCell) {
        didTapOnBookNowBtnAction()
    }
    
    
    
}



extension TransfersListVC {
    
    
    func setupUI(){
    
        commonTableView.registerTVCells(["TransfersInf0TVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells(keystr: "oneway")
        
    }
   
    
    func setupVisaTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        for i in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(key:keystr,
                                                        cellType:.TransfersInf0TVCell))
        }
        
        
       
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func didTapOnBookNowBtnAction() {
        print("didTapOnSearchBtnAction")
        
        
        MySingleton.shared.loderString = "fdetails"
        MySingleton.shared.afterResultsBool = true
        loderBool = true
        showLoadera()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [unowned self] in
            loderBool = false
            hideLoadera()
            
            
            gotoBDTransferVC()
        }
    }
    
    
    
    func gotoBDTransferVC() {
       guard let vc = BDTransferVC.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true)
   }
    
}
