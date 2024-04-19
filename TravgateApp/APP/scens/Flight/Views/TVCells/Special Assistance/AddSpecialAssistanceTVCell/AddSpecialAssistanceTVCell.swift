//
//  AddSpecialAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 19/04/24.
//

import UIKit
import DropDown

protocol AddSpecialAssistanceTVCellDelegate {
    func didTapOnCheckBoxBtnAction(cell:AddSpecialAssistanceTVCell)
    func didTapOnShowSpecialAssistanceDropDownListBtnAction(cell:AddSpecialAssistanceTVCell)
}


class AddSpecialAssistanceTVCell: UITableViewCell {
    
    @IBOutlet weak var downarrowimg: UIImageView!
    @IBOutlet weak var checkimg: UIImageView!
    @IBOutlet weak var travellerNamkelbl: UILabel!
    @IBOutlet weak var addSpecialAssistanceView: UIView!
    @IBOutlet weak var specialAssistancelbl: UILabel!
    
    var dropDown = DropDown()
    var assistanceNameArray = [String]()
    var assistanceidArray = [String]()
    var checkBoxBool = false
    var delegate:AddSpecialAssistanceTVCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupdropDown()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckBoxBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnShowMealDropDownListBtnAction(_ sender: Any) {
        delegate?.didTapOnShowSpecialAssistanceDropDownListBtnAction(cell: self)
    }
    
    
    
}


extension AddSpecialAssistanceTVCell {
    
    //MARK: - setupVisaDestinationDropDown
    func setupdropDown() {
        
        assistanceNameArray.removeAll()
        assistanceidArray.removeAll()
        
        MySingleton.shared.ssrListArray.forEach { i in
            assistanceNameArray.append(i.name ?? "")
            assistanceidArray.append(i.id ?? "")
        }
        
        self.specialAssistancelbl.text = assistanceNameArray[0]
        dropDown.dataSource = assistanceNameArray
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.addSpecialAssistanceView
        dropDown.bottomOffset = CGPoint(x: 0, y: self.addSpecialAssistanceView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.specialAssistancelbl.text = self?.assistanceNameArray[index]
            
        }
    }
}
