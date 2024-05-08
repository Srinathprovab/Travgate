//
//  HotelBookingData.swift
//  Travgate
//
//  Created by FCI on 20/03/24.
//

import Foundation

struct HotelBookingData : Codable {
    let payment_method : String?
    let payment_booking_source : String?
    let booking_source : String?
    let search_data : HSearch_data?
    let hotel_details : Hotel_details?
    let hotel_total_price : Double?
    let tax_service_sum : Int?
    let convenience_fees : Int?
    let discount : Int?
    let converted_currency_rate : Int?
    let room_paxes_details : [Room_paxes_details]?
    let token : String?
    let pre_booking_cancellation_policy : String?
    let currency_obj : Currency_obj?
    let traveller_details : String?
    let unformatted_total_price : Double?
    let total_price : String?
    //  let reward_usable : Int?
    //let reward_earned : Int?
    //    let total_price_with_rewards : Int?
    let user_specification : [User_specification]?
    let addon_services : [HotelAddonModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case payment_method = "payment_method"
        case payment_booking_source = "payment_booking_source"
        case booking_source = "booking_source"
        case search_data = "search_data"
        case hotel_details = "hotel_details"
        case hotel_total_price = "hotel_total_price"
        case tax_service_sum = "tax_service_sum"
        case convenience_fees = "convenience_fees"
        case discount = "discount"
        case converted_currency_rate = "converted_currency_rate"
        case room_paxes_details = "room_paxes_details"
        case token = "token"
        case pre_booking_cancellation_policy = "pre_booking_cancellation_policy"
        case currency_obj = "currency_obj"
        case traveller_details = "traveller_details"
        case unformatted_total_price = "unformatted_total_price"
        case total_price = "total_price"
        //  case reward_usable = "reward_usable"
        // case reward_earned = "reward_earned"
        //        case total_price_with_rewards = "total_price_with_rewards"
        case user_specification = "user_specification"
        case addon_services = "addon_services"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        payment_booking_source = try values.decodeIfPresent(String.self, forKey: .payment_booking_source)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_data = try values.decodeIfPresent(HSearch_data.self, forKey: .search_data)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        hotel_total_price = try values.decodeIfPresent(Double.self, forKey: .hotel_total_price)
        tax_service_sum = try values.decodeIfPresent(Int.self, forKey: .tax_service_sum)
        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        room_paxes_details = try values.decodeIfPresent([Room_paxes_details].self, forKey: .room_paxes_details)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        pre_booking_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .pre_booking_cancellation_policy)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        traveller_details = try values.decodeIfPresent(String.self, forKey: .traveller_details)
        unformatted_total_price = try values.decodeIfPresent(Double.self, forKey: .unformatted_total_price)
        total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
        //  reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
        // reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        //        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        user_specification = try values.decodeIfPresent([User_specification].self, forKey: .user_specification)
        addon_services = try values.decodeIfPresent([HotelAddonModel].self, forKey: .addon_services)
    }
    
}
