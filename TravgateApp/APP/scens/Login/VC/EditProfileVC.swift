//
//  EditProfileVC.swift
//  TravgateApp
//
//  Created by FCI on 12/01/24.
//

import UIKit
import MobileCoreServices
import Alamofire


class EditProfileVC: BaseTableVC, ProfileViewModelDelegate {
    
    
    
    
    @IBOutlet weak var profileView: BorderedView!
    @IBOutlet weak var changePicturelbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    
    
    
    var first_name = String()
    var last_name = String()
    var address2 = String()
    var date_of_birth = String()
    var address = String()
    var phone = String()
    var email = String()
    var gender = String()
    var country_name = String()
    var state_name = String()
    var city_name = String()
    var pin_code = String()
    var country_code = String()
    
    var pickerbool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        MySingleton.shared.profilevm = ProfileViewModel(self)
    }
    
    
    func setupUI() {
        profiledetails()
        setAttributedString(str1: "Change Picture")
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["EditProfileTVCell","EmptyTVCell"])
        setupTVCells()
    }
    
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            first_name = tf.text ?? ""
            break
            
        case 2:
            last_name = tf.text ?? ""
            break
            
            
        case 3:
            date_of_birth = tf.text ?? ""
            break
            
            
        case 4:
            address = tf.text ?? ""
            break
            
            
        case 5:
            country_name = tf.text ?? ""
            break
            
            
            
        case 6:
            state_name = tf.text ?? ""
            break
            
            
        case 7:
            city_name = tf.text ?? ""
            break
            
            
            
        case 8:
            pin_code = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func donedatePicker(cell:EditProfileTVCell) {
        date_of_birth = cell.dobTF.text ?? ""
        view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:EditProfileTVCell) {
        view.endEditing(true)
    }
    
    
    override func didTapOnMailBtnAction(cell:EditProfileTVCell) {
        gender = cell.gender
    }
    
    override func didTapOnFeMailBtnAction(cell:EditProfileTVCell) {
        gender = cell.gender
    }
    
    
    override func didTapOnUpdateProfileBtnAction(cell: EditProfileTVCell) {
        updateProfile()
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

//MARK: - setupTVCells
extension EditProfileVC {
    func setupTVCells() {
        MySingleton.shared.tablerow.removeAll()
        MySingleton.shared.tablerow.append(TableRow(key:" edit",
                                                    cellType:.EditProfileTVCell))
        
        MySingleton.shared.tablerow.append(TableRow(height:50,
                                                    cellType:.EmptyTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}



extension EditProfileVC {
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.OpenSansRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        changePicturelbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        changePicturelbl.addGestureRecognizer(tapGesture)
        changePicturelbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        
        if gesture.didTapAttributedString("Change Picture", in: changePicturelbl) {
            didTapOnChangepictureBtnAction()
        }
        
    }
    
    
    
    func didTapOnChangepictureBtnAction() {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EditProfileVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = tempImage
        }
        
        self.pickerbool = true
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
extension EditProfileVC {
    
    func profiledetails() {
        first_name = MySingleton.shared.profiledata?.first_name ?? ""
        last_name = MySingleton.shared.profiledata?.last_name ?? ""
        date_of_birth = MySingleton.shared.profiledata?.date_of_birth ?? ""
        address = MySingleton.shared.profiledata?.address ?? ""
        country_name = MySingleton.shared.profiledata?.country_name ?? ""
        state_name = MySingleton.shared.profiledata?.state_name ?? ""
        city_name = MySingleton.shared.profiledata?.city_name ?? ""
        pin_code = MySingleton.shared.profiledata?.pin_code ?? ""
        phone = MySingleton.shared.profiledata?.phone ?? ""
        email = MySingleton.shared.profiledata?.email ?? ""
        gender = MySingleton.shared.profiledata?.gender ?? ""
        
        if gender == "" {
            gender = "Male"
        }
        
    }
    
    
    func updateProfile(){
        if first_name.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if last_name.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if date_of_birth.isEmpty == true {
            showToast(message: "Enter Date Of Birth")
        }else {
            
            MySingleton.shared.payload.removeAll()
            MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            MySingleton.shared.payload["first_name"] = first_name
            MySingleton.shared.payload["last_name"] = last_name
            MySingleton.shared.payload["phone"] = phone
            MySingleton.shared.payload["email"] = email
            MySingleton.shared.payload["address"] = address
            MySingleton.shared.payload["address2"] = ""
            MySingleton.shared.payload["country_name"] = country_name
            MySingleton.shared.payload["state_name"] = state_name
            MySingleton.shared.payload["city_name"] = city_name
            MySingleton.shared.payload["pin_code"] = pin_code
            MySingleton.shared.payload["date_of_birth"] =  MySingleton.shared.convertDateFormat(inputDate: date_of_birth, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
            MySingleton.shared.payload["gender"] = gender
            
            
            
           // MySingleton.shared.profilevm?.CALL_UPDATE_PROFILE_DETAILS_API(dictParam: MySingleton.shared.payload)
            callUpdateProfileAPI()
        }
    }
    
    
    func profileDetails(response: ProfileModel) {
        
    }
    
    func profileUpdateSucess(response: ProfileModel) {
        
        MySingleton.shared.profiledata = response.data
        showToast(message: response.msg ?? "")
        NotificationCenter.default.post(name: NSNotification.Name("logindone"), object: nil)
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.dismiss(animated: true)
        }
    }
    
    
    func callUpdateProfileAPI() {
        
        MySingleton.shared.profilevm?.view.showLoader()
        
        // Set up headers
            let headers1: HTTPHeaders = [
                "Token": accessToken
            ]
        
        AF.upload(multipartFormData: { [self] MultipartFormData in
            
            for (key, value) in  MySingleton.shared.payload {
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            if let img = profilePic.image {
                if let imageData = img.jpegData(compressionQuality: 0.4) {
                    MultipartFormData.append(imageData, withName: "image", fileName: "\(Date()).jpeg", mimeType: "image/jpeg")
                }
            }
            
        }, to: "https://provab.net/travgate/pro_new/mobile/index.php/user/mobile_profile",headers: headers1).responseDecodable(of: ProfileModel.self) { [self] resp in
            
            switch resp.result {
            case let .success(data):
                
                MySingleton.shared.profilevm?.view.hideLoader()
                
                showToast(message: "Updated Sucess")
                NotificationCenter.default.post(name: NSNotification.Name("logindone"), object: nil)
                
                let seconds = 2.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.dismiss(animated: true)
                }
                
                break
                
            case .failure(let encodingError):
                MySingleton.shared.profilevm?.view.hideLoader()
                print("ERROR RESPONSE: \(encodingError)")
                break
                
            }
            
        }
        
    }
    
    
    
    
}

