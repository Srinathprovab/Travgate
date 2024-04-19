//
//  PaymentModel.swift
//  Travgate
//
//  Created by FCI on 03/04/24.
//

import Foundation

struct PaymentModel : Codable {
    let status : Int?
    let message : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
