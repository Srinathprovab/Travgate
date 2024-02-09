//
//  SearchLoaderModel.swift
//  TravgateApp
//
//  Created by FCI on 09/02/24.
//

import Foundation
struct SearchLoaderModel : Codable {
    let status : Bool?
    let searchdata : SearchData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case searchdata = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        searchdata = try values.decodeIfPresent(SearchData.self, forKey: .searchdata)
    }

}

struct SearchData : Codable {
    let image : String?
    let from : String?
    let to : String?
    let trip_type : String?
    let from_date : String?
    let to_date : String?
    let adult : String?
    let messge : String?

    enum CodingKeys: String, CodingKey {

        case image = "image"
        case from = "from"
        case to = "to"
        case trip_type = "trip_type"
        case from_date = "from_date"
        case to_date = "to_date"
        case adult = "adult"
        case messge = "messge"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
        to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
        adult = try values.decodeIfPresent(String.self, forKey: .adult)
        messge = try values.decodeIfPresent(String.self, forKey: .messge)
    }

}
