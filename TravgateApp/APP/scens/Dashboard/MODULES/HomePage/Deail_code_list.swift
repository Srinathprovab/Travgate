

import Foundation
struct Deail_code_list : Codable {
	let origin : String?
	let module : String?
	let promo_code : String?
	let description : String?
	let ar_description : String?
	let value : String?
	let value_type : String?
	let use_type : String?
	let limitation : String?
	let start_date : String?
	let expiry_date : String?
	let trip_type : String?
	let cabin_class : String?
	let from_location : String?
	let to_location : String?
	let from_loc : String?
	let to_loc : String?
	let airline : String?
	let airline_number : String?
	let unit : String?
	let price_type : String?
	let pos : String?
	let search : String?
	let luggage : String?
	let stops : String?
	let api : String?
	let code_share : String?
	let pcc : String?
	let sales_chanel : String?
	let rbd : String?
	let start_sell : String?
	let end_sell : String?
	let start_travel : String?
	let end_travel : String?
	let min_value : String?
	let max_value : String?
	let hotel_country : String?
	let hotel_city : String?
	let hotel_supplier : String?
	let hotel_unit : String?
	let room_type : String?
	let hotel_point_sale : String?
	let hotel_nama : String?
	let star_rating : String?
	let hotel_minimum : String?
	let hotel_maximum : String?
	let hotel_distance : String?
	let status : String?
	let display_status : String?
	let url_status : String?
	let created_by_id : String?
	let created_datetime : String?
	let image_path : String?
	let image_path_ar : String?
	let url : String?
	let banner_image : String?
	let pdesc : String?
	let ar_pdesc : String?
	let mpdesc : String?
	let ar_mpdesc : String?
	let tnc : String?
	let tnc_ar : String?
	let topDealImg : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case module = "module"
		case promo_code = "promo_code"
		case description = "description"
		case ar_description = "ar_description"
		case value = "value"
		case value_type = "value_type"
		case use_type = "use_type"
		case limitation = "limitation"
		case start_date = "start_date"
		case expiry_date = "expiry_date"
		case trip_type = "trip_type"
		case cabin_class = "cabin_class"
		case from_location = "from_location"
		case to_location = "to_location"
		case from_loc = "from_loc"
		case to_loc = "to_loc"
		case airline = "airline"
		case airline_number = "airline_number"
		case unit = "unit"
		case price_type = "price_type"
		case pos = "pos"
		case search = "search"
		case luggage = "luggage"
		case stops = "stops"
		case api = "api"
		case code_share = "code_share"
		case pcc = "pcc"
		case sales_chanel = "sales_chanel"
		case rbd = "rbd"
		case start_sell = "start_sell"
		case end_sell = "end_sell"
		case start_travel = "start_travel"
		case end_travel = "end_travel"
		case min_value = "min_value"
		case max_value = "max_value"
		case hotel_country = "hotel_country"
		case hotel_city = "hotel_city"
		case hotel_supplier = "hotel_supplier"
		case hotel_unit = "hotel_unit"
		case room_type = "room_type"
		case hotel_point_sale = "hotel_point_sale"
		case hotel_nama = "hotel_nama"
		case star_rating = "star_rating"
		case hotel_minimum = "hotel_minimum"
		case hotel_maximum = "hotel_maximum"
		case hotel_distance = "hotel_distance"
		case status = "status"
		case display_status = "display_status"
		case url_status = "url_status"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case image_path = "image_path"
		case image_path_ar = "image_path_ar"
		case url = "url"
		case banner_image = "banner_image"
		case pdesc = "pdesc"
		case ar_pdesc = "ar_pdesc"
		case mpdesc = "mpdesc"
		case ar_mpdesc = "ar_mpdesc"
		case tnc = "tnc"
		case tnc_ar = "tnc_ar"
		case topDealImg = "topDealImg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		ar_description = try values.decodeIfPresent(String.self, forKey: .ar_description)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
		limitation = try values.decodeIfPresent(String.self, forKey: .limitation)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
		from_location = try values.decodeIfPresent(String.self, forKey: .from_location)
		to_location = try values.decodeIfPresent(String.self, forKey: .to_location)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		airline = try values.decodeIfPresent(String.self, forKey: .airline)
		airline_number = try values.decodeIfPresent(String.self, forKey: .airline_number)
		unit = try values.decodeIfPresent(String.self, forKey: .unit)
		price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
		pos = try values.decodeIfPresent(String.self, forKey: .pos)
		search = try values.decodeIfPresent(String.self, forKey: .search)
		luggage = try values.decodeIfPresent(String.self, forKey: .luggage)
		stops = try values.decodeIfPresent(String.self, forKey: .stops)
		api = try values.decodeIfPresent(String.self, forKey: .api)
		code_share = try values.decodeIfPresent(String.self, forKey: .code_share)
		pcc = try values.decodeIfPresent(String.self, forKey: .pcc)
		sales_chanel = try values.decodeIfPresent(String.self, forKey: .sales_chanel)
		rbd = try values.decodeIfPresent(String.self, forKey: .rbd)
		start_sell = try values.decodeIfPresent(String.self, forKey: .start_sell)
		end_sell = try values.decodeIfPresent(String.self, forKey: .end_sell)
		start_travel = try values.decodeIfPresent(String.self, forKey: .start_travel)
		end_travel = try values.decodeIfPresent(String.self, forKey: .end_travel)
		min_value = try values.decodeIfPresent(String.self, forKey: .min_value)
		max_value = try values.decodeIfPresent(String.self, forKey: .max_value)
		hotel_country = try values.decodeIfPresent(String.self, forKey: .hotel_country)
		hotel_city = try values.decodeIfPresent(String.self, forKey: .hotel_city)
		hotel_supplier = try values.decodeIfPresent(String.self, forKey: .hotel_supplier)
		hotel_unit = try values.decodeIfPresent(String.self, forKey: .hotel_unit)
		room_type = try values.decodeIfPresent(String.self, forKey: .room_type)
		hotel_point_sale = try values.decodeIfPresent(String.self, forKey: .hotel_point_sale)
		hotel_nama = try values.decodeIfPresent(String.self, forKey: .hotel_nama)
		star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
		hotel_minimum = try values.decodeIfPresent(String.self, forKey: .hotel_minimum)
		hotel_maximum = try values.decodeIfPresent(String.self, forKey: .hotel_maximum)
		hotel_distance = try values.decodeIfPresent(String.self, forKey: .hotel_distance)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		display_status = try values.decodeIfPresent(String.self, forKey: .display_status)
		url_status = try values.decodeIfPresent(String.self, forKey: .url_status)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
		image_path_ar = try values.decodeIfPresent(String.self, forKey: .image_path_ar)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
		pdesc = try values.decodeIfPresent(String.self, forKey: .pdesc)
		ar_pdesc = try values.decodeIfPresent(String.self, forKey: .ar_pdesc)
		mpdesc = try values.decodeIfPresent(String.self, forKey: .mpdesc)
		ar_mpdesc = try values.decodeIfPresent(String.self, forKey: .ar_mpdesc)
		tnc = try values.decodeIfPresent(String.self, forKey: .tnc)
		tnc_ar = try values.decodeIfPresent(String.self, forKey: .tnc_ar)
		topDealImg = try values.decodeIfPresent(String.self, forKey: .topDealImg)
	}

}
