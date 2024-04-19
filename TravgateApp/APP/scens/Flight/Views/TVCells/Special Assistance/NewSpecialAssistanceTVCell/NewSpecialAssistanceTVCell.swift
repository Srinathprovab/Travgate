//
//  NewSpecialAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 19/04/24.
//

import UIKit
protocol NewSpecialAssistanceTVCellDelegate {
    func didTapOnCheckBoxBtnAction(cell:NewSpecialAssistanceTVCell)
}

class NewSpecialAssistanceTVCell: TableViewCell {
    
    
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var checkimg: UIImageView!
    
    var checkbool = false
    var delegate:NewSpecialAssistanceTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serviceView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        checkbool.toggle()
        if checkbool {
            checkimg.image = UIImage(named: "check")
            serviceView.isHidden = false
        }else {
            checkimg.image = UIImage(named: "uncheck")
            serviceView.isHidden = true
        }
        
        delegate?.didTapOnCheckBoxBtnAction(cell: self)
    }
    
    
    
}
