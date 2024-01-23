//
//  LoginVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class LoginVC: BaseTableVC, LoginViewModelDelegate {
    
    
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
        
        MySingleton.shared.loginvm = LoginViewModel(self)
        
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
            cell.emailview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            cell.emailview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else if password.isEmpty == true {
            showToast(message: "Enter Password")
            cell.passwordview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else {
            callAPI()
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
    
    
    func callAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["username"] = email
        MySingleton.shared.payload["password"] = password
        MySingleton.shared.loginvm?.CALL_USER_LOGIN_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func loginSucess(response: LoginModel) {
       
        showToast(message: response.data ?? "")
    
        if response.status == true {
            
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
            NotificationCenter.default.post(name: NSNotification.Name("logindone"), object: nil)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
               dismiss(animated: true)
            }
        }

    }
    
    
    
}
