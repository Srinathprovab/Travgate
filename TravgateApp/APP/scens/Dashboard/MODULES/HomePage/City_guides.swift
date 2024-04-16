

import Foundation
struct City_guides : Codable {
	let origin : String?
	let city : String?
	let city_id_fal : String?
	let currency : String?
	let lang_spoken : String?
	let weather : String?
	let bst_mnth_visit : String?
	let major_market : String?
	let nat_dish : String?
	let subheading : String?
	let ar_subheading : String?
	let image : String?
	let banner_image : String?
	let places : [String]?
	let places_ar : [String]?
	let location_id : [String]?
	let status : String?
	let status_updated_at : String?
	let created_at : String?
	let created_by : String?
	let created_ip_address : String?
	let updated_at : String?
	let updated_by : String?
	let updated_ip_address : String?
	let deleted_at : String?
	let airport_city : String?
	let airport_city_ar : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case city = "city"
		case city_id_fal = "city_id_fal"
		case currency = "currency"
		case lang_spoken = "lang_spoken"
		case weather = "weather"
		case bst_mnth_visit = "bst_mnth_visit"
		case major_market = "major_market"
		case nat_dish = "nat_dish"
		case subheading = "subheading"
		case ar_subheading = "ar_subheading"
		case image = "image"
		case banner_image = "banner_image"
		case places = "places"
		case places_ar = "places_ar"
		case location_id = "location_id"
		case status = "status"
		case status_updated_at = "status_updated_at"
		case created_at = "created_at"
		case created_by = "created_by"
		case created_ip_address = "created_ip_address"
		case updated_at = "updated_at"
		case updated_by = "updated_by"
		case updated_ip_address = "updated_ip_address"
		case deleted_at = "deleted_at"
		case airport_city = "airport_city"
		case airport_city_ar = "airport_city_ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		city_id_fal = try values.decodeIfPresent(String.self, forKey: .city_id_fal)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		lang_spoken = try values.decodeIfPresent(String.self, forKey: .lang_spoken)
		weather = try values.decodeIfPresent(String.self, forKey: .weather)
		bst_mnth_visit = try values.decodeIfPresent(String.self, forKey: .bst_mnth_visit)
		major_market = try values.decodeIfPresent(String.self, forKey: .major_market)
		nat_dish = try values.decodeIfPresent(String.self, forKey: .nat_dish)
		subheading = try values.decodeIfPresent(String.self, forKey: .subheading)
		ar_subheading = try values.decodeIfPresent(String.self, forKey: .ar_subheading)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
		places = try values.decodeIfPresent([String].self, forKey: .places)
		places_ar = try values.decodeIfPresent([String].self, forKey: .places_ar)
		location_id = try values.decodeIfPresent([String].self, forKey: .location_id)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		status_updated_at = try values.decodeIfPresent(String.self, forKey: .status_updated_at)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
		created_ip_address = try values.decodeIfPresent(String.self, forKey: .created_ip_address)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
		updated_ip_address = try values.decodeIfPresent(String.self, forKey: .updated_ip_address)
		deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
		airport_city = try values.decodeIfPresent(String.self, forKey: .airport_city)
		airport_city_ar = try values.decodeIfPresent(String.self, forKey: .airport_city_ar)
	}

}
