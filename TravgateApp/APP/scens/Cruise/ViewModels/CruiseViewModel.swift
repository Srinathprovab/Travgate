//
//  CruiseViewModel.swift
//  Travgate
//
//  Created by FCI on 26/02/24.
//

import Foundation

protocol CruiseViewModelDelegate : BaseViewModelProtocol {
    func cruiseList(response : CruiseModel)

}

class CruiseViewModel {

    var view: CruiseViewModelDelegate!
    init(_ view: CruiseViewModelDelegate) {
        self.view = view
    }


    func CALL_CRUISE_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.cruise_get_cruise_list , parameters: parms, resultType: CruiseModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cruiseList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
