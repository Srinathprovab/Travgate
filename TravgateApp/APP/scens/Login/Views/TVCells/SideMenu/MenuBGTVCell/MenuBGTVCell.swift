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
            
            loginBtn.setTitle("   \( MySingleton.shared.profiledata?.first_name ?? "") \( MySingleton.shared.profiledata?.last_name ?? "")", for: .normal)
            loginBtn.isUserInteractionEnabled = false
            editProfileView.isHidden = false
            
            if MySingleton.shared.profiledata?.image != "" {
                profileImage.sd_setImage(with: URL(string: MySingleton.shared.profiledata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"),options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                    if let error = error {
                        // Handle error loading image
                        print("Error loading image: \(error.localizedDescription)")
                        // Check if the error is due to a 404 Not Found response
                        if (error as NSError).code == NSURLErrorBadServerResponse {
                            // Set placeholder image for 404 error
                            self.profileImage.image = UIImage(named: "noimage")
                        } else {
                            // Set placeholder image for other errors
                            self.profileImage.image = UIImage(named: "noimage")
                        }
                    }
                })
            }else {
                profileImage.image = UIImage(named: "noprofile")?.withRenderingMode(.alwaysOriginal)
            }
            
        } else {
            profileImage.image = UIImage(named: "noprofile")?.withRenderingMode(.alwaysOriginal)
            loginBtn.setTitle("   Login/Sign up", for: .normal)
            editProfileView.isHidden = true
            loginBtn.isUserInteractionEnabled = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(logindone), name: Notification.Name("logindone"), object: nil)
    }
    
    @objc func logindone() {
        if MySingleton.shared.profiledata?.image != "" {
            profileImage.sd_setImage(with: URL(string: MySingleton.shared.profiledata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"),options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    // Handle error loading image
                    print("Error loading image: \(error.localizedDescription)")
                    // Check if the error is due to a 404 Not Found response
                    if (error as NSError).code == NSURLErrorBadServerResponse {
                        // Set placeholder image for 404 error
                        self.profileImage.image = UIImage(named: "noimage")
                    } else {
                        // Set placeholder image for other errors
                        self.profileImage.image = UIImage(named: "noimage")
                    }
                }
            })
        }else {
            profileImage.image = UIImage(named: "noprofile")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    
    func setupUI() {
        profileImage.image = UIImage(named: "noprofile")?.withRenderingMode(.alwaysOriginal)
        profileImage.layer.cornerRadius = profileImage.layer.frame.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = UIColor.WhiteColor.cgColor
        
        editProfileView.isHidden = true
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .clear
        editProfileBtn.layer.cornerRadius = 15
        editProfileBtn.layer.borderColor = UIColor.Buttoncolor.cgColor
        editProfileBtn.layer.borderWidth = 2
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
        
    }
}
