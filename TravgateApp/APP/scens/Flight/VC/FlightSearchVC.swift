//
//  FlightSearchVC.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit

class FlightSearchVC: BaseTableVC {
    
    
    
    @IBOutlet weak var onewayView: BorderedView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtripView: BorderedView!
    @IBOutlet weak var roundtriplbl: UILabel!
    @IBOutlet weak var multicityView: BorderedView!
    @IBOutlet weak var multicitylbl: UILabel!
    
    static var newInstance: FlightSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightSearchVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    
    
    func onewayTap() {
        onewayView.backgroundColor = .Buttoncolor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .TitleColor
        
        setupTVCells()
    }
    
    func roundtripTap() {
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .Buttoncolor
        multicityView.backgroundColor = .WhiteColor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .TitleColor
        
        setupTVCells()
    }
    
    func multicityTap() {
        onewayView.backgroundColor = .WhiteColor
        roundtripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .Buttoncolor
        onewaylbl.textColor = .TitleColor
        roundtriplbl.textColor = .TitleColor
        multicitylbl.textColor = .WhiteColor
        
        setupTVCells()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        onewayTap()
    }
    
    
    @IBAction func didTapOnRoundTripBtnAction(_ sender: Any) {
        roundtripTap()
    }
    
    
    @IBAction func didTapOnMulticityBtnAction(_ sender: Any) {
        multicityTap()
    }
    
    
    
    
    
}


extension FlightSearchVC {
    
    
    func setupUI(){
        onewayTap()
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["FlightSearchTVCell",
                                         "EmptyTVCell"])
        
    }
    
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
