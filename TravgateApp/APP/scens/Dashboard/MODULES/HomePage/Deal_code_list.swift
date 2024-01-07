
import Foundation

struct Deal_code_list : Codable {
	let price_type : String?
	let end_travel : String?
	let hotel_country : String?
	let max_value : String?
	let to_location : String?
	let end_sell : String?
	let limitation : String?
	let use_type : String?
	let cabin_class : String?
	let sales_chanel : String?
	let start_date : String?
	let airline_number : String?
	let start_sell : String?
	let room_type : String?
	let pcc : String?
	let hotel_minimum : String?
	let status : String?
	let description : String?
	let from_location : String?
	let topDealImg : String?
	let rbd : String?
	let stops : String?
	let hotel_maximum : String?
	let hotel_nama : String?
	let to_loc : String?
	let value : String?
	let luggage : String?
	let value_type : String?
	let hotel_supplier : String?
	let display_status : String?
	let min_value : String?
	let promo_code : String?
	let origin : String?
	let hotel_point_sale : String?
	let start_travel : String?
	let hotel_unit : String?
	let ar_description : String?
	let hotel_city : String?
	let trip_type : String?
	let expiry_date : String?
	let from_loc : String?
	let code_share : String?
	let created_datetime : String?
	let module : String?
	let api : String?
	let airline : String?
	let unit : String?
	let hotel_distance : String?
	let star_rating : String?
	let pos : String?
	let search : String?
	let created_by_id : String?
	let image_path : String?

	enum CodingKeys: String, CodingKey {

		case price_type = "price_type"
		case end_travel = "end_travel"
		case hotel_country = "hotel_country"
		case max_value = "max_value"
		case to_location = "to_location"
		case end_sell = "end_sell"
		case limitation = "limitation"
		case use_type = "use_type"
		case cabin_class = "cabin_class"
		case sales_chanel = "sales_chanel"
		case start_date = "start_date"
		case airline_number = "airline_number"
		case start_sell = "start_sell"
		case room_type = "room_type"
		case pcc = "pcc"
		case hotel_minimum = "hotel_minimum"
		case status = "status"
		case description = "description"
		case from_location = "from_location"
		case topDealImg = "topDealImg"
		case rbd = "rbd"
		case stops = "stops"
		case hotel_maximum = "hotel_maximum"
		case hotel_nama = "hotel_nama"
		case to_loc = "to_loc"
		case value = "value"
		case luggage = "luggage"
		case value_type = "value_type"
		case hotel_supplier = "hotel_supplier"
		case display_status = "display_status"
		case min_value = "min_value"
		case promo_code = "promo_code"
		case origin = "origin"
		case hotel_point_sale = "hotel_point_sale"
		case start_travel = "start_travel"
		case hotel_unit = "hotel_unit"
		case ar_description = "ar_description"
		case hotel_city = "hotel_city"
		case trip_type = "trip_type"
		case expiry_date = "expiry_date"
		case from_loc = "from_loc"
		case code_share = "code_share"
		case created_datetime = "created_datetime"
		case module = "module"
		case api = "api"
		case airline = "airline"
		case unit = "unit"
		case hotel_distance = "hotel_distance"
		case star_rating = "star_rating"
		case pos = "pos"
		case search = "search"
		case created_by_id = "created_by_id"
		case image_path = "image_path"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
		end_travel = try values.decodeIfPresent(String.self, forKey: .end_travel)
		hotel_country = try values.decodeIfPresent(String.self, forKey: .hotel_country)
		max_value = try values.decodeIfPresent(String.self, forKey: .max_value)
		to_location = try values.decodeIfPresent(String.self, forKey: .to_location)
		end_sell = try values.decodeIfPresent(String.self, forKey: .end_sell)
		limitation = try values.decodeIfPresent(String.self, forKey: .limitation)
		use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		sales_chanel = try values.decodeIfPresent(String.self, forKey: .sales_chanel)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		airline_number = try values.decodeIfPresent(String.self, forKey: .airline_number)
		start_sell = try values.decodeIfPresent(String.self, forKey: .start_sell)
		room_type = try values.decodeIfPresent(String.self, forKey: .room_type)
		pcc = try values.decodeIfPresent(String.self, forKey: .pcc)
		hotel_minimum = try values.decodeIfPresent(String.self, forKey: .hotel_minimum)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		from_location = try values.decodeIfPresent(String.self, forKey: .from_location)
		topDealImg = try values.decodeIfPresent(String.self, forKey: .topDealImg)
		rbd = try values.decodeIfPresent(String.self, forKey: .rbd)
		stops = try values.decodeIfPresent(String.self, forKey: .stops)
		hotel_maximum = try values.decodeIfPresent(String.self, forKey: .hotel_maximum)
		hotel_nama = try values.decodeIfPresent(String.self, forKey: .hotel_nama)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		luggage = try values.decodeIfPresent(String.self, forKey: .luggage)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		hotel_supplier = try values.decodeIfPresent(String.self, forKey: .hotel_supplier)
		display_status = try values.decodeIfPresent(String.self, forKey: .display_status)
		min_value = try values.decodeIfPresent(String.self, forKey: .min_value)
		promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		hotel_point_sale = try values.decodeIfPresent(String.self, forKey: .hotel_point_sale)
		start_travel = try values.decodeIfPresent(String.self, forKey: .start_travel)
		hotel_unit = try values.decodeIfPresent(String.self, forKey: .hotel_unit)
		ar_description = try values.decodeIfPresent(String.self, forKey: .ar_description)
		hotel_city = try values.decodeIfPresent(String.self, forKey: .hotel_city)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		code_share = try values.decodeIfPresent(String.self, forKey: .code_share)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		api = try values.decodeIfPresent(String.self, forKey: .api)
		airline = try values.decodeIfPresent(String.self, forKey: .airline)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		hotel_distance = try values.decodeIfPresent(String.self, forKey: .hotel_distance)
		star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
		pos = try values.decodeIfPresent(String.self, forKey: .pos)
		search = try values.decodeIfPresent(String.self, forKey: .search)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
	}

}
