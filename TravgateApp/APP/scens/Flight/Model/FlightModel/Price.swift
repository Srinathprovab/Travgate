

import Foundation
struct Price : Codable {
	
	let api_currency : String?
	let api_total_display_fare : Double?
	let api_total_display_fare_withoutmarkup : Double?
	

	enum CodingKeys: String, CodingKey {

		case api_currency = "api_currency"
		case api_total_display_fare = "api_total_display_fare"
		case api_total_display_fare_withoutmarkup = "api_total_display_fare_withoutmarkup"
		
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
		api_total_display_fare = try values.decodeIfPresent(Double.self, forKey: .api_total_display_fare)
		api_total_display_fare_withoutmarkup = try values.decodeIfPresent(Double.self, forKey: .api_total_display_fare_withoutmarkup)
		
	}

}
