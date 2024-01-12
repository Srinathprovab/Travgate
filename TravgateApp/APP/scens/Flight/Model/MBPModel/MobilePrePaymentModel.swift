//
//  MobilePrePaymentModel.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import Foundation

struct MobilePrePaymentModel : Codable {
    let status : Bool?
    let message : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}




