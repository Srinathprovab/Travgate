
import Foundation
struct Room_paxes_details : Codable {
	let xml_net : String?
	let no_of_rooms : Int?
	let room_name : String?
	let net : String?
	let xml_currency : String?
	let rateKey : String?
	let childrenAges_with_year : String?
	let no_of_children : String?
	let childrenAges : String?
	let currency : String?
	let boardName : String?
	let no_of_adults : String?

	enum CodingKeys: String, CodingKey {

		case xml_net = "xml_net"
		case no_of_rooms = "no_of_rooms"
		case room_name = "room_name"
		case net = "net"
		case xml_currency = "xml_currency"
		case rateKey = "rateKey"
		case childrenAges_with_year = "childrenAges_with_year"
		case no_of_children = "no_of_children"
		case childrenAges = "childrenAges"
		case currency = "currency"
		case boardName = "boardName"
		case no_of_adults = "no_of_adults"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
		no_of_rooms = try values.decodeIfPresent(Int.self, forKey: .no_of_rooms)
		room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
		net = try values.decodeIfPresent(String.self, forKey: .net)
		xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		childrenAges_with_year = try values.decodeIfPresent(String.self, forKey: .childrenAges_with_year)
		no_of_children = try values.decodeIfPresent(String.self, forKey: .no_of_children)
		childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
		no_of_adults = try values.decodeIfPresent(String.self, forKey: .no_of_adults)
	}

}
