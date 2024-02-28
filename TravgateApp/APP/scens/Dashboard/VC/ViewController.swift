//
//  ViewController.swift
//  TravgateApp
//
//  Created by FCI on 02/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            
            defaults.set("1", forKey: UserDefaultsKeys.visaadultCount)
            defaults.set("0", forKey: UserDefaultsKeys.visachildCount)
            defaults.set("0", forKey: UserDefaultsKeys.visainfantsCount)
            
            defaults.set("1 Passenger", forKey: UserDefaultsKeys.visatotalpassengercount)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    
        
        
        MySingleton.shared.callonce()
        MySingleton.shared.getCountryList()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
           // self.gotodashBoardScreen()
            self.gotoBookingConfirmedVC()
        })
    }
    
    
    func gotodashBoardScreen() {
        MySingleton.shared.callboolapi = true
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func gotoBookingConfirmedVC() {
       
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        urlString = "https://provab.net/travgate/pro_new/mobile/index.php/voucher/flight/BAS-F-TP-0228-1709127138/3617"
        callapibool = true
        present(vc, animated: true)
    }
    
}


