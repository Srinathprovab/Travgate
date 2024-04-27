//
//  PaymentTypeTVCell.swift
//  Travgate
//
//  Created by FCI on 27/04/24.
//

import UIKit

protocol PaymentTypeTVCellDelegate {
    func didTapOnPayNowBtnAction(cell:PaymentTypeTVCell)
}

class PaymentTypeTVCell: TableViewCell {

    @IBOutlet weak var paymentTypeCV: UICollectionView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var paynowBtn: UIButton!
    
    
    var paymentTypeImageArray = ["knetpay","visapay","masterpay"]
    var delegate:PaymentTypeTVCellDelegate?
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
        
        
        paynowBtn.layer.cornerRadius = 4
        setupCV()
    }
    
    override func updateUI() {
        MySingleton.shared.setAttributedTextnew(str1: "You will Pay: ",
                                                str2: " \(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(totlConvertedGrand)",
                                                lbl: kwdlbl,
                                                str1font: .OpenSansMedium(size: 16),
                                                str2font: .OpenSansBold(size: 16),
                                                str1Color: .TitleColor,
                                                str2Color: .TitleColor)
    }
    
    
    @IBAction func didTapOnPayNowBtnAction(_ sender: Any) {
        delegate?.didTapOnPayNowBtnAction(cell: self)
    }
    
}


extension PaymentTypeTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "PaymentTypeCVCell", bundle: nil)
        paymentTypeCV.register(nib, forCellWithReuseIdentifier: "cell")
        paymentTypeCV.delegate = self
        paymentTypeCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        paymentTypeCV.collectionViewLayout = layout
        paymentTypeCV.bounces = false
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentTypeImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PaymentTypeCVCell {
            
            
            cell.payTypeImg.image = UIImage(named: paymentTypeImageArray[indexPath.row])
            if indexPath.row == 0 {
                
                // Select the first row initially
                let indexPath1 = IndexPath(row: 0, section: 0)
                paymentTypeCV.selectItem(at: indexPath1, animated: false, scrollPosition: .bottom)
                
                
                cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            }else {
                cell.radioImg.image = UIImage(named: "radiounselected")
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentTypeCVCell {
                cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            }
        }
    
    
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentTypeCVCell {
                cell.radioImg.image = UIImage(named: "radiounselected")
            }
        }
    
    
}
