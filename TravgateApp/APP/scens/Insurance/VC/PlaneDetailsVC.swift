//
//  PlaneDetailsVC.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

class PlaneDetailsVC: BaseTableVC {

    
    
    
    static var newInstance: PlaneDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PlaneDetailsVC
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
    
    
    override func didTapOnPremiumDetailsBtnAction(cell: InsurancePlaneTVCell) {
        gotoPremiumDetailsVC()
    }
    
    
    func gotoPremiumDetailsVC() {
        guard let vc = PremiumDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @IBAction func didTapOnContinuePaymentBtnAction(_ sender: Any) {
        print("didTapOnContinuePaymentBtnAction")
    }
    
    
}



extension PlaneDetailsVC {
    
    
    func setupUI(){
        
      
        commonTableView.registerTVCells(["InsurancePlaneTVCell",
                                         "MainTravelPersonTVCell",
                                         "TermsAgreeTVCell",
                                         "EmptyTVCell"])
        
        setupTVCells()
        
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(key:"plan",cellType:.InsurancePlaneTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.MainTravelPersonTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Lorem ipsum dolor sit amet consectetur. Ligula justo facilisi vel consectetur elit pulvinar tortor. Etiam massa et nunc sem sit faucibus pharetra. Euismod sodales ultricies amet in mattis elit risus. Libero vehicula quis scelerisque amet id.",
                                                    cellType:.TermsAgreeTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    

}
