//
//  BookTransfersTVCell.swift
//  Travgate
//
//  Created by FCI on 08/05/24.
//

import UIKit

protocol BookTransfersTVCellDelegate {
    func donedatePicker(cell:BookTransfersTVCell)
    func cancelDatePicker(cell:BookTransfersTVCell)
    func doneTimePicker(cell:BookTransfersTVCell)
    func cancelTimePicker(cell:BookTransfersTVCell)
    func didTapOnSearchBtnAction(cell:BookTransfersTVCell)
    
}

class BookTransfersTVCell: TableViewCell {
    
    @IBOutlet weak var fromView: BorderedView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toView: BorderedView!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depTimeTF: UITextField!
    @IBOutlet weak var retDateTF: UITextField!
    @IBOutlet weak var retTimeTF: UITextField!
    @IBOutlet weak var returnView: BorderedView!
    
    
    let depDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let returntimePicker = UIDatePicker()
    
    var delegate:BookTransfersTVCellDelegate?
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
        setupTF(tf: fromTF)
        setupTF(tf: toTF)
        setupTF(tf: depDateTF)
        setupTF(tf: depTimeTF)
        setupTF(tf: retDateTF)
        setupTF(tf: retTimeTF)
        
        returnView.isHidden = true
        searchBtn.layer.cornerRadius = 6
        
        showdepDatePicker()
        showretDatePicker()
        showDepTimePicker()
        showReturnTimePicker()
    }
    
    override func updateUI() {
        if cellInfo?.key == "oneway" {
            returnView.isHidden = true
            depDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? ""
            depTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) ?? ""
        }else {
            returnView.isHidden = false
            depDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? ""
            retDateTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) ?? ""
            
            depTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) ?? ""
            retTimeTF.text = defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) ?? ""
        }
    }
    
    
    func setupTF(tf:UITextField) {
        tf.font = .OpenSansRegular(size: 14)
        tf.setLeftPaddingPoints(40)
        tf.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
    }
    
    @objc func editingTextField(_ textfield:UITextField) {
        print(textfield.text)
    }
    
    
    @IBAction func didTapOnSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchBtnAction(cell: self)
    }
    
    
}



extension BookTransfersTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retDateTF.text == "" {
                retDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.retDateTF.text ?? ""),
               returnDate < calDepDate {
                retDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.retDateTF.text = formter.string(from: calDepDate)
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
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.transfercalDepDate) ?? "") {
            
            if self.retDateTF.text == "" {
                retDatePicker.date = calDepDate
                
            }else {
                if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.transfercalRetDate) ?? "") {
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
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}


extension BookTransfersTVCell {
    
    //MARK: - showTimePicker
    func showDepTimePicker() {
        // Format Time
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        timePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = defaults.string(forKey: UserDefaultsKeys.transfercalDepTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                timePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.depTimeTF.inputAccessoryView = toolbar
        self.depTimeTF.inputView = timePicker
    }
    
    
    
    
    //MARK: - showTimePicker
    func showReturnTimePicker() {
        // Format Time
        
        returntimePicker.datePickerMode = .time
        returntimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        returntimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = defaults.string(forKey: UserDefaultsKeys.transfercalRetTime) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                returntimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.retTimeTF.inputAccessoryView = toolbar
        self.retTimeTF.inputView = returntimePicker
    }
    
    @objc func doneTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if cellInfo?.key == "oneway" {
            self.depTimeTF.text = formatter.string(from: timePicker.date)
            defaults.set(formatter.string(from: timePicker.date), forKey: UserDefaultsKeys.transfercalDepTime)
            self.depTimeTF.resignFirstResponder()
           
        }else {
            self.depTimeTF.text = formatter.string(from: timePicker.date)
            self.retTimeTF.text = formatter.string(from: returntimePicker.date)
            defaults.set(formatter.string(from: timePicker.date), forKey: UserDefaultsKeys.transfercalDepTime)
            defaults.set(formatter.string(from: returntimePicker.date), forKey: UserDefaultsKeys.transfercalRetTime)
            
            self.depTimeTF.resignFirstResponder()
            self.retTimeTF.resignFirstResponder()
            
        }
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker() {
       
        if cellInfo?.key == "oneway" {
            self.depTimeTF.resignFirstResponder()
        }else {
            
            self.depTimeTF.resignFirstResponder()
            self.retTimeTF.resignFirstResponder()
        }
        delegate?.cancelTimePicker(cell: self)
    }
}
