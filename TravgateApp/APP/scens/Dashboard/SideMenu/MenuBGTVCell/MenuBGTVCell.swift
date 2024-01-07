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
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    
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
//            loginBtn.isHidden = false
//            loginBtn.isUserInteractionEnabled = false
//            loginBtn.setTitle("\(pdetails?.first_name ?? pdetails?.email ?? "") \(pdetails?.last_name ?? "")", for: .normal)
//            profileImage.sd_setImage(with: URL(string: pdetails?.image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
//            editProfileView.isHidden = false
        } else {
            profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            editProfileView.isHidden = false
            loginBtn.setTitle("Login / Signup", for: .normal)
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
//        editProfileBtn.setTitle("Add Your Details", for: .normal)
        editProfileBtn.setTitleColor(.TitleColor, for: .normal)
        
        editProfileBtn.titleLabel?.font = UIFont.InterRegular(size: 12)
        loginBtn.setTitle("Login/Signup", for: .normal)
        loginBtn.setTitleColor(.TitleColor , for: .normal)
        loginBtn.titleLabel?.font = UIFont.InterMedium(size: 20)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .clear
        editProfileView.layer.cornerRadius = 15
        editProfileView.clipsToBounds = true
        
        editProfilelbl.text = "Add Your Details"
        editProfilelbl.textColor = .TitleColor
        editProfilelbl.font = UIFont.OpenSansRegular(size: 14)
        
        //editProfileViewHeight.constant = 0
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
        
    }
}
