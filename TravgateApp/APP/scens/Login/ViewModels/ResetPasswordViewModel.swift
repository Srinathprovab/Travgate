//
//  ResetPasswordViewModel.swift
//  TravgateApp
//
//  Created by FCI on 23/01/24.
//

import Foundation

protocol ResetPasswordViewModelDelegate : BaseViewModelProtocol {
    func resetpasswordSucess(response : LoginModel)

}

class ResetPasswordViewModel {

    var view: ResetPasswordViewModelDelegate!
    init(_ view: ResetPasswordViewModelDelegate) {
        self.view = view
    }


    func CALL_USER_RESET_PASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.auth_mobile_forgot_password , parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.resetpasswordSucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
