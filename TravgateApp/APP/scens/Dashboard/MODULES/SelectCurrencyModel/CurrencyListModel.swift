//
//  CurrencyListModel.swift
//  Travgate
//
//  Created by FCI on 08/03/24.
//

import Foundation

struct CurrencyListModel : Codable {
    let status : Bool?
    let currency_list : [Currency_list]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case currency_list = "currency_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        currency_list = try values.decodeIfPresent([Currency_list].self, forKey: .currency_list)
    }

}



struct Currency_list : Codable {
    let name : String?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}
