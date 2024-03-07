//
//  MoreDetailsModel.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import Foundation

struct MoreDetailsModel : Codable {
    let data : MoreDetailsData?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MoreDetailsData.self, forKey: .data)
    }

}


struct MoreDetailsData : Codable {
    let page_id : String?
    let module_name : String?
    let page_title : String?
    let page_description : String?
    

    enum CodingKeys: String, CodingKey {

        case page_id = "page_id"
        case module_name = "module_name"
        case page_title = "page_title"
        case page_description = "page_description"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_id = try values.decodeIfPresent(String.self, forKey: .page_id)
        module_name = try values.decodeIfPresent(String.self, forKey: .module_name)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        
    }

}
