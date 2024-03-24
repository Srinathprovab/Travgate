//
//  HotelBookingViewModel.swift
//  Travgate
//
//  Created by FCI on 20/03/24.
//

import Foundation
protocol HotelBookingViewModelDelegate : BaseViewModelProtocol {
    func hotelBookingDetails(response : HotelBookingModel)
    func hotelpreBookingDetails(response : HotelMBPModel)
}

class HotelBookingVM {
    
    var view: HotelBookingViewModelDelegate!
    init(_ view: HotelBookingViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_HOTEL_MOBILE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hotel_mobile_booking,parameters: parms as NSDictionary, resultType: HotelBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelBookingDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_HOTEL_PRE_MOBILE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hotel_mobile_hotel_pre_booking,parameters: parms as NSDictionary, resultType: HotelMBPModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelpreBookingDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
