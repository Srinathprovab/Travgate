//
//  GetAirlineViewModel.swift
//  TravgateApp
//
//  Created by FCI on 13/02/24.
//

import Foundation

protocol GetAirlineViewModelDelegate : BaseViewModelProtocol {
    func airlinesList(response:GetAirlineModel)
}

class GetAirlineViewModel {
    
    var view: GetAirlineViewModelDelegate!
    init(_ view: GetAirlineViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  mobile_secure_booking API
    func CALL_FLIGHT_LODER_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_airlines_list,parameters: parms, resultType: GetAirlineModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.airlinesList(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
