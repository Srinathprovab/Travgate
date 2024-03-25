//
//  SelectLanguageTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var langLogoImg: UIImageView!
    @IBOutlet weak var iconImg: UIImageView!
    
    
    var type = String()
    var logoimg = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        unselected()
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        langLogoImg.image = UIImage(named: cellInfo?.image ?? "")
        type = cellInfo?.text ?? ""
        
        self.iconImg.sd_setImage(with: URL(string: "\(cellInfo?.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        
        logoimg = cellInfo?.image ?? ""
        
        subTitlelbl.isHidden = true
        langLogoImg.isHidden = true
        
        if cellInfo?.key == "lang" {
            subTitlelbl.isHidden = true
            langLogoImg.isHidden = false
        }else {
            subTitlelbl.isHidden = false
            langLogoImg.isHidden = true
        }
        
        if let currency = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) {
            if currency == subTitlelbl.text {
                selected()
            }
        }
        
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        holderView.layer.borderColor = UIColor.BorderColor.cgColor
        holderView.layer.borderWidth = 1
        
        titlelbl.textColor = .TitleColor
        titlelbl.font = UIFont.OpenSansRegular(size: 16)
        
        subTitlelbl.textColor = .TitleColor
        subTitlelbl.font = UIFont.OpenSansRegular(size: 16)
        
    }
    
    func selected() {
        self.holderView.layer.borderColor = UIColor.Buttoncolor.cgColor
    }
    
    
    func unselected() {
        self.holderView.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
}
