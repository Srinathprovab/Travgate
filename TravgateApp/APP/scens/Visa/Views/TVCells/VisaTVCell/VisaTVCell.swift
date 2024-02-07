//
//  VisaTVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit


protocol VisaTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnSubmitEnquiryBtnAction(cell:VisaTVCell)
    func didTapOnPassengersBtnAction(cell:VisaTVCell)
    
}

class VisaTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var dateoftravelTF: UITextField!
    @IBOutlet weak var residencyTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var remarkTF: UITextField!
    @IBOutlet weak var captchTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passengersBtn: UIButton!
    
    var delegate:VisaTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: countrycodeTF)
        setupTF(tf: dateoftravelTF)
        setupTF(tf: residencyTF)
        setupTF(tf: nationalityTF)
        setupTF(tf: destination)
        setupTF(tf: remarkTF)
        setupTF(tf: captchTF)
        
        submitBtn.layer.cornerRadius = 6
        submitBtn.addTarget(self, action: #selector(didTapOnSubmitEnquiryBtnAction(_:)), for: .touchUpInside)
        passengersBtn.addTarget(self, action: #selector(didTapOnPassengersBtnAction(_:)), for: .touchUpInside)
    }
    
    override func updateUI() {
        
    }
    
    
    func setupTF(tf:UITextField) {
        tf.delegate = self
        tf.setLeftPaddingPoints(15)
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        
        
        switch textField.tag {
        case 1:
            fnameTF.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 2:
            lnameTF.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 3:
            emailTF.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
        case 4:
            countrycodeTF.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
        case 5:
            mobileTF.layer.borderColor = UIColor.AppBorderColor.cgColor
            break
            
            
       
            
            
            
        default:
            break
        }
        
        
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    @objc func didTapOnSubmitEnquiryBtnAction(_ sender:UIButton) {
        
        delegate?.didTapOnSubmitEnquiryBtnAction(cell:self)
    }
    
    @objc func didTapOnPassengersBtnAction(_ sender:UIButton) {
        delegate?.didTapOnPassengersBtnAction(cell:self)
    }
    
}



extension VisaTVCell {
    
    
    
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
