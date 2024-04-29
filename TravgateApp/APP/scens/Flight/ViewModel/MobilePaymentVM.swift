//
//  MobilePaymentVM.swift
//  Travgate
//
//  Created by FCI on 29/04/24.
//

import Foundation
protocol MobilePaymentVMDelegate : BaseViewModelProtocol {
    func mobolePaymentDetails(response:PaymentModel)
}

class MobilePaymentVM {
    
    var view: MobilePaymentVMDelegate!
    init(_ view: MobilePaymentVMDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_MOBILE_PAYMENT_API
    func CALL_MOBILE_PAYMENT_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: PaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mobolePaymentDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
