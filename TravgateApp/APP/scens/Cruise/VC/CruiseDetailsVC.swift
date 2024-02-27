//
//  CruiseDetailsVC.swift
//  Travgate
//
//  Created by FCI on 27/02/24.
//

import UIKit

class CruiseDetailsVC: BaseTableVC, CruiseDetailsViewModelDelegate {
    
    
    
    
    static var newInstance: CruiseDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Cruise.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CruiseDetailsVC
        return vc
    }
    var fname = String()
    var emailid = String()
    var mobile = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.cruisedetailsvm = CruiseDetailsViewModel(self)
        MySingleton.shared.cruisedetailsvm = CruiseDetailsViewModel(self)
    }
    
    
    //MARK: -  editingTextField
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            emailid = tf.text ?? ""
            break
            
        case 3:
            mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    //MARK: -  didTapOnAddPeopleBtnAction
    override func didTapOnAddPeopleBtnAction(cell:CruiseContactdetailsTVCell){
        guard let vc = CruisePassengerSelectVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
    //MARK: -  donedatePicker  cancelDatePicker
    override func donedatePicker(cell:CruiseContactdetailsTVCell){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        defaults.set(formatter.string(from: cell.travelFromDatePicker.date), forKey: UserDefaultsKeys.fromtravelDate)
        
        defaults.set(formatter.string(from: cell.travelToDatePicker.date), forKey: UserDefaultsKeys.totravelDate)
        
        
        commonTableView.reloadData()
        self.view.endEditing(false)
    }
    
    
    override func cancelDatePicker(cell:CruiseContactdetailsTVCell){
        view.endEditing(true)
    }
    
    //MARK: -  didTapOnSubmitEnquiryBtnAction
    override func didTapOnSubmitEnquiryBtnAction(cell:CruiseContactdetailsTVCell){
        
        
        if MySingleton.shared.mrtitle.isEmpty == true {
            showToast(message: "Select Title For Your Name")
        }else if fname.isEmpty == true {
            showToast(message: "Enter First Name")
        }else if emailid.isEmpty == true {
            showToast(message: "Enter Email Address")
        }else if emailid.isValidEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if MySingleton.shared.cruiseCountryCode.isEmpty == true {
            showToast(message: "Select Country Code")
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if MySingleton.shared.travelfrom.isEmpty == true {
            showToast(message: "Enter travel Date")
        }else {
            callCruiseEnquireyAPI()
        }
        
        
    }
    
    //MARK: -  didTapOnRequestCallBackubmitEnquiryBtnAction
    override func didTapOnRequestCallBackBtnAction(cell:CruiseContactdetailsTVCell){
        
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}




extension CruiseDetailsVC {
    
    func setupUI(){
        
        
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left corner, Top right corner respectively
        commonTableView.layer.cornerRadius = 12
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["CruiseItineraryTVCell",
                                         "CruiseContactdetailsTVCell",
                                         "EmptyTVCell"])
        
        setupVisaTVCells()
        
    }
    
    
    
    
    
    func callAPI() {
        MySingleton.shared.payload.removeAll()
        BASE_URL = ""
        MySingleton.shared.cruisedetailsvm?.CALL_CRUISE_DETAILS_API(dictParam:  [:])
    }
    
    
    func cruiseDetails(response: CruiseDetailsModel) {
        BASE_URL = BASE_URL1
        MySingleton.shared.cruiseDetails = response
        
        DispatchQueue.main.async {
            self.setupVisaTVCells()
        }
    }
    
    
    
    func setupVisaTVCells() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.CruiseItineraryTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.CruiseContactdetailsTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
    
}



extension CruiseDetailsVC {
    
    func callCruiseEnquireyAPI() {
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["title"] = MySingleton.shared.mrtitle
        MySingleton.shared.payload["full_name"] = fname
        MySingleton.shared.payload["email"] = emailid
        MySingleton.shared.payload["country_id"] = MySingleton.shared.cruiseCountryCode
        MySingleton.shared.payload["contact_number"] = mobile
        MySingleton.shared.payload["adult_count"] = defaults.string(forKey: UserDefaultsKeys.cruisadultCount)
        MySingleton.shared.payload["child_count"] = defaults.string(forKey: UserDefaultsKeys.cruischildCount)
        MySingleton.shared.payload["infant_count"] = defaults.string(forKey: UserDefaultsKeys.cruisinfantsCount)
        MySingleton.shared.payload["travel_date"] = defaults.string(forKey: UserDefaultsKeys.fromtravelDate)
        
        MySingleton.shared.payload["created_for_cruise_id"] = "5"
        MySingleton.shared.payload["request_type"] = "1"
        
        MySingleton.shared.cruisedetailsvm?.CALL_CRUISE_ENQUIREY_API(dictParam: MySingleton.shared.payload)
    }
    
    
    func cruiseEnquireyDetails(response: LoginModel) {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.gotoCruiseEnquireySucessVC()
         }
        
    }
    
    
    func gotoCruiseEnquireySucessVC() {
        guard let vc = CruiseEnquireySucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
    
}

extension CruiseDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        callAPI()
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
