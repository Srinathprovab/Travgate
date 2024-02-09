//
//  RecentSearches.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import Foundation

struct Recent_searches : Codable {
    let origin : String?
   // let json_data : String?
    let arr_data : Arr_data?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
      //  case json_data = "json_data"
        case arr_data = "arr_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
       // json_data = try values.decodeIfPresent(String.self, forKey: .json_data)
        arr_data = try values.decodeIfPresent(Arr_data.self, forKey: .arr_data)
    }

}
