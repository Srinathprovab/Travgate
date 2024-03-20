//
//  HotelBookingModel.swift
//  Travgate
//
//  Created by FCI on 20/03/24.
//

import Foundation


struct HotelBookingModel : Codable {
    let status : Int?
    let msg : String?
    let data : HotelBookingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HotelBookingData.self, forKey: .data)
    }

}
