//
//  SearchDataModel.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import Foundation

struct SearchDataModel : Codable {
    let recent_searches : [Recent_searches]?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case recent_searches = "recent_searches"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recent_searches = try values.decodeIfPresent([Recent_searches].self, forKey: .recent_searches)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
