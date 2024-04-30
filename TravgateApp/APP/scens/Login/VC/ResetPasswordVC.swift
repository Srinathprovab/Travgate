//
//  ResetPasswordVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class ResetPasswordVC: BaseTableVC, ResetPasswordViewModelDelegate {
  
    
    
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }

    var email = String()
    var mobile = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.resetpasswordvm = ResetPasswordViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["ResetPasswordTVCell"])
        setupTVCells()
    }
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
            
        case 12:
            mobile = tf.text ?? ""
            break
            
       
        default:
            break
        }
    }
    
    override func didTapOnSendEmailBtnAction(cell: ResetPasswordTVCell) {
        
        if email.isEmpty == true {
            showToast(message: "Enter Email Address")
            cell.emailview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Vlaid Email Address")
            cell.emailview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            cell.mobileview.layer.borderColor = UIColor.BooknowBtnColor.cgColor
        }else {
            callAPI()
        }
        
    }
    
    
    override func didTapOnRestPasswordBackBtnAction(cell:ResetPasswordTVCell){
        dismiss(animated: true)
    }

    
}


//MARK: - setupTVCells
extension ResetPasswordVC {
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(cellType:.ResetPasswordTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    func callAPI() {
        basicloderBool = true
        MySingleton.shared.payload.removeAll()
        
        MySingleton.shared.payload["email"] = email
        MySingleton.shared.payload["phone"] = mobile
        MySingleton.shared.resetpasswordvm?.CALL_USER_RESET_PASSWORD_API(dictParam:  MySingleton.shared.payload)
        
    }
    
    
    func resetpasswordSucess(response: LoginModel) {
        basicloderBool = false
        showToast(message: response.data ?? "")
        if response.status == true {
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                gotoCheckMailVC()
            }
        }
    }
    
    
    func gotoCheckMailVC() {
        guard let vc = CheckMailVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
