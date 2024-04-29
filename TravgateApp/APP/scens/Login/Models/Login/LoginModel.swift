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
    //  let user_id : String?
    let msg : String?
    let message : String?
    let logindetails : Logindetails?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        //  case user_id = "user_id"
        case msg = "msg"
        case message = "message"
        case logindetails = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        //  user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        logindetails = try values.decodeIfPresent(Logindetails.self, forKey: .logindetails)
    }
    
}

struct Logindetails : Codable {
    let user_id : String?
    let email : String?
    let country_code : String?
    let phone : String?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case email = "email"
        case country_code = "country_code"
        case phone = "phone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }
    
}
