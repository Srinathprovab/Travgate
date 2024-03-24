//
//  HotelBookingData.swift
//  Travgate
//
//  Created by FCI on 20/03/24.
//

import Foundation

struct HotelBookingData : Codable {
    let booking_source : String?
    let total_price_with_rewards : Int?
    let room_paxes_details : [Room_paxes_details]?
    let user_specification : [String]?
    let traveller_details : String?
    let discount : Int?
    let hotel_total_price : Double?
    let converted_currency_rate : Int?
    let payment_method : String?
    let token : String?
    let payment_booking_source : String?
    let search_data : HSearch_data?
    let convenience_fees : Int?
    let pre_booking_cancellation_policy : String?
    let total_price : String?
    let reward_earned : Int?
    let tax_service_sum : Int?
    let hotel_details : Hotel_details?
    let currency_obj : Currency_obj?
    // let unformatted_total_price : Double?
   // let reward_usable : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_source = "booking_source"
        case total_price_with_rewards = "total_price_with_rewards"
        case room_paxes_details = "room_paxes_details"
        case user_specification = "user_specification"
        case traveller_details = "traveller_details"
        case discount = "discount"
        case hotel_total_price = "hotel_total_price"
        case converted_currency_rate = "converted_currency_rate"
        case payment_method = "payment_method"
        case token = "token"
        case payment_booking_source = "payment_booking_source"
        case search_data = "search_data"
        case convenience_fees = "convenience_fees"
        case pre_booking_cancellation_policy = "pre_booking_cancellation_policy"
        case total_price = "total_price"
        case reward_earned = "reward_earned"
        case tax_service_sum = "tax_service_sum"
        case hotel_details = "hotel_details"
        case currency_obj = "currency_obj"
        //   case unformatted_total_price = "unformatted_total_price"
     //   case reward_usable = "reward_usable"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        room_paxes_details = try values.decodeIfPresent([Room_paxes_details].self, forKey: .room_paxes_details)
        user_specification = try values.decodeIfPresent([String].self, forKey: .user_specification)
        traveller_details = try values.decodeIfPresent(String.self, forKey: .traveller_details)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        hotel_total_price = try values.decodeIfPresent(Double.self, forKey: .hotel_total_price)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        payment_booking_source = try values.decodeIfPresent(String.self, forKey: .payment_booking_source)
        search_data = try values.decodeIfPresent(HSearch_data.self, forKey: .search_data)
        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        pre_booking_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .pre_booking_cancellation_policy)
        total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        tax_service_sum = try values.decodeIfPresent(Int.self, forKey: .tax_service_sum)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        //     unformatted_total_price = try values.decodeIfPresent(Double.self, forKey: .unformatted_total_price)
        //reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
    }
    
}
