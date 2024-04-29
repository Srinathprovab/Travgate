//
//  MPBViewModel.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import Foundation

protocol MPBViewModelDelegate : BaseViewModelProtocol {
    func MPBDetails(response : MobilePreProcessBookingModel)
}

class MPBViewModel {
    
    var view: MPBViewModelDelegate!
    init(_ view: MPBViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: - CALL_MOBILE_PRE_PROCESS_BOOKING_API
    func CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_mobile_pre_process_booking , parameters: parms, resultType: MobilePreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.MPBDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
  
}
