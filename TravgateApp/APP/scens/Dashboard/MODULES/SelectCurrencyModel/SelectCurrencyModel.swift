//
//  SelectCurrencyModel.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import Foundation


struct SelectCurrencyModel : Codable {
    let data : [SelectCurrencyData]?
    let status : Bool?
    let msg : String?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case status = "status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SelectCurrencyData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
    
}



struct SelectCurrencyData : Codable {
    let origin : String?
    let symbol : String?
    let value : String?
    let name : String?
    let type : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case origin = "origin"
        case symbol = "symbol"
        case value = "value"
        case name = "name"
        case type = "type"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
    
}
