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
    
    
    override func doneTimePicker(cell: TFlighDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    override func cancelTimePicker(cell: TFlighDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func didTapOnCountryCodeBtn(cell: TContactDetailsTVCell) {
        print(cell.countrycodeTF.text ?? "")
    }
    
    
    
    @IBAction func didTapOnContinueBtnAction(_ sender: Any) {
        gotoBDTransferVC()
    }
    
    
    func gotoBDTransferVC() {
       guard let vc = SelectPaymentMethodsVC.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true)
   }
    
}



extension BDTransferVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["BDTransfersInf0TVCell",
                                         "EmptyTVCell",
                                         "TContactDetailsTVCell",
                                         "TermsAgreeTVCell",
                                         "TFlighDetailsTVCell"])
        setupVisaTVCells(keystr: "oneway")
        
    }
    
    
    func setupVisaTVCells(keystr:String) {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(key:keystr,cellType:.BDTransfersInf0TVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.TFlighDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.TContactDetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"By Booking This item, You agree to pay the total amount shown, with includes service fees. you also agree to the terms ans conditions and privacy policy .",cellType:.TermsAgreeTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
}
