//
//  PremiumDetailsVC.swift
//  Travgate
//
//  Created by FCI on 11/05/24.
//

import UIKit

class PremiumDetailsVC: BaseTableVC {
    
    
    static var newInstance: PremiumDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PremiumDetailsVC
        return vc
    }
    

    @IBOutlet weak var holderview: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
  
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
    
    
}



extension PremiumDetailsVC {
    
    
    func setupUI(){
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        holderview.layer.cornerRadius = 6
        commonTableView.layer.cornerRadius = 6
        commonTableView.registerTVCells(["PremiumInfoTVCell",
                                         "EmptyTVCell"])
        
        setupTVCells()
        
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        MySingleton.shared.tablerow.append(TableRow(title:"Gross Premium",
                                                    subTitle: "9.250",
                                                    cellType:.PremiumInfoTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Supervision Fees",
                                                    subTitle: "9.250",
                                                    cellType:.PremiumInfoTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Issuing Fees",
                                                    subTitle: "9.250",
                                                    cellType:.PremiumInfoTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Beneficiary Fees",
                                                    subTitle: "9.250",
                                                    cellType:.PremiumInfoTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(title:"Net Premium",
                                                    subTitle: "9.250",
                                                    cellType:.PremiumInfoTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    

}
