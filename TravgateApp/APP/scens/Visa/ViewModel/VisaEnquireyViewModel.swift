//
//  VisaEnquireyViewModel.swift
//  Travgate
//
//  Created by FCI on 23/02/24.
//

import Foundation

protocol VisaEnquireyViewModelDelegate : BaseViewModelProtocol {
    func visaEnquireySucess(response : LoginModel)

}

class VisaEnquireyViewModel {

    var view: VisaEnquireyViewModelDelegate!
    init(_ view: VisaEnquireyViewModelDelegate) {
        self.view = view
    }


    func CALL_VISA_ENQUIREY_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.visa_enquiry_form , parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.visaEnquireySucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
