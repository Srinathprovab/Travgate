

import Foundation
struct Custom_farerules : Codable {
	let cancelation_fee : Cancelation_fee?
	let date_charge_fee : Date_charge_fee?
	let please_note : String?

	enum CodingKeys: String, CodingKey {

		case cancelation_fee = "cancelation_fee"
		case date_charge_fee = "date_charge_fee"
		case please_note = "please_note"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cancelation_fee = try values.decodeIfPresent(Cancelation_fee.self, forKey: .cancelation_fee)
		date_charge_fee = try values.decodeIfPresent(Date_charge_fee.self, forKey: .date_charge_fee)
		please_note = try values.decodeIfPresent(String.self, forKey: .please_note)
	}

}
