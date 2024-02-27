//
//  CruiseDetailsViewModel.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import Foundation

protocol CruiseDetailsViewModelDelegate : BaseViewModelProtocol {
    func cruiseDetails(response : CruiseDetailsModel)
    func cruiseEnquireyDetails(response : LoginModel)

}

class CruiseDetailsViewModel {

    var view: CruiseDetailsViewModelDelegate!
    init(_ view: CruiseDetailsViewModelDelegate) {
        self.view = view
    }


    func CALL_CRUISE_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(BASE_URL1)\(ApiEndpoints.cruise_get_more_info)\(MySingleton.shared.cruiseKeyStr)" , parameters: parms, resultType: CruiseDetailsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cruiseDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_CRUISE_ENQUIREY_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.cruise_cruise_enquiry_form, parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cruiseEnquireyDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

}
