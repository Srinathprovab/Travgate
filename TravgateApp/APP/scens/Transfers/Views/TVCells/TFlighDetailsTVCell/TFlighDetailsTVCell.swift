//
//  TFlighDetailsTVCell.swift
//  Travgate
//
//  Created by FCI on 09/05/24.
//

import UIKit

protocol TFlighDetailsTVCellDelegate {
    
    func doneTimePicker(cell:TFlighDetailsTVCell)
    func cancelTimePicker(cell:TFlighDetailsTVCell)
    
}

class TFlighDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var arrivalFlightnoTF: UITextField!
    @IBOutlet weak var arrivalTerminalTF: UITextField!
    @IBOutlet weak var arrivalDateTF: UITextField!
    @IBOutlet weak var arrivalTimeTF: UITextField!
    @IBOutlet weak var departureFlightnoTF: UITextField!
    @IBOutlet weak var departureTerminalTF: UITextField!
    @IBOutlet weak var departureDateTF: UITextField!
    @IBOutlet weak var departurelTimeTF: UITextField!
    
    
    let arrivalDatePicker = UIDatePicker()
    let departDatePicker = UIDatePicker()
    let arrivalTimePicker = UIDatePicker()
    let departTimePicker = UIDatePicker()
    
    var delegate:TFlighDetailsTVCellDelegate?
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
        
        setupTF(tf: arrivalFlightnoTF)
        setupTF(tf: arrivalTerminalTF)
        setupTF(tf: arrivalDateTF)
        setupTF(tf: arrivalTimeTF)
        setupTF(tf: departureFlightnoTF)
        setupTF(tf: departureTerminalTF)
        setupTF(tf: departureDateTF)
        setupTF(tf: departurelTimeTF)
        
        showarrivalDatePicker()
        showdepartDatePicker()
        showArrivalTimePicker()
        showDepartTimePicker()
        
    }
    
    override func updateUI() {
        
    }
    
    
    func setupTF(tf:UITextField) {
        tf.font = .InterRegular(size: 14)
        tf.setLeftPaddingPoints(15)
        tf.textColor = .TitleColor
        tf.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
    }
    
    @objc func editingTextField(_ tf:UITextField) {
        print(tf.text ?? "")
    }
    
}



extension TFlighDetailsTVCell {
    
    //MARK: - showTimePicker
    func showArrivalTimePicker() {
        // Format Time
        
        arrivalTimePicker.datePickerMode = .time
        arrivalTimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        arrivalTimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = arrivalTimeTF.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                arrivalTimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.arrivalTimeTF.inputAccessoryView = toolbar
        self.arrivalTimeTF.inputView = arrivalTimePicker
    }
    
    
    
    
    //MARK: - showTimePicker
    func showDepartTimePicker() {
        // Format Time
        
        departTimePicker.datePickerMode = .time
        departTimePicker.preferredDatePickerStyle = .wheels
        
        // Set 24-hour format
        departTimePicker.locale = Locale(identifier: "en_GB")
        
        if let selectedTime = departurelTimeTF.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            if let selectedDate = formatter.date(from: selectedTime) {
                departTimePicker.date = selectedDate
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        self.departurelTimeTF.inputAccessoryView = toolbar
        self.departurelTimeTF.inputView = departTimePicker
    }
    
    @objc func doneTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.arrivalTimeTF.text = formatter.string(from: arrivalTimePicker.date)
        self.departurelTimeTF.text = formatter.string(from: departTimePicker.date)
       
        self.arrivalTimeTF.resignFirstResponder()
        self.departurelTimeTF.resignFirstResponder()
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker() {
        
        if cellInfo?.key == "oneway" {
            self.arrivalTimeTF.resignFirstResponder()
        }else {
            
            self.arrivalTimeTF.resignFirstResponder()
            self.departurelTimeTF.resignFirstResponder()
        }
        
        delegate?.cancelTimePicker(cell: self)
    }
}




extension TFlighDetailsTVCell {
    
    
    //MARK: - showarrivalDatePicker
    func showarrivalDatePicker(){
        //Formate Date
        arrivalDatePicker.datePickerMode = .date
        arrivalDatePicker.minimumDate = Date()
        arrivalDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: arrivalDateTF.text ?? "") {
            arrivalDatePicker.date = calDepDate
            
            if self.departureDateTF.text == "" {
                departDatePicker.date = calDepDate
            }
            
            
            // Check if returnDate date is smaller than calDepDate date
            if let returnDate = formter.date(from: self.departureDateTF.text ?? ""),
               returnDate < calDepDate {
                departDatePicker.date = calDepDate
                
                // Also update the label to reflect the change
                self.departureDateTF.text = formter.string(from: calDepDate)
            }
            
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker1));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.arrivalDateTF.inputAccessoryView = toolbar
        self.arrivalDateTF.inputView = arrivalDatePicker
        
    }
    
    
    
    //MARK: - showdepartDatePicker
    func showdepartDatePicker(){
        //Formate Date
        departDatePicker.datePickerMode = .date
        let selectedDate = self.arrivalDateTF.isFirstResponder ? arrivalDatePicker.date : departDatePicker.date
        departDatePicker.minimumDate = selectedDate
        departDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: arrivalDateTF.text ?? "") {
            
            if self.departureDateTF.text == "" {
                departDatePicker.date = calDepDate
                
            }else {
                if let rcalRetDate = formter.date(from: departureDateTF.text ?? "") {
                    departDatePicker.date = rcalRetDate
                }
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker1));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        
        self.departureDateTF.inputAccessoryView = toolbar
        self.departureDateTF.inputView = departDatePicker
        
        
    }
    
    
    @objc func donedatePicker1(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        self.arrivalDateTF.text = formatter.string(from: arrivalDatePicker.date)
        self.departureDateTF.text = formatter.string(from: departDatePicker.date)
       
        self.arrivalDateTF.resignFirstResponder()
        self.departureDateTF.resignFirstResponder()
        
       // delegate?.doneTimePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker1(){
        self.arrivalDateTF.resignFirstResponder()
        self.departureDateTF.resignFirstResponder()
      //  delegate?.cancelTimePicker(cell:self)
    }
    
}
