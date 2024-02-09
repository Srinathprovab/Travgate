//
//  LoginModel.swift
//  TravgateApp
//
//  Created by FCI on 22/01/24.
//

import Foundation
struct LoginModel : Codable {
    let status : Bool?
    let data : String?
    let user_id : String?
    let msg : String?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case user_id = "user_id"
        case msg = "msg"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
