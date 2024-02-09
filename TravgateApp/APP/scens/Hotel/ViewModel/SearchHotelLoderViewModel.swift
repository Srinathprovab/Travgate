//
//  SearchHotelLoderViewModel.swift
//  TravgateApp
//
//  Created by FCI on 09/02/24.
//

import Foundation
import Foundation
protocol SearchHotelLoderViewModelDelegate : BaseViewModelProtocol {
    func searchLoderData(response:SearchHotelLoderModel)
}

class SearchHotelLoderViewModel {
    
    var view: SearchHotelLoderViewModelDelegate!
    init(_ view: SearchHotelLoderViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  mobile_secure_booking API
    func CALL_HOTEL_LODER_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_hotel_search_loader , urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: SearchHotelLoderModel.self, p:dictParam) { sucess, result, errorMessage in
            
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
