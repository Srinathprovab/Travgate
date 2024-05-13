//
//  GetInsuranceItemsVM.swift
//  Travgate
//
//  Created by FCI on 13/05/24.
//

import Foundation

protocol GetInsuranceItemsVMDelegate : BaseViewModelProtocol {
    func insurenceWhomItemlist(response : GetInsuranceItemsModel)
    func insurenceZoneItemlist(response : GetInsuranceItemsModel)
    func insurenceAgeItemlist(response : GetInsuranceItemsModel)
    func preInsurenceSearchResponse(response : GetInsuranceItemsModel)
}

class GetInsuranceItemsVM {

    
    var view: GetInsuranceItemsVMDelegate!
    init(_ view: GetInsuranceItemsVMDelegate) {
        self.view = view
    }


    func CALL_GET_INSURENCE_WHOM_ITEMS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_get_insurance_items , parameters: parms, resultType: GetInsuranceItemsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurenceWhomItemlist(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_GET_INSURENCE_ZONE_ITEMS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_get_insurance_items , parameters: parms, resultType: GetInsuranceItemsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurenceZoneItemlist(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_INSURENCE_AGE_ITEMS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_get_insurance_items , parameters: parms, resultType: GetInsuranceItemsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurenceAgeItemlist(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_GET_INSURENCE_MOBILE_PRE_INSURENCE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_insurance_search,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: GetInsuranceItemsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preInsurenceSearchResponse(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    

}
