

import Foundation
struct Cancellation_string : Codable {
	let policy : String?
	let room_name : String?

	enum CodingKeys: String, CodingKey {

		case policy = "policy"
		case room_name = "room_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		policy = try values.decodeIfPresent(String.self, forKey: .policy)
		room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
	}

}
