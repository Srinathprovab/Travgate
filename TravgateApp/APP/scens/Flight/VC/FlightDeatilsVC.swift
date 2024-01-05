//
//  FlightDeatilsVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightDeatilsVC: BaseTableVC {
    
    
    
    @IBOutlet weak var selectBtnsHolderView: UIView!
    
    
    static var newInstance: FlightDeatilsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDeatilsVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
    }
    
    
    func setUI() {
        
        selectBtnsHolderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        selectBtnsHolderView.layer.cornerRadius = 10
        selectBtnsHolderView.clipsToBounds = true
        
        
        commonTableView.registerTVCells(["TicketIssuingTimeTVCell"])
        setupBookingInformationTVCell()
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
       
    }
    
}


extension FlightDeatilsVC {
    
    
    func setupBookingInformationTVCell() {
        
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(cellType:.TicketIssuingTimeTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
}
