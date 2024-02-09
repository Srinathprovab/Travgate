//
//  SearchHotelLoderModel.swift
//  TravgateApp
//
//  Created by FCI on 09/02/24.
//

import Foundation

struct SearchHotelLoderModel : Codable {
    let status : Bool?
    let searchdata : SearchHotelData?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case searchdata = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        searchdata = try values.decodeIfPresent(SearchHotelData.self, forKey: .searchdata)
    }
    
}


struct SearchHotelData : Codable {
    let image : String?
    let city_name : String?
    let check_in : String?
    let check_out : String?
    let rooms : String?
    let adult : [String]?
    let child : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case image = "image"
        case city_name = "city_name"
        case check_in = "check_in"
        case check_out = "check_out"
        case rooms = "rooms"
        case adult = "adult"
        case child = "child"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
        rooms = try values.decodeIfPresent(String.self, forKey: .rooms)
        adult = try values.decodeIfPresent([String].self, forKey: .adult)
        child = try values.decodeIfPresent([String].self, forKey: .child)
    }
    
}

