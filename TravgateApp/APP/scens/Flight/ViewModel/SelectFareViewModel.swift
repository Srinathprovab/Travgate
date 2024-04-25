//
//  SelectFareViewModel.swift
//  Travgate
//
//  Created by FCI on 24/04/24.
//

import Foundation
protocol SelectFareViewModelDelegate : BaseViewModelProtocol {
    func fareListResponse(response:SelectFareModel)
}

class SelectFareViewModel {
    
    var view: SelectFareViewModelDelegate!
    init(_ view: SelectFareViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  mobile_secure_booking API
    func CALL_GET_FARLIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_more_option_at_same_price,parameters: parms, resultType: SelectFareModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.fareListResponse(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
