//
//  MoreDetailsViewModel.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import Foundation
protocol MoreDetailsViewModelDelegate : BaseViewModelProtocol {
    func moreDetails(response : MoreDetailsModel)
}

class MoreDetailsViewModel {
    
    var view: MoreDetailsViewModelDelegate!
    init(_ view: MoreDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_MORE_DETAILS_API(dictParam: [String: Any],urlStr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlStr, urlParams: parms as? Dictionary<String, String>,parameters: parms, resultType: MoreDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.moreDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
