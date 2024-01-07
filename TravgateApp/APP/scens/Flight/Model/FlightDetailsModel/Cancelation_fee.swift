

import Foundation
struct Cancelation_fee : Codable {
	let cancellation_title : String?
	let origin : String?
	let destination : String?
	let text_left : String?
	let text_right : String?
	let text_bottom : String?

	enum CodingKeys: String, CodingKey {

		case cancellation_title = "cancellation_title"
		case origin = "origin"
		case destination = "destination"
		case text_left = "text_left"
		case text_right = "text_right"
		case text_bottom = "text_bottom"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cancellation_title = try values.decodeIfPresent(String.self, forKey: .cancellation_title)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		text_left = try values.decodeIfPresent(String.self, forKey: .text_left)
		text_right = try values.decodeIfPresent(String.self, forKey: .text_right)
		text_bottom = try values.decodeIfPresent(String.self, forKey: .text_bottom)
	}

}
