//
//  ProfileViewModel.swift
//  TravgateApp
//
//  Created by FCI on 23/01/24.
//

import Foundation


protocol ProfileViewModelDelegate : BaseViewModelProtocol {
    func profileDetails(response : ProfileModel)
    func profileUpdateSucess(response : ProfileModel)

}

class ProfileViewModel {

    var view: ProfileViewModelDelegate!
    init(_ view: ProfileViewModelDelegate) {
        self.view = view
    }


    func CALL_SHOW_PROFILE_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.user_mobile_profile , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: ProfileModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.profileDetails(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_UPDATE_PROFILE_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.user_mobile_profile ,parameters: parms, resultType: ProfileModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.profileUpdateSucess(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    

}
