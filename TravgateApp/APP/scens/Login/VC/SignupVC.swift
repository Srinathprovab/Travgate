//
//  SignupVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class SignupVC: BaseTableVC, RegisterViewModelDelegate {
    
    
    static var newInstance: SignupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SignupVC
        return vc
    }
    
    var countrycode = String()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var confpassword = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.registervm = RegisterViewModel(self)
    }
    
    
    func setupUI() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
       
        commonTableView.registerTVCells(["SignupTVCell"])
        setupTVCells()
    }
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
            
        case 12:
            mobile = tf.text ?? ""
            break
            
            
        case 11:
            email = tf.text ?? ""
            break
            
            
        case 3:
            password = tf.text ?? ""
            break
            
            
            
        case 4:
            confpassword = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnRegisterCloseBtnAction(cell:SignupTVCell) {
        dismiss(animated: true)
    }
    
    override func didTapOnSignupBtnAction(cell:SignupTVCell){
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
            errorTextField(v: cell.fnameview)
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
            errorTextField(v: cell.lnameview)
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            errorTextField(v: cell.mobileview)
        }else if email.isEmpty == true {
            showToast(message: "Enter Email Address")
            errorTextField(v: cell.emailview)
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            errorTextField(v: cell.emailview)
        }else if password.isEmpty == true {
            showToast(message: "Enter Password")
            errorTextField(v: cell.passview)
        }else if confpassword.isEmpty == true {
            showToast(message: "Enter Confirm Password")
            errorTextField(v: cell.confPassview)
        }else  if password !=  confpassword {
            showToast(message: "Password Should Match With Confirm Password")
            errorTextField(v: cell.confPassview)
        }else {
            callAPI()
        }
    }
    
    
    func errorTextField(v:UIView) {
        v.layer.borderColor = UIColor.BooknowBtnColor.cgColor
    }
    
    
    override func didTapOnCountryCodeBtn(cell:SignupTVCell) {
        countrycode = cell.countrycodeTF.text ?? ""
    }
    
    
}


//MARK: - setupTVCells
extension SignupVC {
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(cellType:.SignupTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func callAPI() {
        basicloderBool = true
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["first_name"] = fname
        MySingleton.shared.payload["last_name"] = lname
        MySingleton.shared.payload["phone"] = mobile
        MySingleton.shared.payload["email"] = email
        MySingleton.shared.payload["password"] = password
        MySingleton.shared.registervm?.CALL_USER_REGISTER_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func registerSucess(response: RegisterModel) {
        basicloderBool = false
        showToast(message: response.msg ?? "")
        
        if response.status == true {
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
               dismiss(animated: true)
            }
        }
            
    }
    
    
}
