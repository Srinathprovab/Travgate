//
//  TripsVC.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class TripsVC: BaseTableVC {
    
    
    
    
    
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
        
        MySingleton.shared.tablerow.append(TableRow(title:"Flight",image: "flighttrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Hotel",image: "hoteltrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Visa",image: "visatrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Insurance",image: "insurancetrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Transfers",image: "transferstrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Activities",image: "activitiestrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Cruise",image: "cruisetrip",cellType:.TripsTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Auto Pay",image: "autopaytrip",cellType:.TripsTVCell))
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnTripsBtnAction(cell: TripsTVCell) {
        switch cell.titlelbl.text {
            
        case "Flight":
            gotoBookingsVC(str: "Flight")
            break
            
        case "Hotel":
            // gotoBookingsVC(str: "Hotel")
            break
            
            
        case "Visa":
            // gotoBookingsVC(str: "Visa")
            break
            
        case "Insurance":
            //  gotoBookingsVC(str: "Insurance")
            break
            
            
        case "Transfers":
            //  gotoBookingsVC(str: "Transfers")
            break
            
            
        case "Activities":
            //   gotoBookingsVC(str: "Activities")
            break
            
            
        case "Cruise":
            //   gotoBookingsVC(str: "Cruise")
            break
            
        case "Auto Pay":
            //   gotoBookingsVC(str: "Auto Pay")
            break
            
            
            
            
        default:
            break
        }
    }
    
    
    
}


extension TripsVC {
    func gotoBookingsVC(str:String) {
        guard let vc = BookingsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titletext = str
        present(vc, animated: true)
    }
    
}
