//
//  SimilarFlightsVC.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import UIKit

class SimilarFlightsVC: BaseTableVC {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
    static var newInstance: SimilarFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Flight.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SimilarFlightsVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupTVCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        commonTableView.registerTVCells(["FlightResultTVCell",
                                         "EmptyTVCell"])
    }
    
    
    
    
    override func didTapOnFlightDetails(cell: FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        MySingleton.shared.farerulesrefKey = cell.farerulesrefKey
        MySingleton.shared.farerulesrefContent = cell.farerulesrefContent
        guard let vc = FlightDeatilsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
        
    }
    
    
    
    override func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {
        MySingleton.shared.callboolapi = true
        MySingleton.shared.selectedResult = cell.selectedResult
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        MySingleton.shared.callboolapi = false
        dismiss(animated: true)
    }
    
    
}


extension SimilarFlightsVC {
    
    
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        titlelbl.text = "\(MySingleton.shared.similarflightList.count) Flights Found"
        
        MySingleton.shared.similarflightList.forEach { i in
            i.forEach { j in
                
                
                MySingleton.shared.tablerow.append(TableRow(title: j.selectedResult,
                                                            subTitle: j.booking_source,
                                                            refundable:j.fareType,
                                                            key: "similar",
                                                            text: j.booking_source_key,
                                                            moreData: j,
                                                            tempInfo: j.farerulesref_Key,
                                                            cellType:.FlightResultTVCell,
                                                            userCatdetails:j.journeyKey,
                                                            data1: j.flight_details?.summary,
                                                            data2: j.farerulesref_content))
            }
        }
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
}
