//
//  ContactUsVC.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import UIKit

class ContactUsVC: BaseTableVC {
    
    
    static var newInstance: ContactUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactUsVC
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["ContactUsTVCell"])
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactUsTVCell))
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}



