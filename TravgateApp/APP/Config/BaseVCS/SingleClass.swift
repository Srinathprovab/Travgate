//
//  SingleClass.swift
//  TravgateApp
//
//  Created by FCI on 04/01/24.
//

import Foundation
import UIKit


class MySingleton {
    // Declare static constant instance
    static let shared = MySingleton()
    
    // Declare your variables
    var myVariable1: Int
    var myVariable2: String
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    
    //Home Page
    var indexpagevm:IndexPageViewModel?
    var topFlightDetails = [TopFlightDetails]()
    var topHotelDetails = [TopHotelDetails]()
    var deail_code_list = [Deail_code_list]()
    var currencyListArray = [SelectCurrencyData]()
    
    
    //Flight Search
    var directFlightBool = false
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var acount = 0
    var ccount = 0
    var icount = 0
    var infoArray = [String]()
    var countrylist = [Country_list]()
    
    
    
    // Private initializer to prevent multiple instances
    private init() {
        myVariable1 = 0
        myVariable2 = "Default value"
    }
    
    
    func callonce() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrencyType)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    
    func getCountryList() {
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "countrylist", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [Country_list]].self, from: jsonData)
                
                // Access the array of countries using the "country_list" key
                if let countries = jsonDictionary["country_list"] {
                    self.countrylist = countries
                    
                } else {
                    print("Unable to find 'country_list' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
        
    }
}
