//
//  FlightDetailsModel.swift
//  TravgateApp
//
//  Created by FCI on 06/01/24.
//

import Foundation


struct FlightDetailsModel : Codable {
    
    let status : Bool?
    let journeySummary : [JourneySummary]?
    let flightDetails : [[ItinearyFlightDetails]]?
    let baggage_details : [Baggage_details]?
    let priceDetails : PriceDetails?
    let custom_farerules : Custom_farerules?
    let fare_rule_ref_key : String?
    let farerulesref_content : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case journeySummary = "journeySummary"
        case flightDetails = "flightDetails"
        case baggage_details = "baggage_details"
        case priceDetails = "priceDetails"
        case custom_farerules = "custom_farerules"
        case fare_rule_ref_key = "fare_rule_ref_key"
        case farerulesref_content = "farerulesref_content"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        journeySummary = try values.decodeIfPresent([JourneySummary].self, forKey: .journeySummary)
        flightDetails = try values.decodeIfPresent([[ItinearyFlightDetails]].self, forKey: .flightDetails)
        baggage_details = try values.decodeIfPresent([Baggage_details].self, forKey: .baggage_details)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
        custom_farerules = try values.decodeIfPresent(Custom_farerules.self, forKey: .custom_farerules)
        fare_rule_ref_key = try values.decodeIfPresent(String.self, forKey: .fare_rule_ref_key)
        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
    }

}
