//
//  CruisePassengerSelectVC.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

class CruisePassengerSelectVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    
    static var newInstance: CruisePassengerSelectVC? {
        let storyboard = UIStoryboard(name: Storyboard.Cruise.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CruisePassengerSelectVC
        return vc
    }
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.cruisadultCount) ?? "1") ?? 1
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.cruischildCount) ?? "0") ?? 0
        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.cruisinfantsCount) ?? "0") ?? 0
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        holderView.backgroundColor = .black.withAlphaComponent(0.3)
        
        commonTableView.layer.cornerRadius = 10
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["TravellerEconomyTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell"])
        
        setupSearchFlightEconomyTVCells()
        
        closeBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.cruisadultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.cruischildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.cruisinfantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
        
        
        
        
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    @objc func gotoBackScreen() {
        self.dismiss(animated: true)
    }
    
    
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Increment the infant count if it's less than or equal to 9
            if infantsCount < 9 {
                infantsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else if cell.titlelbl.text == "Adult" {
            // Increment adults if it's less than or equal to 9
            if adultsCount < 9 {
                adultsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else {
            // Increment children if it's less than or equal to 9
            if childCount < 9 {
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
                childCount = cell.count
            }
        }
        
        updateTotalTravelerCount()
    }
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Decrement the infant count if it's greater than 1
            if infantsCount > 0 {
                infantsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else if cell.titlelbl.text == "Adult" {
            // Decrement adults if it's greater than 1
            if adultsCount > 1 {
                adultsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else {
            // Decrement children if it's greater than 1
            if cell.count > 0 {
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
                childCount = cell.count
            }
        }
        
        updateTotalTravelerCount()
    }
    
    func updateTotalTravelerCount() {
        let totalTravelers = adultsCount + childCount + infantsCount
        print("Total Count === \(totalTravelers)")
        // Store the total count in UserDefaults or perform any other necessary actions.
        UserDefaults.standard.set(totalTravelers, forKey: "totalTravellerCount")
    }
    
    
    
    func gotoCruiseDetailsVC() {
        
        let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Passengers"
        defaults.set(totaltraverlers, forKey: UserDefaultsKeys.cruistotalpassengercount)
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        
        defaults.set(adultsCount, forKey: UserDefaultsKeys.cruisadultCount)
        defaults.set(childCount, forKey: UserDefaultsKeys.cruischildCount)
        defaults.set(infantsCount, forKey: UserDefaultsKeys.cruisinfantsCount)
        
        gotoCruiseDetailsVC()
        
    }
    
    
    
    
}


