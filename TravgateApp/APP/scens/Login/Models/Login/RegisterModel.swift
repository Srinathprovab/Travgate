//
//  RegisterModel.swift
//  TravgateApp
//
//  Created by FCI on 23/01/24.
//

import Foundation
struct RegisterModel : Codable {
    let status : Bool?
    let msg : String?
    let data : RegisterData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(RegisterData.self, forKey: .data)
    }

}



struct RegisterData : Codable {
    let status : Int?
    let user_id : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
    }

}
