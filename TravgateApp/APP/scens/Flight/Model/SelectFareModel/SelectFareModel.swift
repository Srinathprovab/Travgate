//
//  SelectFareModel.swift
//  Travgate
//
//  Created by FCI on 24/04/24.
//

import Foundation

struct SelectFareModel : Codable {
    let col_2x_result : Int?
    let search_params : SFSearch_params?
    let attr : SFAttr?
    let search_id : String?
    let booking_url : String?
    let booking_source_key : String?
    let booking_source : String?
    let j_flight_list : [[FlightList]]?
    let journey_id : Int?
    let airlinersapi : SFAirlinersapi?
    let pxtrip_type : String?
    let origin_list : [String]?
    let page_type : String?

    enum CodingKeys: String, CodingKey {

        case col_2x_result = "col_2x_result"
        case search_params = "search_params"
        case attr = "attr"
        case search_id = "search_id"
        case booking_url = "booking_url"
        case booking_source_key = "booking_source_key"
        case booking_source = "booking_source"
        case j_flight_list = "j_flight_list"
        case journey_id = "journey_id"
        case airlinersapi = "airlinersapi"
        case pxtrip_type = "pxtrip_type"
        case origin_list = "origin_list"
        case page_type = "page_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_2x_result = try values.decodeIfPresent(Int.self, forKey: .col_2x_result)
        search_params = try values.decodeIfPresent(SFSearch_params.self, forKey: .search_params)
        attr = try values.decodeIfPresent(SFAttr.self, forKey: .attr)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_url = try values.decodeIfPresent(String.self, forKey: .booking_url)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        j_flight_list = try values.decodeIfPresent([[FlightList]].self, forKey: .j_flight_list)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        airlinersapi = try values.decodeIfPresent(SFAirlinersapi.self, forKey: .airlinersapi)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)
        origin_list = try values.decodeIfPresent([String].self, forKey: .origin_list)
        page_type = try values.decodeIfPresent(String.self, forKey: .page_type)
    }

}
