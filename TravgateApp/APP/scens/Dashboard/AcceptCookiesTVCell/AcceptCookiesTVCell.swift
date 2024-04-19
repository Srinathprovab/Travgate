//
//  AcceptCookiesTVCell.swift
//  Travgate
//
//  Created by FCI on 18/04/24.
//

import UIKit

protocol AcceptCookiesTVCellDelegate {
    func didTapOnAcceptAllCookieBtnAction(cell:AcceptCookiesTVCell)
    func didTapOnRejectCookieBtnAction(cell:AcceptCookiesTVCell)
    func didTapOnPrivacyCookiesBtnAction(cell:AcceptCookiesTVCell)
}

class AcceptCookiesTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
    
    
    var str1 = "These are used for different purposes. By clicking on 'All cookies' you agree with our "
    
    var str2 = "Privacy & cookies"
    
    
    var str3 = " and we receive the non-functional cookies. Via these non-functional cookies Travgate can approach you on another site based on the pages you have visited."
    
    var delegate:AcceptCookiesTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setipUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setipUI(){
        
        acceptBtn.layer.borderWidth = 1
        acceptBtn.layer.borderColor = UIColor.BorderColor.cgColor
        acceptBtn.layer.cornerRadius = 6
        
        rejectBtn.layer.borderWidth = 1
        rejectBtn.layer.borderColor = UIColor.BorderColor.cgColor
        rejectBtn.layer.cornerRadius = 6
        
        
        setAttributedTextnew(str1: str1,
                             str2: str2,
                             str3: str3,
                             lbl: titlelbl,
                             str1font: .OpenSansMedium(size: 14),
                             str2font: .OpenSansMedium(size: 14),
                             str1Color: .TitleColor,
                             str2Color: .BooknowBtnColor)
        
        
        
        
    }
    
    override func updateUI() {
        
    }
    
    @IBAction func didTapOnAcceptAllCookieBtnAction(_ sender: Any) {
        acceptBtn.backgroundColor = .Buttoncolor
        acceptBtn.setTitleColor(.WhiteColor, for: .normal)
        rejectBtn.backgroundColor = .WhiteColor
        rejectBtn.setTitleColor(.TitleColor, for: .normal)
        delegate?.didTapOnAcceptAllCookieBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnRejectCookieBtnAction(_ sender: Any) {
        acceptBtn.backgroundColor = .WhiteColor
        acceptBtn.setTitleColor(.TitleColor, for: .normal)
        rejectBtn.backgroundColor = .Buttoncolor
        rejectBtn.setTitleColor(.WhiteColor, for: .normal)
        delegate?.didTapOnRejectCookieBtnAction(cell: self)
    }
    
    func setAttributedTextnew(str1: String, str2: String, str3: String, lbl: UILabel, str1font: UIFont, str2font: UIFont, str1Color: UIColor, str2Color: UIColor) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor: str1Color,
                      NSAttributedString.Key.font: str1font] as [NSAttributedString.Key: Any]
        
        
        let atter2 = [NSAttributedString.Key.foregroundColor: UIColor.BooknowBtnColor,
                      NSAttributedString.Key.font: str2font,
                      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key: Any]
        
        
        
        let atter3 = [NSAttributedString.Key.foregroundColor: str1Color,
                      NSAttributedString.Key.font: str1font] as [NSAttributedString.Key: Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter3)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        
        lbl.attributedText = combination
        
        // Add tap gesture recognizer to label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        if sender.didTapAttributedString("Privacy & cookies", in: titlelbl) {
            delegate?.didTapOnPrivacyCookiesBtnAction(cell:self)
        }
    }
    
}
