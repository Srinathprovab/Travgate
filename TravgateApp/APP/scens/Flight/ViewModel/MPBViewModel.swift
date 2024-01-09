//
//  MPBViewModel.swift
//  TravgateApp
//
//  Created by FCI on 08/01/24.
//

import Foundation


protocol MPBViewModelDelegate : BaseViewModelProtocol {
    func MPBDetails(response : MobilePreProcessBookingModel)
    
//    func mobileprocesspassengerDetails(response:MBPModel)
//    func mobilePreBookingModelDetails(response:MobilePreBookingModel)
//    func mobileprepaymentconfirmationDetails(response:MobilePrePaymentModel)
//    func mobilesendtopaymentDetails(response:MobilePrePaymentModel)
//    func mobolePaymentDetails(response:MobilePaymentModel)
}

class MPBViewModel {
    
    var view: MPBViewModelDelegate!
    init(_ view: MPBViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: - CALL_MOBILE_PRE_PROCESS_BOOKING_API
    func CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flight_mobile_pre_process_booking , parameters: parms, resultType: MobilePreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.MPBDetails(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
//    //MARK:  mobile_process_passenger_detail
//    func CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam: [String: Any]){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.mobileprocesspassengerdetail)" , parameters: parms, resultType: MBPModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.mobileprocesspassengerDetails(response: response)
//                } else {
//                    // Show alert
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//
//
//    //MARK:  mobile_pre_booking
//    func Call_mobile_pre_booking_API(dictParam: [String: Any],url:String){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.mobilePreBookingModelDetails(response: response)
//                } else {
//                    // Show alert
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//
//
//
//    //MARK:  mobile_pre_payment_confirmation API
//    func Call_mobile_pre_payment_confirmation_API(dictParam: [String: Any],url:String){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePrePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.mobileprepaymentconfirmationDetails(response: response)
//                } else {
//                    // Show alert
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//
//
//
//    //MARK:  mobile_send_to_payment API
//    func Call_mobile_send_to_payment_API(dictParam: [String: Any],url:String){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePrePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.mobilesendtopaymentDetails(response: response)
//                } else {
//                    // Show alert
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//
//
//
//
//
//    //MARK:  CALL_MOBILE_PAYMENT_API
//    func CALL_MOBILE_PAYMENT_API(dictParam: [String: Any],url:String){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//
//        self.view?.showLoader()
//
//        ServiceManager.postOrPutApiCall(endPoint: url , parameters: parms, resultType: MobilePaymentModel.self, p:dictParam) { sucess, result, errorMessage in
//
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.mobolePaymentDetails(response: response)
//                } else {
//                    // Show alert
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
    
}
