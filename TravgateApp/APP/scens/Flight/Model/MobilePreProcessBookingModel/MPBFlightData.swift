//
//  MPBFlightData.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import Foundation

struct MPBFlightData : Codable {
    
    let fareType : String?
    let token : String?
    let token_key : String?
    let flight_details : MPBFlightDetails?
    let price : Price?


    enum CodingKeys: String, CodingKey {

       
        case fareType = "FareType"
        case token = "token"
        case token_key = "token_key"
        case flight_details = "flight_details"
        case price = "price"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        flight_details = try values.decodeIfPresent(MPBFlightDetails.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        
    }

}
