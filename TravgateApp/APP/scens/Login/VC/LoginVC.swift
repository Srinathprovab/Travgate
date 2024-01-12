//
//  LoginVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class LoginVC: BaseTableVC {
    
    
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    var email = String()
    var password = String()
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["LoginTVCell"])
        setupTVCells()
    }
    
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            password = tf.text ?? ""
            break
        default:
            break
        }
        
        
    }
    
    
    //MARK: - LoginTVCell Delegate Methods
    override func didTapOnCloseBtnAction(cell: LoginTVCell) {
        dismiss(animated: true)
    }
    
    override func didTapOnSignUpBtnAction(cell: LoginTVCell) {
        guard let vc = SignupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOnLoginBtnAction(cell: LoginTVCell) {
        if email.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if password.isEmpty == true {
            showToast(message: "Enter Password")
        }else {
            showToast(message: "Call APiiiiii")
        }
    }
    
    override func didTapOnForgetPasswordBtnAction(cell: LoginTVCell) {
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}


//MARK: - setupTVCells
extension LoginVC {
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(cellType:.LoginTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
