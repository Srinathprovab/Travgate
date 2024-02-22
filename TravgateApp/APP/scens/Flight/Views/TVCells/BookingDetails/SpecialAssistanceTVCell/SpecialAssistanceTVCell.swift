//
//  SpecialAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 22/02/24.
//

import UIKit

class SpecialAssistanceTVCell: TableViewCell {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var checkimg: UIImageView!
    
    
    var btnBool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btn.addTarget(self, action: #selector(didTapOnSpecialBtnAction), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    
    }
    
    
    
    
    @objc func didTapOnSpecialBtnAction() {
        btnBool.toggle()
    
        if btnBool{
            checkimg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
        }else {
            checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBorderColor)
        }
        
    }
    
}
