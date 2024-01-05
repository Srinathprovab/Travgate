/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TopFlightDetails : Codable {
	let id : String?
	let from_city : String?
	let to_city : String?
	let travel_date : String?
	let return_date : String?
	let image : String?
	let status : String?
	let voucher_status : String?
	let voucher : String?
	let airline_id : String?
	let airline_class : String?
	let trip_type : String?
	let price : String?
	let agency_id : String?
	let user_type : String?
	let created_at : String?
	let updated_at : String?
	let from_airport_name : String?
	let to_airport_name : String?
	let from_city_name : String?
	let airport_code : String?
	let from_city_loc : String?
	let from_country : String?
	let to_city_name : String?
	let to_country : String?
	let to_city_loc : String?
	let airport_name : String?
	let fromFlight : String?
	let toFlight : String?
	let topFlightImg : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case from_city = "from_city"
		case to_city = "to_city"
		case travel_date = "travel_date"
		case return_date = "return_date"
		case image = "image"
		case status = "status"
		case voucher_status = "voucher_status"
		case voucher = "voucher"
		case airline_id = "airline_id"
		case airline_class = "airline_class"
		case trip_type = "trip_type"
		case price = "price"
		case agency_id = "agency_id"
		case user_type = "user_type"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case from_airport_name = "from_airport_name"
		case to_airport_name = "to_airport_name"
		case from_city_name = "from_city_name"
		case airport_code = "airport_code"
		case from_city_loc = "from_city_loc"
		case from_country = "from_country"
		case to_city_name = "to_city_name"
		case to_country = "to_country"
		case to_city_loc = "to_city_loc"
		case airport_name = "airport_name"
		case fromFlight = "fromFlight"
		case toFlight = "toFlight"
		case topFlightImg = "topFlightImg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
		to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
		travel_date = try values.decodeIfPresent(String.self, forKey: .travel_date)
		return_date = try values.decodeIfPresent(String.self, forKey: .return_date)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		voucher_status = try values.decodeIfPresent(String.self, forKey: .voucher_status)
		voucher = try values.decodeIfPresent(String.self, forKey: .voucher)
		airline_id = try values.decodeIfPresent(String.self, forKey: .airline_id)
		airline_class = try values.decodeIfPresent(String.self, forKey: .airline_class)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		agency_id = try values.decodeIfPresent(String.self, forKey: .agency_id)
		user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		from_airport_name = try values.decodeIfPresent(String.self, forKey: .from_airport_name)
		to_airport_name = try values.decodeIfPresent(String.self, forKey: .to_airport_name)
		from_city_name = try values.decodeIfPresent(String.self, forKey: .from_city_name)
		airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
		from_city_loc = try values.decodeIfPresent(String.self, forKey: .from_city_loc)
		from_country = try values.decodeIfPresent(String.self, forKey: .from_country)
		to_city_name = try values.decodeIfPresent(String.self, forKey: .to_city_name)
		to_country = try values.decodeIfPresent(String.self, forKey: .to_country)
		to_city_loc = try values.decodeIfPresent(String.self, forKey: .to_city_loc)
		airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
		fromFlight = try values.decodeIfPresent(String.self, forKey: .fromFlight)
		toFlight = try values.decodeIfPresent(String.self, forKey: .toFlight)
		topFlightImg = try values.decodeIfPresent(String.self, forKey: .topFlightImg)
	}

}