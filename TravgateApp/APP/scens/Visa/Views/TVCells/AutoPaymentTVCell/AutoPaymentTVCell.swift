//
//  AutoPaymentTVCell.swift
//  TravgateApp
//
//  Created by FCI on 07/02/24.
//

import UIKit

protocol AutoPaymentTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnPaynowBtnAction(cell:AutoPaymentTVCell)
}

class AutoPaymentTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var remarkTF: UITextField!
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    @IBOutlet weak var paynowBtn: UIButton!
    @IBOutlet weak var autopayTabscv: UICollectionView!
    
    
    var cvtabsName = ["Flight","Hotel","Insurence","Visa","Top up"]
    var delegate:AutoPaymentTVCellDelegate?
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
        
        setupCV()
        
        setupTF(tf: fnameTF)
        setupTF(tf: lnameTF)
        setupTF(tf: mobileTF)
        setupTF(tf: emailTF)
        setupTF(tf: countrycodeTF)
        setupTF(tf: amountTF)
        setupTF(tf: remarkTF)
        
        paynowBtn.layer.cornerRadius = 6
        paynowBtn.addTarget(self, action: #selector(didTapOnPaynowBtnAction(_:)), for: .touchUpInside)
        
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
    
    
    @objc func didTapOnPaynowBtnAction(_ sender:UIButton) {
        delegate?.didTapOnPaynowBtnAction(cell:self)
    }
    
    
}




extension AutoPaymentTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "AutopayTabCVCell", bundle: nil)
        autopayTabscv.register(nib, forCellWithReuseIdentifier: "cell")
        autopayTabscv.delegate = self
        autopayTabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        autopayTabscv.collectionViewLayout = layout
        autopayTabscv.bounces = false
        
        // Select the first item (cell) in the collection view
        let indexPath = IndexPath(item: 0, section: 0)
        autopayTabscv.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvtabsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AutopayTabCVCell {
            
            cell.titlelbl.text = cvtabsName[indexPath.row]
            if indexPath.row == 0 {
                cell.titlelbl.textColor = .WhiteColor
                cell.holderView.backgroundColor = .KWDcolor
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AutopayTabCVCell {
            cell.titlelbl.textColor = .WhiteColor
            cell.holderView.backgroundColor = .KWDcolor
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AutopayTabCVCell {
            cell.titlelbl.textColor = .TitleColor
            cell.holderView.backgroundColor = .WhiteColor
        }
    }
    
    
}


extension AutoPaymentTVCell {
    
    
    
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
