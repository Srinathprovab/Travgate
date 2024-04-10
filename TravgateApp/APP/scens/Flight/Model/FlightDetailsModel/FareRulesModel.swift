//
//  FareRulesModel.swift
//  Travgate
//
//  Created by FCI on 04/04/24.
//

import Foundation

struct FareRulesModel : Codable {
    let status : Bool?
    let data : [FareRulesData]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([FareRulesData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct FareRulesData : Codable {
    
    let rule_heading : String?
    let rule_category : String?
    let rule_type : String?
    let rule_content : String?

    enum CodingKeys: String, CodingKey {

        case rule_heading = "rule_heading"
        case rule_category = "rule_category"
        case rule_type = "rule_type"
        case rule_content = "rule_content"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rule_heading = try values.decodeIfPresent(String.self, forKey: .rule_heading)
        rule_category = try values.decodeIfPresent(String.self, forKey: .rule_category)
        rule_type = try values.decodeIfPresent(String.self, forKey: .rule_type)
        rule_content = try values.decodeIfPresent(String.self, forKey: .rule_content)
    }

}
