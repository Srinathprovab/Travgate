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
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.gotodashBoardScreen()
        })
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
}



class MySingleton {
    // Declare static constant instance
    static let shared = MySingleton()

    // Declare your variables
    var myVariable1: Int
    var myVariable2: String
    var tablerow = [TableRow]()
    var payload = [String:Any]()

    // Private initializer to prevent multiple instances
    private init() {
        myVariable1 = 0
        myVariable2 = "Default value"
    }
}
