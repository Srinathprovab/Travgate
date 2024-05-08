

import Foundation
struct User_specification : Codable {
	let runno : String?
	let id : String?
	let specialrequests_name : String?
	let specialrequests_value : String?

	enum CodingKeys: String, CodingKey {

		case runno = "runno"
		case id = "id"
		case specialrequests_name = "specialrequests_name"
		case specialrequests_value = "specialrequests_value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		runno = try values.decodeIfPresent(String.self, forKey: .runno)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		specialrequests_name = try values.decodeIfPresent(String.self, forKey: .specialrequests_name)
		specialrequests_value = try values.decodeIfPresent(String.self, forKey: .specialrequests_value)
	}

}
