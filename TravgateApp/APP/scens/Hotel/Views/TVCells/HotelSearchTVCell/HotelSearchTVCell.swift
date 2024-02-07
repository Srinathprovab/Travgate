//
//  HotelSearchTVCell.swift
//  TravgateApp
//
//  Created by FCI on 17/01/24.
//

import UIKit
import DropDown

protocol HotelSearchTVCellDelegate {
    func donedatePicker(cell:HotelSearchTVCell)
    func cancelDatePicker(cell:HotelSearchTVCell)
    func didTapOnAddRoomsBtnAction(cell:HotelSearchTVCell)
    func didTapOnSelectNationlatiyBtnAction(cell:HotelSearchTVCell)
    func didTapOnSelectNoofNightsBtnAction(cell:HotelSearchTVCell)
}


class HotelSearchTVCell: TableViewCell, HotelCitySearchViewModelDelegate {
    
    
    @IBOutlet weak var fromcityTF: UITextField!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var checkinTF: UITextField!
    @IBOutlet weak var checkoutTF: UITextField!
    @IBOutlet weak var fromcityTV: UITableView!
    @IBOutlet weak var fromcityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var roomcountlbl: UILabel!
    @IBOutlet weak var nationalitylbl: UILabel!
    
    
    
    
    var txtbool = Bool()
    var hotelList = [HotelCityListModel]()
    var cityViewModel: HotelCitySearchViewModel?
    var payload = [String:Any]()
    var cityList:[SelectCityModel] = []
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    
    let checkinDatePicker = UIDatePicker()
    let checkoutDatePicker = UIDatePicker()
    
    var delegate: HotelSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        cityViewModel = HotelCitySearchViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        fromcityTF.textColor = .AppLabelColor
        fromcityTF.font = .OpenSansRegular(size: 14)
        fromcityTF.delegate = self
        fromcityTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromcityTF.isHidden = false
        fromcityTF.setLeftPaddingPoints(15)
        
        
       
    }
    
    
    override func updateUI() {
        
        
        fromcityTF.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/Location"
        checkinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Add Date"
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Add Date"
        roomcountlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") Adults , \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1") Rooms"
        nationalitylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.hnationality) ?? "Nationality")"
        
        fromcityTV.delegate = self
        fromcityTV.dataSource = self
        fromcityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        showCheckInDatePicker()
        showCheckoutDatePicker()
        
    }
    
    
    func updateHeight(height:Int) {
        fromcityTVHeight.constant = CGFloat(hotelList.count * height)
        
        DispatchQueue.main.async {[self] in
            fromcityTV.reloadData()
        }
    }
    
    
    @IBAction func didTapOnClearCityTFBtnAction(_ sender: Any) {
        
        fromcityTF.text = ""
        fromcityTF.placeholder = "City / Location"
        fromcityTF.becomeFirstResponder()
        updateHeight(height: 0)
    }
    
    
    @IBAction func didTapOnAddRoomsBtnAction(_ sender: Any) {
        delegate?.didTapOnAddRoomsBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSelectNationlatiyBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectNationlatiyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSelectNoofNightsBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectNoofNightsBtnAction(cell: self)
    }
    
    
}






extension HotelSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = hotelList[indexPath.row].value
            cell.subTitlelbl.text = hotelList[indexPath.row].label
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            
            fromcityTF.text = hotelList[indexPath.row].value ?? ""
            fromcityTF.textColor = .AppLabelColor
            
            defaults.set(hotelList[indexPath.row].value ?? "", forKey: UserDefaultsKeys.locationcity)
            defaults.set(hotelList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.locationid)
            
            
            updateHeight(height: 0)
        }
    }
    
    
}


extension HotelSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showCheckInDatePicker(){
        //Formate Date
        checkinDatePicker.datePickerMode = .date
        checkinDatePicker.minimumDate = Date()
        checkinDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let checkindate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") {
            checkinDatePicker.date = checkindate
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
    
    
    
    
    
    
    //MARK: - showretDatePicker
    func showCheckoutDatePicker(){
        //Formate Date
        checkoutDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.checkinTF.isFirstResponder ? checkinDatePicker.date : checkoutDatePicker.date
        checkoutDatePicker.minimumDate = selectedDate
        
        checkoutDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
            checkoutDatePicker.date = checkoutDate
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.checkoutTF.inputAccessoryView = toolbar
        self.checkoutTF.inputView = checkoutDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}


extension HotelSearchTVCell {
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField.text?.isEmpty == true {
            
        }else {
            
            CallShowCityListAPI(str: textField.text ?? "")
           
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        fromcityTF.text = ""
        CallShowCityListAPI(str: textField.text ?? "")
    }
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallHotelCitySearchAPI(dictParam: payload)
    }
    
    
    func hotelCitySearchResult(response: [HotelCityListModel]) {
        
        hotelList = response
        print(hotelList)
        
        
        fromcityTVHeight.constant = CGFloat(hotelList.count * 80)
        
        DispatchQueue.main.async {[self] in
            fromcityTV.reloadData()
        }
        
    }
    
    
}




