//
//  IndexPagemodel.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import Foundation
struct IndexPagemodel : Codable {
    let status : Bool?
    let topFlightDetails : [TopFlightDetails]?
    let topHotelDetails : [TopHotelDetails]?
    let deail_code_list : [Deail_code_list]?
    let city_guides : [City_guides]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case topFlightDetails = "topFlightDetails"
        case topHotelDetails = "topHotelDetails"
        case deail_code_list = "deail_code_list"
        case city_guides = "city_guides"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        topFlightDetails = try values.decodeIfPresent([TopFlightDetails].self, forKey: .topFlightDetails)
        topHotelDetails = try values.decodeIfPresent([TopHotelDetails].self, forKey: .topHotelDetails)
        deail_code_list = try values.decodeIfPresent([Deail_code_list].self, forKey: .deail_code_list)
        city_guides = try values.decodeIfPresent([City_guides].self, forKey: .city_guides)
    }

}
