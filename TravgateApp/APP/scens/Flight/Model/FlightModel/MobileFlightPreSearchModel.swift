//
//  MobileFlightPreSearchModel.swift
//  Travgate
//
//  Created by FCI on 23/04/24.
//

import Foundation

struct MobileFlightPreSearchModel : Codable {
    let data : [MobileFlightPreSearchData]?
    let msg : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([MobileFlightPreSearchData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}


struct MobileFlightPreSearchData : Codable {
    
    let search_id : Int?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
