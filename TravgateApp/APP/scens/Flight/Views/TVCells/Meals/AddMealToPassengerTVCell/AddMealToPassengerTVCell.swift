//
//  AddMealToPassengerTVCell.swift
//  Travgate
//
//  Created by FCI on 19/04/24.
//

import UIKit
import DropDown

protocol AddMealToPassengerTVCellDelegate {
    func didTapOnCheckBoxBtnAction(cell:AddMealToPassengerTVCell)
    func didTapOnShowMealDropDownListBtnAction(cell:AddMealToPassengerTVCell)
    func didTapOnShowMealDropDownListForCircleBtnAction(cell:AddMealToPassengerTVCell)
    
}

class AddMealToPassengerTVCell: UITableViewCell {

    @IBOutlet weak var downarrowimg: UIImageView!
    @IBOutlet weak var checkimg: UIImageView!
    @IBOutlet weak var travellerNamkelbl: UILabel!
    @IBOutlet weak var addMealView: UIView!
    @IBOutlet weak var meallbl: UILabel!
    @IBOutlet weak var downarrowimg1: UIImageView!
    @IBOutlet weak var addMealView1: UIView!
    @IBOutlet weak var meallbl1: UILabel!
    @IBOutlet weak var fromcodelbl: UILabel!
    @IBOutlet weak var tocodelbl: UILabel!
    
    var dropDown = DropDown()
    var dropDown1 = DropDown()
    var mealNameArray = [String]()
    var mealidArray = [String]()
    var checkBoxBool = false
    var delegate:AddMealToPassengerTVCellDelegate?
    
    
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
        
        addMealView.isHidden = true
        addMealView1 .isHidden = true
        
        setupdropDown()
        setupdropDown1()
    }
    
    
    @IBAction func didTapOnCheckBoxBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckBoxBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnShowMealDropDownListBtnAction(_ sender: Any) {
        delegate?.didTapOnShowMealDropDownListBtnAction(cell: self)
    }
    
    @IBAction func didTapOnShowMealDropDownListForCircleBtnAction(_ sender: Any) {
        delegate?.didTapOnShowMealDropDownListForCircleBtnAction(cell: self)
    }
    
    
}


extension AddMealToPassengerTVCell {
    
    //MARK: - setupVisaDestinationDropDown
    func setupdropDown() {
        
        mealNameArray.removeAll()
        mealidArray.removeAll()
        
        MySingleton.shared.mealListArray.forEach { i in
            mealNameArray.append(i.name ?? "")
            mealidArray.append(i.id ?? "")
        }
        
        self.meallbl.text = "Select"
        dropDown.dataSource = mealNameArray
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.addMealView
        dropDown.bottomOffset = CGPoint(x: 0, y: self.addMealView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.meallbl.text = self?.mealNameArray[index]
            self?.meallbl.textColor = .TitleColor
            
        }
    }
    
    
    //MARK: - setupVisaDestinationDropDown
    func setupdropDown1() {
        
        mealNameArray.removeAll()
        mealidArray.removeAll()
        
        MySingleton.shared.mealListArray.forEach { i in
            mealNameArray.append(i.name ?? "")
            mealidArray.append(i.id ?? "")
        }
        
        self.meallbl1.text = "Select"
        dropDown1.dataSource = mealNameArray
        dropDown1.direction = .bottom
        dropDown1.backgroundColor = .WhiteColor
        dropDown1.anchorView = self.addMealView1
        dropDown1.bottomOffset = CGPoint(x: 0, y: self.addMealView1.frame.size.height + 10)
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.meallbl1.text = self?.mealNameArray[index]
            self?.meallbl1.textColor = .TitleColor
            
        }
    }
}
