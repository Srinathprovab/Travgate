//
//  MoreVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class MoreVC: BaseTableVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["TripsTVCell",
                                         "EmptyTVCell"])
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(title:"About Us",key: "more",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Terms & Conditions",key: "more",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Privacy Policy",key: "more",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Contact Us",key: "more",cellType:.TripsTVCell))
        
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnTripsBtnAction(cell: TripsTVCell) {
        switch cell.titlelbl.text {
            
        case "About Us":
            print("About Us")
            break
            
        case "Terms & Conditions":
            print("Terms & Conditions")
            break
            
            
        case "Privacy Policy":
            print("Privacy Policy")
            break
            
        case "Contact Us":
            gotoContactUsVC()
            break
            
            
            
            
        default:
            break
        }
    }
    
    
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
}



