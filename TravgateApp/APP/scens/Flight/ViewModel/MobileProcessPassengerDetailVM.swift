//
//  MobileProcessPassengerDetailVM.swift
//  Travgate
//
//  Created by FCI on 29/04/24.
//

import Foundation

protocol MobileProcessPassengerDetailVMDelegate : BaseViewModelProtocol {
    func mobileprocesspassengerDetails(response:MobilePassengerdetailsModel)
}

class MobileProcessPassengerDetailVM {
    
    var view: MobileProcessPassengerDetailVMDelegate!
    init(_ view: MobileProcessPassengerDetailVMDelegate) {
        self.view = view
    }
    
    
    
    //MARK:  mobile_process_passenger_detail
    func CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.mobileprocesspassengerdetail)" , parameters: parms, resultType: MobilePassengerdetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mobileprocesspassengerDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
