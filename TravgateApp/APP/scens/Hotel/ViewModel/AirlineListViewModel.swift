//
//  AirlineListViewModel.swift
//  TravgateApp
//
//  Created by FCI on 21/01/24.
//

import Foundation
protocol AirlineListViewModelDelegate : BaseViewModelProtocol {
    func airlinelist(response : AirlineListModel)
    
}

class AirlineListViewModel {
    
    var view: AirlineListViewModelDelegate!
    init(_ view: AirlineListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_AIRLINE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getAirlineList , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: AirlineListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.airlinelist(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
