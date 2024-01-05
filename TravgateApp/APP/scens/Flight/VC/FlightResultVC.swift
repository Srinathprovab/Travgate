//
//  FlightResultVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class FlightResultVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var paxlbl: UILabel!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var citycodeslbl: UILabel!
    
    
    
    static var newInstance: FlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightResultVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        callAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    
    func setupUI() {
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            retDatelbl.isHidden = true
            MySingleton.shared.acount = 1
        }else {
            MySingleton.shared.acount = 2
            retDatelbl.isHidden = false
        }
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "FlightResultTVCell"])
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func didTapOnModifySearchBtmAction(_ sender: Any) {
        print("didTapOnModifySearchBtmAction")
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        print("didTapOnSortBtnAction")
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    
    @IBAction func didTapOnnextDayFlightSearchBtnAction(_ sender: Any) {
        print("didTapOnnextDayFlightSearchBtnAction")
    }
    
    
    @IBAction func didTapOnPrivousdayFlightSearchBtnAction(_ sender: Any) {
        print("didTapOnPrivousdayFlightSearchBtnAction")
    }
    
    
    
    
}


extension FlightResultVC {
    
    
    func callAPI() {
        
        holderView.isHidden = true
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.holderView.isHidden = false
            
            self.setupTVCell()
        }
        
    }
    
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        for _ in 0...10 {
            MySingleton.shared.tablerow.append(TableRow(title:"",
                                                        characterLimit: MySingleton.shared.acount,
                                                        cellType:.FlightResultTVCell))
        }
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
}
