//
//  PaymentModel.swift
//  Travgate
//
//  Created by FCI on 03/04/24.
//

import Foundation

struct PaymentModel : Codable {
    let amount : String?
    let checkout_url : String?
    let currency_code : String?
    let customer_first_name : String?
    let customer_last_name : String?
    let customer_phone : String?
    let due_datetime : String?
    let expiration_time : String?
    let language : String?
    let operation : String?
    let order_no : String?
    let payment_methods : [Payment_methods]?
    let payment_type : String?
    let pg_codes : [String]?
    let session_id : String?
    let state : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case amount = "amount"
        case checkout_url = "checkout_url"
        case currency_code = "currency_code"
        case customer_first_name = "customer_first_name"
        case customer_last_name = "customer_last_name"
        case customer_phone = "customer_phone"
        case due_datetime = "due_datetime"
        case expiration_time = "expiration_time"
        case language = "language"
        case operation = "operation"
        case order_no = "order_no"
        case payment_methods = "payment_methods"
        case payment_type = "payment_type"
        case pg_codes = "pg_codes"
        case session_id = "session_id"
        case state = "state"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        checkout_url = try values.decodeIfPresent(String.self, forKey: .checkout_url)
        currency_code = try values.decodeIfPresent(String.self, forKey: .currency_code)
        customer_first_name = try values.decodeIfPresent(String.self, forKey: .customer_first_name)
        customer_last_name = try values.decodeIfPresent(String.self, forKey: .customer_last_name)
        customer_phone = try values.decodeIfPresent(String.self, forKey: .customer_phone)
        due_datetime = try values.decodeIfPresent(String.self, forKey: .due_datetime)
        expiration_time = try values.decodeIfPresent(String.self, forKey: .expiration_time)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        operation = try values.decodeIfPresent(String.self, forKey: .operation)
        order_no = try values.decodeIfPresent(String.self, forKey: .order_no)
        payment_methods = try values.decodeIfPresent([Payment_methods].self, forKey: .payment_methods)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        pg_codes = try values.decodeIfPresent([String].self, forKey: .pg_codes)
        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
