//
//  AddAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 21/04/24.
//

import UIKit
import DropDown

protocol AddAssistanceTVCellDelegate {
    func didTapOnShowAssistanceDropDownListBtnAction(cell:AddAssistanceTVCell)
}

class AddAssistanceTVCell: UITableViewCell {
    
    
    @IBOutlet weak var assistancelbl: UILabel!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var assistanceView: UIView!
    
    
    var assistanceNameArray = [String]()
    var assistanceidArray = [String]()
    var assistanceDropDown = DropDown()
    var delegate:AddAssistanceTVCellDelegate?
    
    
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
        setupServicedropDown()
    }
    
    
    @IBAction func didTapOnShowAssistanceDropDownListBtnAction(_ sender: Any) {
        delegate?.didTapOnShowAssistanceDropDownListBtnAction(cell: self)
    }
    
    
}



extension AddAssistanceTVCell {
    
    //MARK: - setupVisaDestinationDropDown
    func setupServicedropDown() {
        
        assistanceNameArray.removeAll()
        assistanceidArray.removeAll()
        
        MySingleton.shared.ssrListArray.forEach { i in
            assistanceNameArray.append(i.name ?? "")
            assistanceidArray.append(i.id ?? "")
        }
        
        self.assistancelbl.text = "Select"
        assistanceDropDown.dataSource = assistanceNameArray
        assistanceDropDown.direction = .bottom
        assistanceDropDown.backgroundColor = .WhiteColor
        assistanceDropDown.anchorView = self.assistanceView
        assistanceDropDown.bottomOffset = CGPoint(x: 0, y: self.assistanceView.frame.size.height + 10)
        assistanceDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.assistancelbl.text = item
            self?.assistancelbl.textColor = .TitleColor
            
        }
    }
    
    
}
