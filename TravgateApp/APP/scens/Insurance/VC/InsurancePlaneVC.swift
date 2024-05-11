//
//  InsurancePlaneVC.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

class InsurancePlaneVC: BaseTableVC {
    
    static var newInstance: InsurancePlaneVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsurancePlaneVC
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
    
    
    override func didTapOnSelectPlanBtnAction(cell: InsurancePlaneTVCell) {
        gotoPlaneDetailsVC()
    }
    
    override func didTapOnPremiumDetailsBtnAction(cell: InsurancePlaneTVCell) {
        gotoPremiumDetailsVC()
    }
    
    
   
}



extension InsurancePlaneVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["InsurancePlaneTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        
        for _ in 0...100 {
            MySingleton.shared.tablerow.append(TableRow(key:"list",cellType:.InsurancePlaneTVCell))
        }
        
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    func gotoBDTransferVC() {
        guard let vc = BDTransferVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func gotoPremiumDetailsVC() {
        guard let vc = PremiumDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoPlaneDetailsVC() {
        guard let vc = PlaneDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
