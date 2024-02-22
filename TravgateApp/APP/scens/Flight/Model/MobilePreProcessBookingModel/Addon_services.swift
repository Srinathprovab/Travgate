

import Foundation
struct Addon_services : Codable {
	let origin : String?
	let title : String?
	let display_title : String?
	let details : String?
	let original_price : String?
	let price : String?
	let stype : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case title = "title"
		case display_title = "display_title"
		case details = "details"
		case original_price = "original_price"
		case price = "price"
		case stype = "stype"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		display_title = try values.decodeIfPresent(String.self, forKey: .display_title)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		original_price = try values.decodeIfPresent(String.self, forKey: .original_price)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		stype = try values.decodeIfPresent(String.self, forKey: .stype)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}
