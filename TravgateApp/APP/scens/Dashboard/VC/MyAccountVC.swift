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
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var loginlbl: UILabel!
    
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    func setupUI() {
        setAttributedString(str1: "Login To View Your Profile")
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["EditProfileTVCell",
                                         "EmptyTVCell"])
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    
    @IBAction func didTapOnEditProfileBtnAction(_ sender: Any) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}



//MARK: - setAttributedString

extension MyAccountVC {
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.OpenSansRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        loginlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        loginlbl.addGestureRecognizer(tapGesture)
        loginlbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        
        if gesture.didTapAttributedString("Login To View Your Profile", in: loginlbl) {
            didTapOnLoginBtnAction()
        }
        
    }
    
    
    
    func didTapOnLoginBtnAction() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}


//MARK: - imagePickerController openGallery openCemera

extension MyAccountVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = tempImage
        }
        
        //self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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



//MARK: - callShowProfileAPI  profileDetails  checkLoginStatus
extension MyAccountVC {
    
    func checkLoginStatus() {
        let userloginsataus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if userloginsataus == true {
            callShowProfileAPI()
            
            profileView.isHidden = false
            changePicturelbl.isHidden = true
            editbtn.isHidden = false
            loginlbl.isHidden = true
            commonTableView.isHidden = false
        }else {
            
            profileView.isHidden = true
            changePicturelbl.isHidden = true
            editbtn.isHidden = true
            loginlbl.isHidden = false
            commonTableView.isHidden = true
        }
    }
    
    
    func callShowProfileAPI() {
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.profilevm?.CALL_SHOW_PROFILE_DETAILS_API(dictParam:  MySingleton.shared.payload)
    }
    
    
    func profileDetails(response: ProfileModel) {
        MySingleton.shared.profiledata = response.data
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
}



extension MyAccountVC {
    
    func addObserver() {
        checkLoginStatus()
        
        NotificationCenter.default.addObserver(self, selector: #selector(logindone), name: Notification.Name("logindone"), object: nil)
        
    }
    
    
    @objc func logindone() {
        
        
        DispatchQueue.main.async {
            self.checkLoginStatus()
        }
    }
}
