//
//  CruiseDetailsModel.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import Foundation

struct CruiseDetailsModel : Codable {
    let status : String?
    let cruise_data : Cruise_data?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case cruise_data = "cruise_data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        cruise_data = try values.decodeIfPresent(Cruise_data.self, forKey: .cruise_data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}



struct Cruise_data : Codable {
    let origin : String?
    let heading : String?
    let ar_heading : String?
    let subheading : String?
    let ar_subheading : String?
    let image : String?
    let desc : String?
    let desc_ar : String?
    let dis_q : String?
    let dis_q_ar : String?
    let tnc : String?
    let tnc_ar : String?
    let banner_image : String?
    let more_image : String?
    let iti_image : String?
    let iti_image_ar : String?
    let iti_tit : String?
    let iti_desc : String?
    let iti_tit_ar : String?
    let status : String?
    let status_updated_at : String?
    let created_at : String?
    let created_by : String?
    let created_ip_address : String?
    let updated_at : String?
    let updated_by : String?
    let updated_ip_address : String?
    let deleted_at : String?
    let iti_desc_ar : String?
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case heading = "heading"
        case ar_heading = "ar_heading"
        case subheading = "subheading"
        case ar_subheading = "ar_subheading"
        case image = "image"
        case desc = "desc"
        case desc_ar = "desc_ar"
        case dis_q = "dis_q"
        case dis_q_ar = "dis_q_ar"
        case tnc = "tnc"
        case tnc_ar = "tnc_ar"
        case banner_image = "banner_image"
        case more_image = "more_image"
        case iti_image = "iti_image"
        case iti_image_ar = "iti_image_ar"
        case iti_tit = "iti_tit"
        case iti_desc = "iti_desc"
        case iti_tit_ar = "iti_tit_ar"
        case status = "status"
        case status_updated_at = "status_updated_at"
        case created_at = "created_at"
        case created_by = "created_by"
        case created_ip_address = "created_ip_address"
        case updated_at = "updated_at"
        case updated_by = "updated_by"
        case updated_ip_address = "updated_ip_address"
        case deleted_at = "deleted_at"
        case iti_desc_ar = "iti_desc_ar"
        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        ar_heading = try values.decodeIfPresent(String.self, forKey: .ar_heading)
        subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
        ar_subheading = try values.decodeIfPresent(String.self, forKey: .ar_subheading)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        desc_ar = try values.decodeIfPresent(String.self, forKey: .desc_ar)
        dis_q = try values.decodeIfPresent(String.self, forKey: .dis_q)
        dis_q_ar = try values.decodeIfPresent(String.self, forKey: .dis_q_ar)
        tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
        tnc_ar = try values.decodeIfPresent(String.self, forKey: .tnc_ar)
        banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
        more_image = try values.decodeIfPresent(String.self, forKey: .more_image)
        iti_image = try values.decodeIfPresent(String.self, forKey: .iti_image)
        iti_image_ar = try values.decodeIfPresent(String.self, forKey: .iti_image_ar)
        iti_tit = try values.decodeIfPresent(String.self, forKey: .iti_tit)
        iti_desc = try values.decodeIfPresent(String.self, forKey: .iti_desc)
        iti_tit_ar = try values.decodeIfPresent(String.self, forKey: .iti_tit_ar)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        status_updated_at = try values.decodeIfPresent(String.self, forKey: .status_updated_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        created_ip_address = try values.decodeIfPresent(String.self, forKey: .created_ip_address)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        updated_ip_address = try values.decodeIfPresent(String.self, forKey: .updated_ip_address)
        deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        iti_desc_ar = try values.decodeIfPresent(String.self, forKey: .iti_desc_ar)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}
