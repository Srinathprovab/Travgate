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
        
        MySingleton.shared.vm = FlightListViewModel(self)
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
    
    
    
    
    override func didTapOnFlightDetails(cell: FlightResultTVCell) {
        print("didTapOnFlightDetails")
    }
    
    override func didTapOnBookNowBtnAction(cell: FlightResultTVCell) {
        print("didTapOnBookNowBtnAction")
    }
    
    
    
    override func didTapOnMoreSimilarFlightBtnAction(cell:FlightResultTVCell){
        guard let vc = SimilarFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func didTapOnModifySearchBtmAction(_ sender: Any) {
        guard let vc = ModifySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        print("didTapOnSortBtnAction")
    }
    
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    
    @IBAction func didTapOnnextDayFlightSearchBtnAction(_ sender: Any) {
        didTapOnNextDateBtnTapAction()
    }
    
    
    @IBAction func didTapOnPrivousdayFlightSearchBtnAction(_ sender: Any) {
        didTapOnPreviousDateBtnAction()
    }
    
    
    
    
}


extension FlightResultVC: FlightListModelProtocal {
    
    
    func callAPI() {
        self.holderView.isHidden = true
        MySingleton.shared.vm?.CALL_FLIGHT_SEARCH_API(dictParam: MySingleton.shared.payload)
        
    }
    
    func flightList(response: FlightModel) {
        
        self.holderView.isHidden = false
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fcity) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tcity) ?? "")"
        paxlbl.text = "\(MySingleton.shared.adultsCount) Adults | \(MySingleton.shared.childCount) Child | \(MySingleton.shared.infantsCount) Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
        depDatelbl.text = response.data?.search_params?.depature ?? ""
        retDatelbl.text = response.data?.search_params?.searchreturn ?? ""
        citycodeslbl.text = "(\(response.data?.search_params?.from_loc ?? "") - \(response.data?.search_params?.to_loc ?? ""))"
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            datelbl.text = MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")
            
        }else {
            datelbl.text = "\(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.depature ?? "", f1: "dd-MM-yyyy", f2: "MMM dd")) - \(MySingleton.shared.convertDateFormat(inputDate: response.data?.search_params?.searchreturn ?? "", f1: "dd-MM-yyyy", f2: "MMM dd"))"
            
        }
        
        MySingleton.shared.flights = response.data?.j_flight_list ?? [[]]
        DispatchQueue.main.async {[self] in
            self.setupTVCell(list: MySingleton.shared.flights)
        }
    }
    
    
    
    
    
    func setupTVCell(list:[[FlightList]]) {
        MySingleton.shared.tablerow.removeAll()
        
        var updatedUniqueList: [[FlightList]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: list)
        
        
        updatedUniqueList.forEach { i in
            i.forEach { j in
                
                let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)

                
                MySingleton.shared.tablerow.append(TableRow(refundable:j.fareType,
                                                            data: similarFlights1,
                                                            moreData: j,
                                                            cellType:.FlightResultTVCell,
                                                            data1: j.flight_details?.summary))
            }
        }
        
        
        
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
}




extension FlightResultVC {
    
    
    
    //MARK: - didTapOnPreviousDateBtnAction
    func didTapOnPreviousDateBtnAction() {
        
        holderView.isHidden = true
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the previous day's date
                let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let previousDayString = dateFormatter.string(from: previousDay!)
                print("previousDayString ==== > \(previousDayString)")
                defaults.set(previousDayString, forKey: UserDefaultsKeys.calDepDate)
                MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = previousDayString
                
                callAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                
                if self.retDatelbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    print("nextDayString ==== > \(nextDayString)")
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                    MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
        
    }
    
    //MARK: - didTapOnNextDateBtnTapAction
    func didTapOnNextDateBtnTapAction() {
        
        holderView.isHidden = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = nextDayString
                
                callAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                
                if self.retDatelbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                    MySingleton.shared.payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
    }
}



extension FlightResultVC {
    
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_oneway(inputArray: [[FlightList]]) -> [[FlightList]] {
        var uniqueElements: [[FlightList]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [FlightList] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    
    
    
    func similar(fare: Double) -> [[FlightList]] {
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[FlightList]]] = [:]
        
        // Iterate through the FlightList (ensure that FlightList contains the correct data)
        MySingleton.shared.flights.forEach { flightArray in
            flightArray.forEach { flight in
                if let flightFare = Double(String(format: "%.2f", flight.price?.api_total_display_fare ?? "")) {
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[flightFare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([flight])
                        similarFlightsDictionary[flightFare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[flightFare] = [[flight]]
                    }
                }
            }
        }
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare = similarFlightsDictionary[fare] {
            // flightsWithFare will contain an array of flights with api_total_display_fare equal to the specified fare
            return flightsWithFare
        } else {
            // If no similar flights found for the specified fare, return an empty array
            return []
        }
    }
}
