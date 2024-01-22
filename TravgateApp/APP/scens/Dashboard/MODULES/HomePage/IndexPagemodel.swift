//
//  IndexPagemodel.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import Foundation
struct IndexPagemodel : Codable {
    let city_data_list : [City_data_list1]?
    let status : Bool?
    let topHotelDetails : [TopHotelDetails]?
    let topFlightDetails : [TopFlightDetails]?
    let deal_code_list : [Deal_code_list]?

    enum CodingKeys: String, CodingKey {

        case city_data_list = "city_data_list"
        case status = "status"
        case topHotelDetails = "topHotelDetails"
        case topFlightDetails = "topFlightDetails"
        case deal_code_list = "deail_code_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_data_list = try values.decodeIfPresent([City_data_list1].self, forKey: .city_data_list)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        topHotelDetails = try values.decodeIfPresent([TopHotelDetails].self, forKey: .topHotelDetails)
        topFlightDetails = try values.decodeIfPresent([TopFlightDetails].self, forKey: .topFlightDetails)
        deal_code_list = try values.decodeIfPresent([Deal_code_list].self, forKey: .deal_code_list)
    }

}
