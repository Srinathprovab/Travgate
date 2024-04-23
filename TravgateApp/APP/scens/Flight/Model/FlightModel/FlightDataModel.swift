//
//  FlightDataModel.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import Foundation

struct FlightDataModel : Codable {
    let col_2x_result : Bool?
    let is_domestic : Bool?
    let search_params : FlightSearchParams?
    let search_id : String?
    let j_flight_list : [[FlightList]]?
    let journey_id : Int?
    let pxtrip_type : String?
    let traceId : String?
    
    enum CodingKeys: String, CodingKey {
        
        case col_2x_result = "col_2x_result"
        case is_domestic = "is_domestic"
        case search_params = "search_params"
        case search_id = "search_id"
        case j_flight_list = "j_flight_list"
        case journey_id = "journey_id"
        case pxtrip_type = "pxtrip_type"
        case traceId = "traceId"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_2x_result = try values.decodeIfPresent(Bool.self, forKey: .col_2x_result)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        search_params = try values.decodeIfPresent(FlightSearchParams.self, forKey: .search_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        j_flight_list = try values.decodeIfPresent([[FlightList]].self, forKey: .j_flight_list)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)
        traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
    }
    
}
