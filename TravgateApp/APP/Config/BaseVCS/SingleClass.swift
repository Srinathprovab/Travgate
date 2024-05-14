//
//  SingleClass.swift
//  TravgateApp
//
//  Created by FCI on 04/01/24.
//

import Foundation
import UIKit
import EasyTipView


func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
}

//MARK: - INITIAL SETUP LABELS
func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}


class MySingleton {
    // Declare static constant instance
    static let shared = MySingleton()
    
    // Declare your variables
    var loderString = "loder"
    var myVariable1: Int
    var myVariable2: String
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    
    //Home Page
    var tabselect = String()
    var indexpagevm:IndexPageViewModel?
    var topFlightDetails = [TopFlightDetails]()
    var topHotelDetails = [City_guides]()
    var deail_code_list = [Deail_code_list]()
    var currencyListArray = [Currency_list]()
    var cruiseList = [CruiseData]()
    var cruise : CruiseModel?
    var cruiseDetails : CruiseDetailsModel?
    var bhotelDetials:Hotel_details?
    var user_specification = [String]()
    var hotel_user_specification = [User_specification]()
    var roompaxesdetails = [Room_paxes_details]()
    var hotelAddonServices = [HotelAddonModel]()
    var fareRulesData = [FareRulesData]()
    var selectedAddonServices: [SelectedAddonService] = []
    var mealListArray = [Meals_list]()
    var ssrListArray = [Ssr_list]()
    var journeyKeyArray = [String]()
    var farekey = String()
    var selectedFares = [SelectFare]()
    var indexpathA = [IndexPath]()
    
    //Flight Search
    var loderimgurl = String()
    var afterResultsBool = false
    var directFlightBool = false
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var acount = 0
    var ccount = 0
    var icount = 0
    var infoArray = [String]()
    var countrylist = [Country_list]()
    var flights = [[FlightList]]()
    var callboolapi = false
    var bookingsource = String()
    var bookingsourcekey = String()
    var searchid = String()
    var traceid = String()
    var selectedResult = String()
    var tmpFlightPreBookingId = String()
    var accesskeytp = String()
    var fd : [[ItinearyFlightDetails]]?
    let dateFormatter = DateFormatter()
    var similarflightList = [[FlightList]]()
    var flightPriceDetails: PriceDetails?
    var baggageDetails = [Baggage_details]()
    var mpbpriceDetails: PriceDetails?
    var mpbFlightData : MPBFlightDetails?
    var frequent_flyersArray = [Frequent_flyers]()
    var addonServices = [Addon_services]()
    var ageCategory: AgeCategory = .adult
    var passportExpireDateBool = false
    var passengertypeArray = [String]()
    var positionsCount = 0
    var searchTextArray = [String]()
    var payemail = String()
    var regpassword = String()
    var paymobile = String()
    var paymobilecountrycode = String()
    var hotelcountrycode = String()
    var checkTermsAndCondationStatus = false
    var directflightString = String()
    var returnDateTapbool = false
    var totalselectedDepfareprice = Double()
    var totalselectedRetfareprice = Double()
    var totalselectedfareprice = Double()
    
    var guestbool = false
    var nationalityCode = String()
    var email = String()
    var password = String()
    var mobile = String()
    var fname = String()
    var lname = String()
    var travelfrom = String()
    var travelto = String()
    var mrtitle = String()
    var totalnights = String()
    var promocodebool = false
    
    
    var addBaggageBool = false
    var mealBool = false
    var addMealBool = false
    var addInsuranceBool = false
    var addSpecialAssistanceBool = false
    var addSeatBool = false
    var addAirportTransfersBool = false
    
    var enablePaymentButtonBool1 = false
    var enablePaymentButtonBool2 = false
    
    var selected_meals_codeArray = [String]()
    var selected_special_assistance_codeArray = [String]()
    var addon_servicesArray = [String]()
    
    
    var visaNationalityCode = String()
    var visaResidencyCode = String()
    var visaDestinationCode = String()
    var visaCountryCode = String()
    var cruiseKeyStr = String()
    var cruiseCountryCode = String()
    var selectedResultStr = String()
    
    var insurencetravelcode = String()
    var insurencwhomcode = String()
    var insurenczonecode = String()
    var insurencmultitripscode = String()
    var insurencePaxCount = "1"
    var insurenceDepDate = String()
    var insurenceArrivalDate = String()
    
    var bookingsrc = String()
    var htoken = String()
    var htokenkey = String()
    var hoteladultscount = Int()
    var hotelchildcount = Int()
    
    var merchantid = String()
    var sessionid = String()
    var farerulesrefKey = [[String]]()
    var farerulesrefContent = [[String]]()
    var tapRegorLogonBool = false
    
    var confpassword = String()
    var recentData:[Recent_searches]?
    var Recentsearches = [Recent_searches]()
    var clist = [All_country_code_list]()
    var airlinelist = [AirlineDate]()
    var addson:Addson = .nothing
    var addonSelectedArray = [String]()
    var selectedAddonTotalPrice = 0
    var afterAddonAmountAdded = 0
    var moreDetailsData : MoreDetailsData?
    var fareFlightlistArray = [Onward]()
    var fareReturnFlightlistArray = [FligtsFareReturn]()
    var selectedIndexPathsDeparture: Set<IndexPath> = []
    var selectedIndexPathsReturn: Set<IndexPath> = []
    
    
    //View Models
    var loginvm:LoginViewModel?
    var vm:FlightListViewModel?
    var fdvm:FlightDetailsViewModel?
    var resetpasswordvm:ResetPasswordViewModel?
    var registervm:RegisterViewModel?
    var profilevm:ProfileViewModel?
    var profiledata:ProfileData?
    var logoutvm:LogoutViewModel?
    var recentsearchvm:SearchDataViewModel?
    var countrylistvm:AllCountryCodeListViewModel?
    var lodervm:SearchLoaderViewModel?
    var hotellodervm:SearchHotelLoderViewModel?
    var airlinevm:GetAirlineViewModel?
    var viewmodel1:MobileSecureBookingViewModel?
    var visavm:VisaEnquireyViewModel?
    var cruisevm:CruiseViewModel?
    var cruisedetailsvm:CruiseDetailsViewModel?
    var moredetailsvm:MoreDetailsViewModel?
    var currencylistvm:CurrencyListViewModel?
    var contactusvm:mobilecontactusViewModel?
    var farelistvm:SelectFareViewModel?
    var mpbvm:MPBViewModel?
    var mobilepaymentvm:MobilePaymentVM?
    var passengerDetailsVM:MobileProcessPassengerDetailVM?
    var getInsuranceItemsVM:GetInsuranceItemsVM?
    
    
    //TIMER
    weak var delegate: TimerManagerDelegate?
    var timerDidFinish = false
    var timer: Timer?
    var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var preferences = EasyTipView.Preferences()
    

    func setupTipView(arrowPosition:EasyTipView.ArrowPosition){
        preferences.drawing.font = .OpenSansMedium(size: 13)
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = .Buttoncolor
        preferences.drawing.arrowPosition = arrowPosition
        
        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1.5
        preferences.animating.dismissDuration = 1.5
        
        EasyTipView.globalPreferences = preferences
    }
    
    
    // Private initializer to prevent multiple instances
    private init() {
        myVariable1 = 0
        myVariable2 = "Default value"
    }
    
    
    
    //MARK: - ExecuteOnce
    func callonce() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrencyType)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    
    //MARK: - convert Date Format
    func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = f1
        
        guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = f2
        
        return convertDateFormatter.string(from: oldDate)
    }
    
    
    
    //MARK: - getCountryList
    func getCountryList() {
        
       
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "clist", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [Country_list]].self, from: jsonData)
                
                // Access the array of countries using the "country_list" key
                if let countries = jsonDictionary["country_list"] {
                    self.countrylist = countries
                    
                } else {
                    print("Unable to find 'country_list' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
        
    }
    
    
    
    //MARK: - convertToDesiredFormat

    func convertToDesiredFormat(_ inputString: String) -> String {
        if let number = Int(inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            if inputString.contains("Kilograms") {
                return "\(number) kg"
            } else if inputString.contains("Kg") {
                return "\(number) Kilograms"
            } else if inputString.contains("NumberOfPieces") {
                return "\(number) Piece per person."
            }
        }
        return "Invalid input format."
    }
    
    
    
   
    
    //MARK: - Timer SETUP
    func startTimer(time:Int) {
        endBackgroundTask() // End any existing background task (if any)
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }

        // Reset the totalTime to its initial value (e.g., 60 seconds)
        totalTime = time

        // Schedule the timer in the common run loop mode
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }


    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            delegate?.updateTimer()
        } else {
            sessionStop()
            delegate?.timerDidFinish()
            endBackgroundTask()
        }
    }

    @objc func sessionStop() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }


    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    
    func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                      NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
    
    func convertToPC(input: String) -> String? {
        // Split the input string by space
        let components = input.components(separatedBy: " ")
        
        // Check if the input string follows the "NumberOfPieces X" format
        if components.count == 2, components[0] == "NumberOfPieces", let number = Int(components[1]) {
            return "\(number)pc"
        }
        
        // Check if the input string follows the "X Kilograms" format
        if components.count == 2, let number = Int(components[0]), components[1].lowercased() == "kilograms" {
            return "\(number)kg"
        }
        
        // Return nil if the input format is invalid
        return nil
    }

   
    
}


protocol TimerManagerDelegate: AnyObject {
    func timerDidFinish()
    func updateTimer()
}


