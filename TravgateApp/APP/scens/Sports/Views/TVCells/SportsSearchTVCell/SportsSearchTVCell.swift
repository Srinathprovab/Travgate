//
//  SportsSearchTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit
import DropDown

protocol SportsSearchTVCellDelegate {
    
    func didTapOnSelectServiceBtn(cell:SportsSearchTVCell)
    func didTapOnSearchSportsBtnAction(cell:SportsSearchTVCell)
    func donedatePicker(cell:SportsSearchTVCell)
    func cancelDatePicker(cell:SportsSearchTVCell)
    
}

class SportsSearchTVCell: TableViewCell {
    
    @IBOutlet weak var selectServiceView: UIView!
    @IBOutlet weak var selectServicelbl: UILabel!
    @IBOutlet weak var teamTF: UITextField!
    @IBOutlet weak var venuTF: UITextField!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retDateTF: UITextField!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var searchbtn: UIButton!
    
    
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    let dropDown = DropDown()
    
    var delegate:SportsSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        
        showdepDatePicker()
        showretDatePicker()
        setupTF(tf: teamTF)
        setupTF(tf: venuTF)
        setupDropDown()
        searchbtn.layer.cornerRadius = 4
        
    }
    
    func setupTF(tf:UITextField) {
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(35)
    }
    
    @IBAction func didTapOnClearvenuTFBtnAction(_ sender: Any) {
        venuTF.text = ""
    }
    @IBAction func didTapOnClearTeamTFBtnAction(_ sender: Any) {
        teamTF.text = ""
    }
    
    
    @IBAction func didTapOnSelectServiceBtnAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapOnSearchSportsBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchSportsBtnAction(cell: self)
    }
    
}



extension SportsSearchTVCell {
    
    
    
    
    func setupDropDown() {
        
        dropDown.dataSource = ["aaaaaa","bbbbbb","cccccc","dddddd"]
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.selectServiceView
        dropDown.bottomOffset = CGPoint(x: 0, y: selectServiceView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.selectServicelbl.text = item
            self?.selectServicelbl.textColor = .TitleColor
            
            self?.delegate?.didTapOnSelectServiceBtn(cell: self!)
            
        }
    }
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retDatelbl.text == "Select Date" {
                retDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? ""),
               returnDate < calDepDate {
                retDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.retDatelbl.text = formter.string(from: calDepDate)
            }
            
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depDateTF.inputAccessoryView = toolbar
        self.depDateTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depDateTF.isFirstResponder ? depDatePicker.date : retDatePicker.date
        retDatePicker.minimumDate = selectedDate
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalDepDate) ?? "") {
            
            if self.retDatelbl.text == "Select Date" {
                retDatePicker.date = calDepDate
                
            }else {
                if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.sportcalRetDate) ?? "") {
                    retDatePicker.date = rcalRetDate
                }
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        
        self.retDateTF.inputAccessoryView = toolbar
        self.retDateTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        
        depDatelbl.textColor = .TitleColor
        retDatelbl.textColor = .TitleColor
        
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}

