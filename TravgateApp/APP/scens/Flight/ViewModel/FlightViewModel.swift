//
//  FlightViewModel.swift
//  TravgateApp
//
//  Created by FCI on 05/01/24.
//

import Foundation



protocol FlightListModelProtocal : BaseViewModelProtocol {
    func flighPresearchResult(response:MobileFlightPreSearchModel)
    func flightList(response : FlightModel)
    func activebookingSourceResult(response: ActiveBookingSourceModel)

}

class FlightListViewModel {

    var view: FlightListModelProtocal!
    init(_ view: FlightListModelProtocal) {
        self.view = view
    }


    func CALL_GET_FLIGHTS_PRE_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

     //   self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_pre_flight_search , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: MobileFlightPreSearchModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flighPresearchResult(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    func CALL_GET_FLIGHTS_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_search_flight , parameters: parms, resultType: FlightModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_GET_ACTIVE_BOOKING_SOURCE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

      //  self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_get_active_booking_source , parameters: parms, resultType: ActiveBookingSourceModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.activebookingSourceResult(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
