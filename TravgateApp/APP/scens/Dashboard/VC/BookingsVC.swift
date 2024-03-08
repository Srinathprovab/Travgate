//
//  BookingsVC.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

class BookingsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var upcominglbl: UILabel!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var cancelledView: UIView!
    
    
    
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
        
        commonTableView.registerTVCells(["FlightUpcomingTVCell",
                                         "EmptyTVCell"])
        
        DispatchQueue.main.async {
            self.tapOnUpcomingBtn()
        }
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnUpcomingFlightsBtnAction(_ sender: Any) {
        tapOnUpcomingBtn()
    }
    
    @IBAction func didTapOnCompletedFlightsBtnAction(_ sender: Any) {
        tapOnCompletedBtn()
    }
    
    @IBAction func didTapOnCancelledFlightsBtnAction(_ sender: Any) {
        tapOnCancelledBtn()
    }
    
    
    override func didTapOnViewVoucherBtnAction(cell: FlightUpcomingTVCell) {
        print("didTapOnViewVoucherBtnAction")
    }
    
    
}


extension BookingsVC {
    func tapOnUpcomingBtn() {
        upcomingView.backgroundColor = .AppBtnColor
        completedView.backgroundColor = .WhiteColor
        cancelledView.backgroundColor = .WhiteColor
        
        upcominglbl.textColor = .WhiteColor
        completedlbl.textColor = .AppLabelColor
        cancelledlbl.textColor = .AppLabelColor
        
        setupUpcomingTVCells()
    }
    
    func tapOnCompletedBtn() {
        upcomingView.backgroundColor = .WhiteColor
        completedView.backgroundColor = .AppBtnColor
        cancelledView.backgroundColor = .WhiteColor
        
        upcominglbl.textColor = .AppLabelColor
        completedlbl.textColor = .WhiteColor
        cancelledlbl.textColor = .AppLabelColor
        
        setupCompletedTVCells()
    }
    
    func tapOnCancelledBtn() {
        upcomingView.backgroundColor = .WhiteColor
        completedView.backgroundColor = .WhiteColor
        cancelledView.backgroundColor = .AppBtnColor
        
        upcominglbl.textColor = .AppLabelColor
        completedlbl.textColor = .AppLabelColor
        cancelledlbl.textColor = .WhiteColor
        
        setupCancelledTVCells()
    }
    
    
    func setupUpcomingTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.FlightUpcomingTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    func setupCompletedTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCancelledTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
}
