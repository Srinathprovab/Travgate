//
//  BookingsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

class BookingsVC: BaseTableVC {
    
    
    static var newInstance: BookingsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingsVC
        return vc
    }

    
    var titletext = String()
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
        
        MySingleton.shared.tablerow.append(TableRow(title:titletext,image: "flighttrip",cellType:.TripsTVCell))
       
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }

}
