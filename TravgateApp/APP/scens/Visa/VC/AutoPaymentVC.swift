//
//  AutoPaymentVC.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

class AutoPaymentVC: BaseTableVC {
    
    
    
    static var newInstance: AutoPaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AutoPaymentVC
        return vc
    }
    
    
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var countrycode = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    
    override func editingTextField(tf:UITextField){
        
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
        
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            countrycode = tf.text ?? ""
            break
            
        case 5:
            mobile = tf.text ?? ""
            break
        
            
            
            
        default:
            break
        }
    }
    
   
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnPaynowBtnAction(cell: AutoPaymentTVCell) {
        
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
            errorTextField(v: cell.fnameTF)
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
            errorTextField(v: cell.lnameTF)
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
            errorTextField(v: cell.mobileTF)
        }else if email.isEmpty == true {
            showToast(message: "Enter Email Address")
            errorTextField(v: cell.emailTF)
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
            errorTextField(v: cell.emailTF)
        }else {
            callAPI()
        }
    }
    
    
    func errorTextField(v:UITextField) {
        v.layer.borderColor = UIColor.BooknowBtnColor.cgColor
    }
    
}


extension AutoPaymentVC {
    
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["AutoPaymentTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.AutoPaymentTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension AutoPaymentVC {
    
    
    func callAPI() {
        print("callAPI")
    }
    
}

extension AutoPaymentVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
