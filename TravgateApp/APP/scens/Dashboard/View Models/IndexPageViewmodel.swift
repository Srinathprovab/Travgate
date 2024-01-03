//
//  IndexPageViewmodel.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import Foundation



protocol IndexPageViewModelDelegate : BaseViewModelProtocol {
    func indexPageDetails(response : IndexPagemodel)
}

class IndexPageViewModel {
    
    var view: IndexPageViewModelDelegate!
    init(_ view: IndexPageViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_INDEX_PAGE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.indexpage, parameters: parms, resultType: IndexPagemodel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.indexPageDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
