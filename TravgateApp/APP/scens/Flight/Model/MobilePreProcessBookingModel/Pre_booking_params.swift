

import Foundation
struct Pre_booking_params : Codable {
	let form_params : MPBFormParams?
	let token : String?
	let token_key : String?
	let booking_source : String?
	let access_key : String?
	let search_access_key : String?
	let traceId : String?
	let search_id : String?
	let user_id : String?
	let transaction_id : String?
	let priceDetails : PriceDetails?

	enum CodingKeys: String, CodingKey {

		case form_params = "form_params"
		case token = "token"
		case token_key = "token_key"
		case booking_source = "booking_source"
		case access_key = "access_key"
		case search_access_key = "search_access_key"
		case traceId = "traceId"
		case search_id = "search_id"
		case user_id = "user_id"
		case transaction_id = "transaction_id"
		case priceDetails = "priceDetails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		form_params = try values.decodeIfPresent(MPBFormParams.self, forKey: .form_params)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
		search_access_key = try values.decodeIfPresent(String.self, forKey: .search_access_key)
		traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
		priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
	}

}
