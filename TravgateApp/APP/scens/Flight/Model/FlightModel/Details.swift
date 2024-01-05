

import Foundation
struct Details : Codable {
	let origin : Origin?
	let destination : Destination?
	let operator_code : String?
	let operator_image : String?
	let display_operator_code : String?
	let operator_name : String?
	let cabin_class : String?
	let fclass : FlightClass?
	let flight_number : String?
	let layover_duration : String?
	let duration_seconds : Int?
	let duration : String?
	let meal : String?
	let meal_description : String?
	let seatsRemaining : String?
	let weight_Allowance : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case destination = "destination"
		case operator_code = "operator_code"
		case operator_image = "operator_image"
		case display_operator_code = "display_operator_code"
		case operator_name = "operator_name"
		case cabin_class = "cabin_class"
		case fclass = "class"
		case flight_number = "flight_number"
		case layover_duration = "layover_duration"
		case duration_seconds = "duration_seconds"
		case duration = "duration"
		case meal = "Meal"
		case meal_description = "Meal_description"
		case seatsRemaining = "SeatsRemaining"
		case weight_Allowance = "Weight_Allowance"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
		destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
		operator_code = try values.decodeIfPresent(String.self, forKey: .operator_code)
		operator_image = try values.decodeIfPresent(String.self, forKey: .operator_image)
		display_operator_code = try values.decodeIfPresent(String.self, forKey: .display_operator_code)
		operator_name = try values.decodeIfPresent(String.self, forKey: .operator_name)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		fclass = try values.decodeIfPresent(FlightClass.self, forKey: .fclass)
		flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
		layover_duration = try values.decodeIfPresent(String.self, forKey: .layover_duration)
		duration_seconds = try values.decodeIfPresent(Int.self, forKey: .duration_seconds)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		meal = try values.decodeIfPresent(String.self, forKey: .meal)
		meal_description = try values.decodeIfPresent(String.self, forKey: .meal_description)
		seatsRemaining = try values.decodeIfPresent(String.self, forKey: .seatsRemaining)
		weight_Allowance = try values.decodeIfPresent(String.self, forKey: .weight_Allowance)
	}

}
