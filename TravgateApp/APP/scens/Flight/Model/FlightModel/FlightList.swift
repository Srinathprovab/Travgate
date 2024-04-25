//
//  FlightList.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import Foundation

struct FlightList : Codable {
    
    
    let fareType : String?
    let flight_details : FlightDetails?
    let price : Price?
    let access_key : String?
    let selectedResult : String?
    let booking_source : String?
    let booking_source_key : String?
    let farerulesref_Key : [[String]]?
    let farerulesref_content : [[String]]?
    let journeyKey : [String]?
    let serialized_journeyKey : String?
    let fareFamily : FareFamily?
    
    
    enum CodingKeys: String, CodingKey {
        
        
        case fareType = "FareType"
        case flight_details = "flight_details"
        case price = "price"
        case access_key = "access_key"
        case selectedResult = "selectedResult"
        case booking_source = "booking_source"
        case booking_source_key = "booking_source_key"
        case farerulesref_Key = "Farerulesref_Key"
        case farerulesref_content = "Farerulesref_content"
        case journeyKey = "journeyKey"
        case serialized_journeyKey = "serialized_journeyKey"
        case fareFamily = "fareFamily"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        flight_details = try values.decodeIfPresent(FlightDetails.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        farerulesref_Key = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_Key)
        farerulesref_content = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_content)
        journeyKey = try values.decodeIfPresent([String].self, forKey: .journeyKey)
        serialized_journeyKey = try values.decodeIfPresent(String.self, forKey: .serialized_journeyKey)
        fareFamily = try values.decodeIfPresent(FareFamily.self, forKey: .fareFamily)
        
    }
    
}
