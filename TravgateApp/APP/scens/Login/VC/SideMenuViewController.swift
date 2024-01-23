//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC, ProfileViewModelDelegate {
   
    
    
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        MySingleton.shared.profilevm = ProfileViewModel(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(logindone), name: Notification.Name("logindone"), object: nil)
        
         let userloggedBool = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) 
            if userloggedBool == true {
                callShowProfileAPI()
            }
        
    }
    
    
    @objc func logindone() {
        callShowProfileAPI()
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
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
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
            callLogoutAPI()
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
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
  
}



extension SideMenuViewController {
    
    
    func callShowProfileAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.profilevm?.CALL_SHOW_PROFILE_DETAILS_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func profileDetails(response: ProfileModel) {
        MySingleton.shared.profiledata = response.data
        
        DispatchQueue.main.async {
            self.setupMenuTVCells()
        }
    }
    
    func profileUpdateSucess(response: ProfileModel) {
        
    }
    
    
    func callLogoutAPI() {
        
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        defaults.set("0", forKey: UserDefaultsKeys.userid)
      
        DispatchQueue.main.async {
            self.setupMenuTVCells()
        }
    }
}
