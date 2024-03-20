

import Foundation
struct Hotel_details : Codable {
    let hotel_code : String?
    let city_code : String?
    let country_code : String?
    let city_name : String?
    let country_name : String?
    let name : String?
    let address : String?
    let phone_number : String?
    let fax : String?
    let email : String?
    let image : String?
    let thumb_image : String?
    let images : [Images]?
    let accomodation_cstr : String?
    let location : String?
    let star_rating : Int?
    let latitude : String?
    let longitude : String?
    let facility_cstr : String?
    let token : String?
    let tokenKey : String?
    let format_ame : [Format_ame]?
    let format_desc : [Format_desc]?
    let rooms : [[Rooms]]?

    enum CodingKeys: String, CodingKey {

        case hotel_code = "hotel_code"
        case city_code = "city_code"
        case country_code = "country_code"
        case city_name = "city_name"
        case country_name = "country_name"
        case name = "name"
        case address = "address"
        case phone_number = "phone_number"
        case fax = "fax"
        case email = "email"
        case image = "image"
        case thumb_image = "thumb_image"
        case images = "images"
        case accomodation_cstr = "accomodation_cstr"
        case location = "location"
        case star_rating = "star_rating"
        case latitude = "latitude"
        case longitude = "longitude"
        case facility_cstr = "facility_cstr"
        case token = "Token"
        case tokenKey = "TokenKey"
        case format_ame = "format_ame"
        case format_desc = "format_desc"
        case rooms = "rooms"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
        format_ame = try values.decodeIfPresent([Format_ame].self, forKey: .format_ame)
        format_desc = try values.decodeIfPresent([Format_desc].self, forKey: .format_desc)
        rooms = try values.decodeIfPresent([[Rooms]].self, forKey: .rooms)
    }

}



struct Format_ame : Codable {
    let ame : String?
    
    
    enum CodingKeys: String, CodingKey {
        case ame = "ame"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ame = try values.decodeIfPresent(String.self, forKey: .ame)
    }
    
}

