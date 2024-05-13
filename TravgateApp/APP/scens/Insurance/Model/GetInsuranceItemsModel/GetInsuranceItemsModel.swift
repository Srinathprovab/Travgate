//
//  GetInsuranceItemsModel.swift
//  Travgate
//
//  Created by FCI on 13/05/24.
//

import Foundation

struct GetInsuranceItemsModel : Codable {
    let status : Bool?
    let msg : String?
    let data : [GetInsuranceItemsModelData]?
    let search_id : Int?
    let message : String?
    

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
        case search_id = "search_id"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([GetInsuranceItemsModelData].self, forKey: .data)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct GetInsuranceItemsModelData : Codable {
    let title : String?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}
