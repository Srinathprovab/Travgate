//
//  GetAirlineModel.swift
//  TravgateApp
//
//  Created by FCI on 13/02/24.
//

import Foundation

struct GetAirlineModel : Codable {
    let status : Bool?
    let data : [AirlineDate]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([AirlineDate].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


struct AirlineDate : Codable {
    let code : String?
    let name : String?
    let name_ar : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case name_ar = "name_ar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
    }

}
