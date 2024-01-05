//
//  FlightClass.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import Foundation

struct FlightClass : Codable {
    
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
