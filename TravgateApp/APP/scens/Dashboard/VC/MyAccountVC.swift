//
//  MyAccountVC.swift
//  TravgateApp
//
//  Created by FCI on 12/01/24.
//

import UIKit

class MyAccountVC: BaseTableVC {
    
    
    @IBOutlet weak var profileView: BorderedView!
    @IBOutlet weak var changePicturelbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["EditProfileTVCell","EmptyTVCell"])
        setupTVCells()
    }
    
    
    
    @IBAction func didTapOnEditProfileBtnAction(_ sender: Any) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}

//MARK: - setupTVCells
extension MyAccountVC {
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:"noedit",
                                                    cellType:.EditProfileTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:100,
                                                    cellType:.EmptyTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}







