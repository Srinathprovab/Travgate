//
//  EditProfileTVCell.swift
//  TravgateApp
//
//  Created by FCI on 12/01/24.
//

import UIKit


protocol EditProfileTVCellDelegate {
    func didTapOnUpdateProfileBtnAction(cell:EditProfileTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnMailBtnAction(cell:EditProfileTVCell)
    func didTapOnFeMailBtnAction(cell:EditProfileTVCell)
    func donedatePicker(cell:EditProfileTVCell)
    func cancelDatePicker(cell:EditProfileTVCell)
}

class EditProfileTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var maleImg: UIImageView!
    @IBOutlet weak var femaleimg: UIImageView!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var UpdateBtn: UIButton!
    
    let datePicker = UIDatePicker()
    var gender = String()
    var delegate:EditProfileTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        profileDateils()
        mobileView.isUserInteractionEnabled = false
        emailView.isUserInteractionEnabled = false
       
        if cellInfo?.key == "noedit" {
            holderView.alpha = 0.7
            holderView.isUserInteractionEnabled = false
            UpdateBtn.isHidden = true
            
        }else {
            holderView.alpha = 1
            holderView.isUserInteractionEnabled = true
            UpdateBtn.isHidden = false
            mobileView.alpha = 0.5
            emailView.alpha = 0.5
        }
        
        
        if MySingleton.shared.profiledata?.gender == "Female" {
            femaleSelected()
        }else {
            maleSelected()
        }
        
    }
    
    
    
    func setupUI() {
        showDatePicker()
        UpdateBtn.layer.cornerRadius = 6
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: dobTF)
        setupTF(tf: addressTF)
        setupTF(tf: stateTF)
        setupTF(tf: cityTF)
        setupTF(tf: countryTF)
        setupTF(tf: pincodeTF)
        
        maleImg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        femaleimg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        
    }
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnMailBtnAction(_ sender: Any) {
        maleSelected()
    }
    
    func maleSelected() {
        gender = "Male"
        maleImg.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        femaleimg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        delegate?.didTapOnMailBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnFeMailBtnAction(_ sender: Any) {
        femaleSelected()
    }
    
    
    func femaleSelected() {
        gender = "Female"
        femaleimg.image = UIImage(named: "radioSelected1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        maleImg.image = UIImage(named: "radiounselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        delegate?.didTapOnFeMailBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnUpdateProfileBtnAction(_ sender: Any) {
        delegate?.didTapOnUpdateProfileBtnAction(cell: self)
    }
    
    
}



extension EditProfileTVCell {
    
    //MARK: - DATE PICKER
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dobTF.text = formatter.string(from: datePicker.date)
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
}




extension EditProfileTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == mobileTF {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        }else if textField == emailTF {
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else {
            let maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        
        
    }
    
    
}


extension EditProfileTVCell {
    
    func profileDateils() {
        fnameTF.text = MySingleton.shared.profiledata?.first_name
        lnameTF.text = MySingleton.shared.profiledata?.last_name
        mobileTF.text = MySingleton.shared.profiledata?.phone
        emailTF.text = MySingleton.shared.profiledata?.email
        dobTF.text = MySingleton.shared.profiledata?.date_of_birth
        addressTF.text = MySingleton.shared.profiledata?.address
        countryTF.text = MySingleton.shared.profiledata?.country_name
        stateTF.text = MySingleton.shared.profiledata?.state_name
        cityTF.text = MySingleton.shared.profiledata?.city_name
        pincodeTF.text = MySingleton.shared.profiledata?.pin_code
        
    }
}
