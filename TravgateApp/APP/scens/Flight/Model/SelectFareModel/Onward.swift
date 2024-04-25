

import Foundation
struct Onward : Codable {
    let totalPrice : String?
    let basePrice : String?
    let taxes : String?
    let totalPrice_API : String?
    let aPICurrencyType : String?
    let sITECurrencyType : String?
    let myMarkup : String?
    let myMarkup_cal : String?
    let aMarkup : String?
    let aMarkup_cal : String?
    let basePrice_Breakdown : Int?
    let taxPrice_Breakdown : Int?
    let admin_markup_amount : Int?
    let agent_markup_amount : Int?
    let refundable : Bool?
    let platingCarrier : String?
    let fareType : String?
    let all_Passenger : String?
    let adults : Int?
    let adults_Base_Price : String?
    let adults_Tax_Price : String?
    let productClass : String?
    let fareKey : String?
    let journeyKey : String?
    let price : Price?
    //  let fare : Fare?
    let checkedBaggage : String?
    let carryOnBaggage : String?
    let cancellation : String?
    let tab_title : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case totalPrice = "TotalPrice"
        case basePrice = "BasePrice"
        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
        case sITECurrencyType = "SITECurrencyType"
        case myMarkup = "MyMarkup"
        case myMarkup_cal = "myMarkup_cal"
        case aMarkup = "aMarkup"
        case aMarkup_cal = "aMarkup_cal"
        case basePrice_Breakdown = "BasePrice_Breakdown"
        case taxPrice_Breakdown = "TaxPrice_Breakdown"
        case admin_markup_amount = "admin_markup_amount"
        case agent_markup_amount = "agent_markup_amount"
        case refundable = "Refundable"
        case platingCarrier = "PlatingCarrier"
        case fareType = "FareType"
        case all_Passenger = "All_Passenger"
        case adults = "Adults"
        case adults_Base_Price = "Adults_Base_Price"
        case adults_Tax_Price = "Adults_Tax_Price"
        case productClass = "productClass"
        case fareKey = "fareKey"
        case journeyKey = "journeyKey"
        case price = "price"
        //     case fare = "fare"
        case checkedBaggage = "CheckedBaggage"
        case carryOnBaggage = "CarryOnBaggage"
        case cancellation = "Cancellation"
        case tab_title = "Tab_title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        myMarkup = try values.decodeIfPresent(String.self, forKey: .myMarkup)
        myMarkup_cal = try values.decodeIfPresent(String.self, forKey: .myMarkup_cal)
        aMarkup = try values.decodeIfPresent(String.self, forKey: .aMarkup)
        aMarkup_cal = try values.decodeIfPresent(String.self, forKey: .aMarkup_cal)
        basePrice_Breakdown = try values.decodeIfPresent(Int.self, forKey: .basePrice_Breakdown)
        taxPrice_Breakdown = try values.decodeIfPresent(Int.self, forKey: .taxPrice_Breakdown)
        admin_markup_amount = try values.decodeIfPresent(Int.self, forKey: .admin_markup_amount)
        agent_markup_amount = try values.decodeIfPresent(Int.self, forKey: .agent_markup_amount)
        refundable = try values.decodeIfPresent(Bool.self, forKey: .refundable)
        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        adults_Base_Price = try values.decodeIfPresent(String.self, forKey: .adults_Base_Price)
        adults_Tax_Price = try values.decodeIfPresent(String.self, forKey: .adults_Tax_Price)
        productClass = try values.decodeIfPresent(String.self, forKey: .productClass)
        fareKey = try values.decodeIfPresent(String.self, forKey: .fareKey)
        journeyKey = try values.decodeIfPresent(String.self, forKey: .journeyKey)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        //     fare = try values.decodeIfPresent(Fare.self, forKey: .fare)
        checkedBaggage = try values.decodeIfPresent(String.self, forKey: .checkedBaggage)
        carryOnBaggage = try values.decodeIfPresent(String.self, forKey: .carryOnBaggage)
        cancellation = try values.decodeIfPresent(String.self, forKey: .cancellation)
        tab_title = try values.decodeIfPresent(String.self, forKey: .tab_title)
    }
    
}
