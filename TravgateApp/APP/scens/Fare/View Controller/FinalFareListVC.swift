//
//  FinalFareListVC.swift
//  Travgate
//
//  Created by FCI on 04/05/24.
//

import UIKit

class FinalFareListVC: BaseTableVC {
    
   
    
    static var newInstance: FinalFareListVC? {
        let storyboard = UIStoryboard(name: Storyboard.Fare.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FinalFareListVC
        return vc
    }
    
    var keyString = String()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()

    }
    
    func setupUI() {
        
       
        commonTableView.registerTVCells(["SelectFareInfoTVCell",
                                         "EmptyTVCell"])
        
        
        setupTVcells()
    }
    
    
    func setupBtn(btn:UIButton,title1:String) {
        btn.setTitle(title1, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
   
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
       
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            self.presentingViewController?.presentingViewController?.dismiss(animated: false)
        }else {
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false)
        }
    }
    
    
    override func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell) {
        
        if (cell.indexPath?.row ?? 0) < MySingleton.shared.selectedFares.count {
            MySingleton.shared.selectedFares.remove(at: (cell.indexPath?.row ?? 0))
        } else {
            // Index is out of range, handle the error or provide a default action
            print("Error: Index out of range")
        }
        
        
        DispatchQueue.main.async {
            self.setupTVcells()
        }
    }
    
}


extension FinalFareListVC {
    
    
    
   
    
    func setupTVcells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        
        
        if  MySingleton.shared.selectedFares.count > 0 {
            
            MySingleton.shared.selectedFares.forEach { i in
                MySingleton.shared.tablerow.append(TableRow(title:"Extra",
                                                            subTitle: i.cabinClass,
                                                            text: "Pay to Cancel upto 24 hours prior to departure",
                                                            headerText: i.journyType,
                                                            buttonTitle: i.Baggage,
                                                            key1:"selected",
                                                            tempText: i.Price,
                                                            cellType:.SelectFareInfoTVCell))
                
            }
            
            
            MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
            
            
        }else {
           
            MySingleton.shared.callboolapi = false
            
            if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
                self.presentingViewController?.dismiss(animated: false)
            }else {
                self.presentedViewController?.presentedViewController?.dismiss(animated: false)
            }
        }
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
