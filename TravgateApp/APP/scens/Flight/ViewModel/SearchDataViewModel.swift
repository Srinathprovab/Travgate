//
//  SearchDataViewModel.swift
//  TravgateApp
//
//  Created by FCI on 08/02/24.
//

import Foundation

protocol SearchDataViewModelDelegate : BaseViewModelProtocol {
    func flightRecentSearchDate(response : SearchDataModel)
    func removeflightRecentSearchDate(response : LoginModel)
}

class SearchDataViewModel {
    
    var view: SearchDataViewModelDelegate!
    init(_ view: SearchDataViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_SEARCH_RECENT_DATA_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_searchdata , parameters: parms, resultType: SearchDataModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightRecentSearchDate(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_REMOVE_FLIGHT_SEARCH_RECENT_DATA_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_removeRecentSearch , parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.removeflightRecentSearchDate(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
