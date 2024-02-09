//
//  SearchLoaderViewModel.swift
//  TravgateApp
//
//  Created by FCI on 09/02/24.
//

import Foundation
protocol SearchLoaderViewModelDelegate : BaseViewModelProtocol {
    func searchLoderData(response:SearchLoaderModel)
}

class SearchLoaderViewModel {
    
    var view: SearchLoaderViewModelDelegate!
    init(_ view: SearchLoaderViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  mobile_secure_booking API
    func CALL_FLIGHT_LODER_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_flight_search_loader , urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: SearchLoaderModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.searchLoderData(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

    
}
