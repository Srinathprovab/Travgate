//
//  RegisterViewModel.swift
//  TravgateApp
//
//  Created by FCI on 23/01/24.
//

import Foundation

protocol RegisterViewModelDelegate : BaseViewModelProtocol {
    func registerSucess(response : RegisterModel)

}

class RegisterViewModel {

    var view: RegisterViewModelDelegate!
    init(_ view: RegisterViewModelDelegate) {
        self.view = view
    }


    func CALL_USER_REGISTER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.auth_mobile_register_on_light_box , parameters: parms, resultType: RegisterModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.registerSucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
