//
//  CurrencyListViewModel.swift
//  Travgate
//
//  Created by FCI on 08/03/24.
//

import Foundation
protocol CurrencyListViewModelDelegate : BaseViewModelProtocol {
    func currencylist(response : CurrencyListModel)
}

class CurrencyListViewModel {
    
    var view: CurrencyListViewModelDelegate!
    init(_ view: CurrencyListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_CURRENCY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_getMobileCurrency,parameters: parms, resultType: CurrencyListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.currencylist(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
