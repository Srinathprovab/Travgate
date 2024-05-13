//
//  InsurenceSearchTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit
import DropDown

protocol InsurenceSearchTVCellDelegate {
    
    func didTapOnInsurenceSearchBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnWhoTravellingBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnWithWhomTravellingBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnTravelZoneBtnAction(cell:InsurenceSearchTVCell)
    func didTapOnMultiTripslblBtnAction(cell:InsurenceSearchTVCell)
    func donedatePicker(cell:InsurenceSearchTVCell)
    func cancelDatePicker(cell:InsurenceSearchTVCell)
    func didTapOnAddAdditionalTravellerBtnAction(cell:InsurenceSearchTVCell)
    
    
}

class InsurenceSearchTVCell: TableViewCell {
    
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var travellingView: UIView!
    @IBOutlet weak var travellinglbl: UILabel!
    @IBOutlet weak var withWhomTravellingView: UIView!
    @IBOutlet weak var withWhomTravellinglbl: UILabel!
    @IBOutlet weak var travelZoneView: UIView!
    @IBOutlet weak var travelZonelbl: UILabel!
    @IBOutlet weak var multiTripsView: UIView!
    @IBOutlet weak var multiTripslbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var checkinTF: UITextField!
    @IBOutlet weak var checkoutTF: UITextField!
    @IBOutlet weak var additionalTravelersView: UIView!
    @IBOutlet weak var additionalTravelerslbl: UILabel!
    @IBOutlet weak var selectTravellerView: UIView!
    
    
    let travellingDropDown = DropDown()
    let withWhomDropDown = DropDown()
    let travelZoneDropDown = DropDown()
    let multiTripsDropDown = DropDown()
    let addTravellerDropDown = DropDown()
    let checkinDatePicker = UIDatePicker()
    let checkoutDatePicker = UIDatePicker()
    var keyStr = String()
    var addTravellerBool = false
    var selectedTripDuration: String?
    var selectwhomcode = String()
    var selectagecode = String()
    var selectzonecode = String()
   
    var delegate:InsurenceSearchTVCellDelegate?
    
    
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
        searchBtn.layer.cornerRadius = 4
        additionalTravelersView.isHidden = true
        setupTravellingDropDropDown()
        setupWithWhomTravellingDropDropDown()
        setupTravelZoneDropDropDown()
        setupMultiTripsDropDropDown()
        showCheckInDatePicker()
        // showCheckoutDatePicker()
        checkoutTF.isUserInteractionEnabled = false
        setupAddTravellerDropDownsDropDropDown()
        
    }
    
    override func updateUI() {
        
        
    }
    
    
    @IBAction func didTapOnInsurenceSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnInsurenceSearchBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnWhoTravellingBtnAction(_ sender: Any) {
        travellingDropDown.show()
    }
    
    
    @IBAction func didTapOnWithWhomTravellingBtnAction(_ sender: Any) {
        withWhomDropDown.show()
    }
    
    
    @IBAction func didTapOntravelZoneBtnAction(_ sender: Any) {
        travelZoneDropDown.show()
    }
    
    
    @IBAction func didTapOnMultiTripsBtnAction(_ sender: Any) {
        multiTripsDropDown.show()
    }
    
    
    @IBAction func didTapOnAddAdditionalTravellerBtnAction(_ sender: Any) {
        addTravellerDropDown.show()
    }
    
   
    
    
}


extension InsurenceSearchTVCell {
    
    //MARK: - setupTravellingDropDropDown
    func setupTravellingDropDropDown() {
        
        travellingDropDown.dataSource = ["Select",
                                         "Traveller vouncer tnan lo vears",
                                         "Traveller between 18 and 65 years old",
                                         "Traveller between 65 and 75 vears old",
                                         "Traveller between 75 and 80 years old",
                                         "Traveller over 80 years old"]
        
        travellingDropDown.direction = .bottom
        travellingDropDown.backgroundColor = .WhiteColor
        travellingDropDown.anchorView = self.travellingView
        travellingDropDown.cellHeight = 40
        travellingDropDown.textColor = .TitleColor
        travellingDropDown.backgroundColor = .WhiteColor
        travellingDropDown.bottomOffset = CGPoint(x: 0, y: travellingView.frame.size.height + 5)
        travellingDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.travellinglbl.text = item
            if item == "Select" {
                self?.travellinglbl.textColor = .SubtitleColor
            }else {
                self?.travellinglbl.textColor = .TitleColor
            }
            
            
            MySingleton.shared.insurencetravelcode = "\(index)"
            self?.delegate?.didTapOnWhoTravellingBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupWithWhomTravellingDropDropDown
    func setupWithWhomTravellingDropDropDown() {
        
        
        withWhomDropDown.dataSource = withwhomtitleArray
        
        withWhomDropDown.direction = .bottom
        withWhomDropDown.backgroundColor = .WhiteColor
        withWhomDropDown.anchorView = self.withWhomTravellingView
        withWhomDropDown.cellHeight = 40
        withWhomDropDown.textColor = .TitleColor
        withWhomDropDown.backgroundColor = .WhiteColor
        withWhomDropDown.bottomOffset = CGPoint(x: 0, y: withWhomTravellingView.frame.size.height + 5)
        withWhomDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.withWhomTravellinglbl.text = item
            self?.selectagecode = withwhomcodeArray[index]
            
            if item == "Select" {
                self?.withWhomTravellinglbl.textColor = .SubtitleColor
            }else {
                self?.withWhomTravellinglbl.textColor = .TitleColor
            }
            
            if item == "Family" {
                self?.additionalTravelersView.isHidden = false
            }else {
                self?.additionalTravelersView.isHidden = true
            }
            
            
            MySingleton.shared.insurencwhomcode = withwhomcodeArray[index]
            self?.delegate?.didTapOnWithWhomTravellingBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupTravelZoneDropDropDown
    func setupTravelZoneDropDropDown() {
        
        travelZoneDropDown.dataSource = zonetitleArray
        travelZoneDropDown.direction = .bottom
        travelZoneDropDown.backgroundColor = .WhiteColor
        travelZoneDropDown.anchorView = self.travelZoneView
        travelZoneDropDown.cellHeight = 40
        travelZoneDropDown.textColor = .TitleColor
        travelZoneDropDown.backgroundColor = .WhiteColor
        travelZoneDropDown.bottomOffset = CGPoint(x: 0, y: travelZoneView.frame.size.height + 5)
        travelZoneDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.travelZonelbl.text = item
            self?.selectwhomcode = zonecodeArray[index]
            
            if item == "Select" {
                self?.travelZonelbl.textColor = .SubtitleColor
            }else {
                self?.travelZonelbl.textColor = .TitleColor
            }
            
            
            MySingleton.shared.insurenczonecode = zonecodeArray[index]
            self?.delegate?.didTapOnTravelZoneBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupTravelZoneDropDropDown
    func setupMultiTripsDropDropDown() {
        
        multiTripsDropDown.dataSource = multitripstittleArray
        multiTripsDropDown.direction = .bottom
        multiTripsDropDown.backgroundColor = .WhiteColor
        multiTripsDropDown.anchorView = self.multiTripsView
        multiTripsDropDown.cellHeight = 40
        multiTripsDropDown.textColor = .TitleColor
        multiTripsDropDown.backgroundColor = .WhiteColor
        multiTripsDropDown.bottomOffset = CGPoint(x: 0, y: multiTripsView.frame.size.height + 5)
        multiTripsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.multiTripslbl.text = item
            self?.selectzonecode = multitripscodeArray[index]
            
            if item == "Select" {
                self?.multiTripslbl.textColor = .SubtitleColor
            }else {
                self?.multiTripslbl.textColor = .TitleColor
            }
            
            MySingleton.shared.insurencmultitripscode = multitripscodeArray[index]
            self?.delegate?.didTapOnMultiTripslblBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupTravelZoneDropDropDown
    func setupAddTravellerDropDownsDropDropDown() {
        
        addTravellerDropDown.dataSource = ["1","2","3","4","5"]
        addTravellerDropDown.direction = .bottom
        addTravellerDropDown.backgroundColor = .WhiteColor
        addTravellerDropDown.anchorView = self.selectTravellerView
        addTravellerDropDown.cellHeight = 40
        addTravellerDropDown.textColor = .TitleColor
        addTravellerDropDown.backgroundColor = .WhiteColor
        addTravellerDropDown.bottomOffset = CGPoint(x: 0, y: selectTravellerView.frame.size.height + 5)
        addTravellerDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.additionalTravelerslbl.text = "\(item)"
            if item == "Select" {
                self?.additionalTravelerslbl.textColor = .SubtitleColor
            }else {
                self?.additionalTravelerslbl.textColor = .TitleColor
            }
            
            MySingleton.shared.insurencePaxCount = item
            self?.delegate?.didTapOnAddAdditionalTravellerBtnAction(cell: self!)
            
        }
    }
    
    
}




extension InsurenceSearchTVCell {
    
    
    //MARK: - showCheckInDatePicker showCheckoutDatePicker
    func showCheckInDatePicker(){
        //Formate Date
        checkinDatePicker.datePickerMode = .date
        checkinDatePicker.minimumDate = Date()
        checkinDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let checkindate = formter.date(from: checkinlbl.text ?? "") {
            checkinDatePicker.date = checkindate
            
            if self.checkoutlbl.text == "Select Date" {
                checkoutDatePicker.date = checkindate
            }
            
            // Check if checkout date is smaller than checkin date
            if let checkoutDate = formter.date(from: self.checkoutlbl.text ?? ""),
               checkoutDate < checkindate {
                checkoutDatePicker.date = checkindate
                
                // Also update the label to reflect the change
                self.checkoutlbl.text = formter.string(from: checkindate)
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.checkinTF.inputAccessoryView = toolbar
        self.checkinTF.inputView = checkinDatePicker
        
    }
    
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        // Get the selected check-in date
        let checkInDate = self.checkinDatePicker.date
        checkinlbl.text = formatter.string(from: checkInDate)
        
        // Check if a trip duration is selected
        guard let selectedTripDurationString = multiTripslbl.text else {
            // If no trip duration is selected, just return
            delegate?.donedatePicker(cell:self)
            return
        }
        
        // Parse the selected trip duration string to get the number of days
        let selectedTripDurationComponents = selectedTripDurationString.components(separatedBy: " ")
        guard selectedTripDurationComponents.count >= 1,
              let numberOfDays = Int(selectedTripDurationComponents[0]) else {
            // If unable to parse trip duration, just return
            delegate?.donedatePicker(cell:self)
            return
        }
        
        // Calculate the checkout date based on selected trip duration
        let calendar = Calendar.current
        if let checkoutDate = calendar.date(byAdding: .day, value: numberOfDays, to: checkInDate) {
            self.checkoutlbl.text = formatter.string(from: checkoutDate)
        }
        
        
        
        MySingleton.shared.insurenceDepDate = checkinlbl.text ?? ""
        MySingleton.shared.insurenceArrivalDate = checkoutlbl.text ?? ""
        
        delegate?.donedatePicker(cell:self)
    }
    
    
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}

