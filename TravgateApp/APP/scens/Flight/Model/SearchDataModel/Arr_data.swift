

import Foundation
struct Arr_data : Codable {
    let trip_type : String?
    let adult : String?
    let child : String?
    let infant : String?
    let v_class : String?
    let from : String?
    let from_loc_id : String?
    let to : String?
    let to_loc_id : String?
    let depature : String?
    let sdreturn : String?
    let out_jrn : String?
    let ret_jrn : String?
    let direct_flight : String?
    let psscarrier : String?
    let search_flight : String?
    let user_id : String?
    let search_source : String?
    let currency : String?
    let carrier : String?
    let from_custom : String?
    let to_custom : String?
    
    enum CodingKeys: String, CodingKey {
        
        case trip_type = "trip_type"
        case adult = "adult"
        case child = "child"
        case infant = "infant"
        case v_class = "v_class"
        case from = "from"
        case from_loc_id = "from_loc_id"
        case to = "to"
        case to_loc_id = "to_loc_id"
        case depature = "depature"
        case sdreturn = "return"
        case out_jrn = "out_jrn"
        case ret_jrn = "ret_jrn"
        case direct_flight = "direct_flight"
        case psscarrier = "psscarrier"
        case search_flight = "search_flight"
        case user_id = "user_id"
        case search_source = "search_source"
        case currency = "currency"
        case carrier = "carrier"
        case from_custom = "from_custom"
        case to_custom = "to_custom"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        adult = try values.decodeIfPresent(String.self, forKey: .adult)
        child = try values.decodeIfPresent(String.self, forKey: .child)
        infant = try values.decodeIfPresent(String.self, forKey: .infant)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        depature = try values.decodeIfPresent(String.self, forKey: .depature)
        sdreturn = try values.decodeIfPresent(String.self, forKey: .sdreturn)
        out_jrn = try values.decodeIfPresent(String.self, forKey: .out_jrn)
        ret_jrn = try values.decodeIfPresent(String.self, forKey: .ret_jrn)
        direct_flight = try values.decodeIfPresent(String.self, forKey: .direct_flight)
        psscarrier = try values.decodeIfPresent(String.self, forKey: .psscarrier)
        search_flight = try values.decodeIfPresent(String.self, forKey: .search_flight)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        search_source = try values.decodeIfPresent(String.self, forKey: .search_source)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        from_custom = try values.decodeIfPresent(String.self, forKey: .from_custom)
        to_custom = try values.decodeIfPresent(String.self, forKey: .to_custom)
    }
    
}
