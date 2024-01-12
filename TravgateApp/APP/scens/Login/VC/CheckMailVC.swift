//
//  CheckMailVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class CheckMailVC: UIViewController {
    
    
    static var newInstance: CheckMailVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CheckMailVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.gotoDashBoardTBVC()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    func gotoDashBoardTBVC() {
        guard let vc = DashBoardTBVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
}
