//
//  MobilePreProcessBookingModel.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import Foundation

struct MobilePreProcessBookingModel : Codable {
    
    let access_key_tp : String?
    let flight_data : [MPBFlightData]?
    let active_payment_options : [String]?
    let booking_source : String?
    let tmp_flight_pre_booking_id : String?
    let pre_booking_params : Pre_booking_params?
    let search_data : MPBSearchData?
    let frequent_flyers : [Frequent_flyers]?
   
    let status : Int?
    let msg : String?
    enum CodingKeys: String, CodingKey {

        case access_key_tp = "access_key_tp"
        case flight_data = "flight_data"
        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case pre_booking_params = "pre_booking_params"
        case search_data = "search_data"
        case frequent_flyers = "frequent_flyers"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        flight_data = try values.decodeIfPresent([MPBFlightData].self, forKey: .flight_data)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        pre_booking_params = try values.decodeIfPresent(Pre_booking_params.self, forKey: .pre_booking_params)
        search_data = try values.decodeIfPresent(MPBSearchData.self, forKey: .search_data)
        frequent_flyers = try values.decodeIfPresent([Frequent_flyers].self, forKey: .frequent_flyers)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)

    }

}



