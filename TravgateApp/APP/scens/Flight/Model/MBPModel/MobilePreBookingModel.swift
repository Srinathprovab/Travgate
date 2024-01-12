//
//  MobilePreBookingModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation
struct MobilePreBookingModel : Codable {
    
    let status : Bool?
    let message : String?
    let data : MobilePreBookingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(MobilePreBookingData.self, forKey: .data)
    }

}

struct MobilePreBookingData : Codable {
    let form_url : String?
    let search_id : String?
    let app_reference : String?
    let promocode_val : String?

    enum CodingKeys: String, CodingKey {

        case form_url = "form_url"
        case search_id = "search_id"
        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
    }

}

