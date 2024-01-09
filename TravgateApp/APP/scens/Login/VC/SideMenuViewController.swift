//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC {
    
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       
    }
    
    
    func setupUI() {
        setupMenuTVCells()
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "QuickLinkTableViewCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell"])
    }
    
    func setupMenuTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType: .MenuBGTVCell))
        MySingleton.shared.tablerow.append(TableRow(height: 20,cellType: .EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Services",key: "links", image: "", height: 250, cellType: .QuickLinkTableViewCell))
        MySingleton.shared.tablerow.append(TableRow(height: 10, bgColor: HexColor("#FFFFFF") , cellType: .EmptyTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Services",key: "bookings", image: "",height: 170, cellType: .QuickLinkTableViewCell))
        MySingleton.shared.tablerow.append(TableRow(height: 80, cellType: .EmptyTVCell))
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            MySingleton.shared.tablerow.append(TableRow(title:"Logout",key: "logout", image: "IonLogOut",cellType:.SideMenuTitleTVCell))
        }
        
        
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
//    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
//        guard let vc = LoginViewController.newInstance.self else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.isVcFrom = "SideMenuVC"
//        present(vc, animated: true)
//
//    }
    
    override func didTaponCell(cell: SideMenuTitleTVCell) {
        switch cell.menuTitlelbl.text {
        case "Flight":
            showFlightSearchVC()
            break
        case "Hotel":
            print("Hotel")
            break
        case "Visa":
            print("Visa")
            break
        case "Auto Payment":
            print("Auto Payment")
            break
        case "My Bookings":
            print("My Bookings")
            break
        case "Free Cancelation":
            print("Free Cancelation")
            break
        case "Customer Support":
            print("Customer Support")
            break
        case "Logout":
            print("logout here")
            //callLogoutAPI()
            break
        default:
            break
        }
    }
    
    func showFlightSearchVC() {
        guard let vc = FlightSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
   

    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        
    }
    
  
}

