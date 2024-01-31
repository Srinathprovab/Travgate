//
//  LogoutViewModel.swift
//  TravgateApp
//
//  Created by FCI on 26/01/24.
//

import Foundation
protocol LogoutViewModelDelegate : BaseViewModelProtocol {
    func logoutSucess(response : LoginModel)
    func userDeleteSucess(response : LoginModel)

}

class LogoutViewModel {

    var view: LogoutViewModelDelegate!
    init(_ view: LogoutViewModelDelegate) {
        self.view = view
    }


    func CALL_USER_LOGOUT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: "\(ApiEndpoints.auth_mobile_logout)/\(defaults.string(forKey: UserDefaultsKeys.userid) ?? "0" )", parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.logoutSucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL__DELETE_USER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.auth_deleteuser, parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.userDeleteSucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
