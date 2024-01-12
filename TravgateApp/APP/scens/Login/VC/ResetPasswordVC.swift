//
//  ResetPasswordVC.swift
//  TravgateApp
//
//  Created by FCI on 10/01/24.
//

import UIKit

class ResetPasswordVC: BaseTableVC {
    
    
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }

    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["ResetPasswordTVCell"])
        setupTVCells()
    }
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
       
        default:
            break
        }
    }
    
    override func didTapOnSendEmailBtnAction(cell: ResetPasswordTVCell) {
        
        if email.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Vlaid Email Address")
        }else {
            guard let vc = CheckMailVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
    
    

    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
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
}
