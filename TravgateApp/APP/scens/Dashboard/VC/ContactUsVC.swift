//
//  ContactUsVC.swift
//  Travgate
//
//  Created by FCI on 07/03/24.
//

import UIKit

class ContactUsVC: BaseTableVC, mobilecontactusViewModelDelegate {
    
    
    
    static var newInstance: ContactUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactUsVC
        return vc
    }
    
    
    
    var name = String()
    var email = String()
    var mobile = String()
    var countrycode = String()
    var comments = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        MySingleton.shared.contactusvm = mobilecontactusViewModel(self)
    }
    
    
    
    func setupUI() {
        
        commonTableView.registerTVCells(["ContactUsTVCell"])
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.ContactUsTVCell))
        
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    //MARK: - ContactUsTVCell Delegate Methods
    
    override func textViewDidChange(textView: UITextView) {
        self.comments = textView.text ?? ""
    }
    
    override func didTapOnCountryCodeBtnAction(cell: ContactUsTVCell) {
        self.countrycode = cell.countryCodeTF.text ?? ""
    }
    
    override func editingTextField(tf:UITextField){
        
        switch tf.tag {
            
        case 1:
            name = tf.text ?? ""
            break
            
        case 2:
            email = tf.text ?? ""
            break
            
        case 12:
            mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {
        
        guard !name.isEmpty else { showToast(message: "Enter Name"); return }
        guard !email.isEmpty else { showToast(message: "Enter Email Address"); return }
        guard email.isValidEmail() else { showToast(message: "Enter Valid Email Address"); return }
        guard !countrycode.isEmpty else { showToast(message: "Enter Country Code"); return }
        guard !mobile.isEmpty else { showToast(message: "Enter Mobile"); return }

        CallContactUsAPI()

    }
    
}



extension ContactUsVC {
    
    func CallContactUsAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["country_code"] = self.countrycode
        MySingleton.shared.payload["email"] = self.email
        MySingleton.shared.payload["full_name"] = self.name
        MySingleton.shared.payload["message"] = self.comments
        MySingleton.shared.payload["phone_number"] = self.mobile
        MySingleton.shared.contactusvm?.CALL_CONTACT_US_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func contactUsSucess(response: LoginModel) {
       
        showToast(message: response.msg ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss(animated: true)
        }
        
    }
    
    
}
