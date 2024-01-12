//
//  MobilePassengerdetailsModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation

struct MobilePassengerdetailsModel : Codable {
    let message : String?
    let search_id : String?
    let app_reference : String?
    let booking_source : String?
    let status : Bool?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case search_id = "search_id"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case status = "status"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
