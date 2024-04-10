//
//  FlightDetailsViewModel.swift
//  TravgateApp
//
//  Created by FCI on 06/01/24.
//

import Foundation

protocol FlightDetailsViewModelDelegate : BaseViewModelProtocol {
    func flightDetails(response : FlightDetailsModel)
    func farerulesList(response:FareRulesModel)

}

class FlightDetailsViewModel {

    var view: FlightDetailsViewModelDelegate!
    init(_ view: FlightDetailsViewModelDelegate) {
        self.view = view
    }


    func CALL_FLIGHT_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_getFlightDetails , parameters: parms, resultType: FlightDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  mobile_secure_booking API
    func CALL_GET_FARERULES_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.ajax_mobile_get_fare_rules,parameters: parms, resultType: FareRulesModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.farerulesList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
