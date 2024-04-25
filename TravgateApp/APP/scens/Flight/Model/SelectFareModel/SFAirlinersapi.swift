//
//  SFAirlinersapi.swift
//  Travgate
//
//  Created by FCI on 24/04/24.
//

import Foundation

struct SFAirlinersapi : Codable {
    let j9 : String?

    enum CodingKeys: String, CodingKey {

        case j9 = "J9"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        j9 = try values.decodeIfPresent(String.self, forKey: .j9)
    }

}
