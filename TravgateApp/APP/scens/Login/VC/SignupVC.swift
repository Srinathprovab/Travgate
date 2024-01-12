//
//  SignupVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class SignupVC: BaseTableVC {
    
    
    static var newInstance: SignupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SignupVC
        return vc
    }
    
    
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
    }
    
    
    func setupUI() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.backgroundColor = .WhiteColor
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
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if password.isEmpty == true {
            showToast(message: "Enter Password")
        }else if confpassword.isEmpty == true {
            showToast(message: "Enter Confirm Password")
        }else  if password !=  confpassword {
            showToast(message: "Password Should Match With Confirm Password")
        }else {
            showToast(message: "Calll APIIII")
        }
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
}
