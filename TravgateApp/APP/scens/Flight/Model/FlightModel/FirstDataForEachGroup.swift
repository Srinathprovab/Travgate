//
//  FirstDataForEachGroup.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import Foundation

//struct FirstDataForEachGroup : Codable {
//    
//    let airPricingSolution_Key : String?
//    let completeItinerary : String?
//    let connections : String?
//    let totalPrice : String?
//    let basePrice : String?
//    let taxes : String?
//    let totalPrice_API : String?
//    let aPICurrencyType : String?
//    let sITECurrencyType : String?
//    let myMarkup : String?
//    let myMarkup_cal : String?
//    let aMarkup : String?
//    let aMarkup_cal : String?
//    let basePrice_Breakdown : String?
//    let taxPrice_Breakdown : String?
//    let admin_markup_amount : Int?
//    let agent_markup_amount : Int?
//    let refundable : Bool?
//    let platingCarrier : String?
//    let fareType : String?
//    let all_Passenger : String?
//    let adults : Int?
//    let childs : Int?
//    let infants : Int?
//    let adults_Base_Price : Double?
//    let childs_Base_Price : Double?
//    let infants_Base_Price : Double?
//    let adults_Tax_Price : Double?
//    let childs_Tax_Price : Double?
//    let infants_Tax_Price : Double?
//    let travelTime : String?
//    let airSegment_Key : String?
//    let baggageAllowance : [[String]]?
//    let farerulesref_Key : [[String]]?
//    let farerulesref_Provider : [[String]]?
//    let farerulesref_content : [[String]]?
//    let flight_details : FlightDetails?
//    let price : Price?
//    //   let fare : [Fare]?
//    let access_key : String?
//    let selectedResult : String?
//    let booking_source : String?
//    let booking_source_key : String?
//    let price_details : PriceDetails?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case airPricingSolution_Key = "AirPricingSolution_Key"
//        case completeItinerary = "CompleteItinerary"
//        case connections = "Connections"
//        case totalPrice = "TotalPrice"
//        case basePrice = "BasePrice"
//        case taxes = "Taxes"
//        case totalPrice_API = "TotalPrice_API"
//        case aPICurrencyType = "APICurrencyType"
//        case sITECurrencyType = "SITECurrencyType"
//        case myMarkup = "MyMarkup"
//        case myMarkup_cal = "myMarkup_cal"
//        case aMarkup = "aMarkup"
//        case aMarkup_cal = "aMarkup_cal"
//        case basePrice_Breakdown = "BasePrice_Breakdown"
//        case taxPrice_Breakdown = "TaxPrice_Breakdown"
//        case admin_markup_amount = "admin_markup_amount"
//        case agent_markup_amount = "agent_markup_amount"
//        case refundable = "Refundable"
//        case platingCarrier = "PlatingCarrier"
//        case fareType = "FareType"
//        case all_Passenger = "All_Passenger"
//        case adults = "Adults"
//        case childs = "Childs"
//        case infants = "Infants"
//        case adults_Base_Price = "Adults_Base_Price"
//        case childs_Base_Price = "Childs_Base_Price"
//        case infants_Base_Price = "Infants_Base_Price"
//        case adults_Tax_Price = "Adults_Tax_Price"
//        case childs_Tax_Price = "Childs_Tax_Price"
//        case infants_Tax_Price = "Infants_Tax_Price"
//        case travelTime = "TravelTime"
//        case airSegment_Key = "AirSegment_Key"
//        case baggageAllowance = "BaggageAllowance"
//        case farerulesref_Key = "Farerulesref_Key"
//        case farerulesref_Provider = "Farerulesref_Provider"
//        case farerulesref_content = "Farerulesref_content"
//        case flight_details = "flight_details"
//        case price = "price"
//        //     case fare = "fare"
//        case access_key = "access_key"
//        case selectedResult = "selectedResult"
//        case booking_source = "booking_source"
//        case booking_source_key = "booking_source_key"
//        case price_details = "price_details"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        airPricingSolution_Key = try values.decodeIfPresent(String.self, forKey: .airPricingSolution_Key)
//        completeItinerary = try values.decodeIfPresent(String.self, forKey: .completeItinerary)
//        connections = try values.decodeIfPresent(String.self, forKey: .connections)
//        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
//        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
//        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
//        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
//        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
//        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
//        myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
//        myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
//        aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
//        aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
//        basePrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .basePrice_Breakdown)
//        taxPrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .taxPrice_Breakdown)
//        admin_markup_amount = try values.decodeIfPresent(Int.self, forKey: .admin_markup_amount)
//        agent_markup_amount = try values.decodeIfPresent(Int.self, forKey: .agent_markup_amount)
//        refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
//        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
//        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
//        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
//        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
//        childs = try values.decodeIfPresent(Int.self, forKey: .childs)
//        infants = try values.decodeIfPresent(Int.self, forKey: .infants)
//        adults_Base_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Base_Price)
//        childs_Base_Price = try values.decodeIfPresent(Double.self, forKey: .childs_Base_Price)
//        infants_Base_Price = try values.decodeIfPresent(Double.self, forKey: .infants_Base_Price)
//        adults_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .adults_Tax_Price)
//        childs_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .childs_Tax_Price)
//        infants_Tax_Price = try values.decodeIfPresent(Double.self, forKey: .infants_Tax_Price)
//        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
//        airSegment_Key = try values.decodeIfPresent(String.self, forKey: .airSegment_Key)
//        baggageAllowance = try values.decodeIfPresent([[String]].self, forKey: .baggageAllowance)
//        farerulesref_Key = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_Key)
//        farerulesref_Provider = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_Provider)
//        farerulesref_content = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_content)
//        flight_details = try values.decodeIfPresent(FlightDetails.self, forKey: .flight_details)
//        price = try values.decodeIfPresent(Price.self, forKey: .price)
//        //    fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
//        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
//        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
//        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
//        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
//        price_details = try values.decodeIfPresent(PriceDetails.self, forKey: .price_details)
//    }
//    
//}
