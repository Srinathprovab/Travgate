//
//  EditProfileVC.swift
//  TravgateApp
//
//  Created by FCI on 12/01/24.
//

import UIKit

class EditProfileVC: BaseTableVC {
    
    
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
    }
    
    
    func setupUI() {
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
    func updateProfile(){
        if first_name.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if last_name.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if date_of_birth.isEmpty == true {
            showToast(message: "Enter Date Of Birth")
        }else {
            showToast(message: "Calll APIIII")
        }
    }
}
