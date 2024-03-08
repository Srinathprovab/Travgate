

import Foundation


struct AirlineListModel : Codable {
    
    let airline_list : [Airline_list]?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case airline_list = "airline_list"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airline_list = try values.decodeIfPresent([Airline_list].self, forKey: .airline_list)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}




struct Airline_list : Codable {
    let id : String?
    let airline_name : String?
    let airline_code : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case airline_name = "airline_name"
        case airline_code = "airline_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
        airline_code = try values.decodeIfPresent(String.self, forKey: .airline_code)
    }

}
