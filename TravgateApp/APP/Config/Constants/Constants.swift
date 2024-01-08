//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData


/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
//var data : Data?
var loderBool = false
var basicloderBool = false

var BASE_URL = "https://travrun.com/pro_new/mobile/index.php/"
var BASE_URL1 = "https://travrun.com/pro_new/mobile/index.php/"
var defaultCountryCode = "+91"
var mobilenoMaxLength = Int()
var mobilenoMaxLengthBool = false


//DASHBOARD
var callapibool = Bool()

//MARK: - FILTER RELATED VARIABLES
var filterTap = String()
var filterPrice = String()
var prices = [String]()
var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()
var mapModelArray: [MapModel] = []
var faretypeArray = [String]()
var directFlightBool = true
var facilityArray = [String]()
var AirlinesArray = [String]()
var ConnectingFlightsArray = [String]()
var ConnectingAirportsArray = [String]()
var luggageArray = [String]()
var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()
var kwdPriceArray = [String]()
var dateArray = [String]()

struct MapModel {
    var longitude =  String()
    var latitude =  String()
    var hotelname = String()
}

/* URL endpoints */
struct ApiEndpoints {
    
    static let indexpage = "general/getTopFlightHotelDestination"
    static let get_airport_code_list = "ajax/get_airport_code_list"
    static let general_mobile_pre_flight_search = "general/mobile_pre_flight_search"
    static let flight_getFlightDetails = "flight/getFlightDetails"
    static let flight_mobile_pre_process_booking = "flight/mobile_pre_process_booking"
    static let flight_mobile_pre_booking = "flight/mobile_pre_booking"
    
    
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var mobilecountrycode = "mobilecountrycode"
    static var mobilecountryname = "mobilecountryname"
    static var tabselect = "tabselect"
    static var nationality = "nationality"
    static var airlinescode = "airlinescode"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var usermobilecode = "usermobilecode"
    static var journeyType = "Journey_Type"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectedCurrency = "selectedCurrency"
    static var selectedCurrencyType = "selectedCurrencyType"
    static var totalTravellerCount = "totalTravellerCount"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var journeyCitys = "journeyCitys"
    static var journeyDates = "journeyDates"
    static var cellTag = "cellTag"
    static var flightrefundtype = "flightrefundtype"
    
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var rselectClass = "rselect_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var fcity = "fcity"
    static var tcity = "tcity"
    
    //ROUND TRIP
    //    static var rlocationcity = "rlocation_city"
    //    static var rfromCity = "rfromCity"
    //    static var rtoCity = "rtoCity"
    //    static var rcalDepDate = "rcalDepDate"
    //    static var rcalRetDate = "rcalRetDate"
    //    static var radultCount = "rAdult_Count"
    //    static var rchildCount = "rChild_Count"
    //    static var rhadultCount = "rHAdult_Count"
    //    static var rhchildCount = "rHChild_Count"
    //    static var rinfantsCount = "rInfants_Count"
    //    static var rselectClass = "rselect_class"
    //    static var rfromlocid = "rfrom_loc_id"
    //    static var rtolocid = "rto_loc_id"
    //    static var rfromcityname = "rfromcityname"
    //    static var rtocityname = "rtocityname"
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    
    //    static var mcalDepDate = "mcalDepDate"
    //    static var mcalRetDate = "mcalRetDate"
    //    static var madultCount = "mAdult_Count"
    //    static var mchildCount = "mChild_Count"
    //    static var mhadultCount = "mHAdult_Count"
    //    static var mhchildCount = "mHChild_Count"
    //    static var minfantsCount = "mInfants_Count"
    //    static var mselectClass = "mselect_class"
    
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    static var hnationality = "hnationality"
    static var hnationalitycode = "hnationalitycode"
    
    
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var travellerDetails = "traveller_Details"
    // static var mtravellerDetails = "mtraveller_Details"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
