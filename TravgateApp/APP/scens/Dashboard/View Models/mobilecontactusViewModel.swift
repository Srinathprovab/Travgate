//
//  mobilecontactusViewModel.swift
//  Travgate
//
//  Created by FCI on 13/03/24.
//

import Foundation
protocol mobilecontactusViewModelDelegate : BaseViewModelProtocol {
    func contactUsSucess(response : LoginModel)
}

class mobilecontactusViewModel {
    
    var view: mobilecontactusViewModelDelegate!
    init(_ view: mobilecontactusViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_CONTACT_US_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_contact_us,parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.contactUsSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
