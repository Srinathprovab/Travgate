//
//  MPBFlightDetails.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import Foundation

struct MPBFlightDetails : Codable {
    let summary : [Summary]?
    let details : [[Details]]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
        details = try values.decodeIfPresent([[Details]].self, forKey: .details)
    }

}
