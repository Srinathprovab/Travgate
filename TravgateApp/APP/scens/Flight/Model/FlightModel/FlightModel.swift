//
//  FlightModel.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import Foundation


struct FlightModel : Codable {
    
    let data : FlightDataModel?
    let msg : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FlightDataModel.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
