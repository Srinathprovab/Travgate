//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import SDWebImage


protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtn(cell:MenuBGTVCell)
    func didTapOnEditProfileBtn(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfilelbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    var delegate:MenuBGTVCellDelegate?
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
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
            loginBtn.setTitle("   Srinath Badmi", for: .normal)
            loginBtn.isUserInteractionEnabled = false
            editProfileView.isHidden = false
        } else {
            profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            loginBtn.setTitle("   Login/Sign up", for: .normal)
            editProfileView.isHidden = true
            loginBtn.isUserInteractionEnabled = true
        }
    }
    
    
    func setupUI() {
        profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        profileImage.layer.cornerRadius = profileImage.layer.frame.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = UIColor.WhiteColor.cgColor
        
        editProfileView.isHidden = true
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .clear
        editProfileBtn.layer.cornerRadius = 15
        editProfileBtn.layer.borderColor = UIColor.WhiteColor.cgColor
        editProfileBtn.layer.borderWidth = 2
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
        
    }
}
