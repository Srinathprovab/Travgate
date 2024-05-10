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
    func didTapOnSelectCountryCodeList(cell:HotelSearchTVCell)
    func didTapOnHotelSearchBtnAction(cell:HotelSearchTVCell)
}


class HotelSearchTVCell: TableViewCell, HotelCitySearchViewModelDelegate {
    
    @IBOutlet weak var cancellationCheckBoxImg: UIImageView!
    @IBOutlet weak var fromcityTF: UITextField!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var checkinTF: UITextField!
    @IBOutlet weak var checkoutTF: UITextField!
    @IBOutlet weak var fromcityTV: UITableView!
    @IBOutlet weak var fromcityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var roomcountlbl: UILabel!
    @IBOutlet weak var nationalitylbl: UILabel!
    @IBOutlet weak var nationalitylTF: UITextField!
    @IBOutlet weak var ratingCV: UICollectionView!
    
    
    var cancellationCheckBoxBool = false
    var starTitelArray = ["1","2","3","4","5"]
    var ndropDown = DropDown()
    var txtbool = Bool()
    var hotelList = [HotelCityListModel]()
    var cityViewModel: HotelCitySearchViewModel?
    var payload = [String:Any]()
    var cityList:[SelectCityModel] = []
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    
    let checkinDatePicker = UIDatePicker()
    let checkoutDatePicker = UIDatePicker()
    
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    
    var cityNameArray = [String]()
    var clist = [All_country_code_list]()
    var cname = [String]()
    var countryCode = String()
    var cnameArray = [String]()
    
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
        fromcityTF.font = .OpenSansMedium(size: 16)
        fromcityTF.delegate = self
        fromcityTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromcityTF.isHidden = false
        fromcityTF.setLeftPaddingPoints(15)
        
        
        
        nationalitylTF.textColor = .AppLabelColor
        nationalitylTF.font = .OpenSansRegular(size: 14)
        nationalitylTF.delegate = self
        nationalitylTF.addTarget(self, action: #selector(searchTextBegin(_:)), for: .editingDidBegin)
        nationalitylTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        nationalitylTF.isHidden = false
        nationalitylTF.setLeftPaddingPoints(15)
        
        if startRatingArray.count == 0 {
            hotelfiltermodel.starRatingNew = starRatingInputArray
            startRatingArray = starRatingInputArray
        }else {
            hotelfiltermodel.starRatingNew = startRatingArray
        }
        
        setupCV()
    }
    
    
    
    
    override func updateUI() {
        
        
        fromcityTF.text = defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/Location"
        checkinlbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Add Date"
        checkoutlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Add Date"
        roomcountlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "")"
        nationalitylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.hnationality) ?? "Select Nationality")"
        
        fromcityTV.delegate = self
        fromcityTV.dataSource = self
        fromcityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        showCheckInDatePicker()
        showCheckoutDatePicker()
        
        setupnationalityDropDown()
        
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
    
    @IBAction func didTapOnFreeCancelationBtnAction(_ sender: Any) {
        cancellationCheckBoxBool.toggle()
        if cancellationCheckBoxBool {
            cancellationCheckBoxImg.image = UIImage(named: "check")
        }else {
            cancellationCheckBoxImg.image = UIImage(named: "huncheck")
        }
    }
    
    
    @IBAction func didTapOnHotelSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnHotelSearchBtnAction(cell: self)
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
            
            if self.checkoutlbl.text == "Add Date" {
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
        
        
        //        if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
        //            checkoutDatePicker.date = checkoutDate
        //
        //
        //        }
        
        
        if let checkindate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") {
            
            if self.checkoutlbl.text == "Add Date" {
                checkoutDatePicker.date = checkindate
                
            }else {
                if let checkoutdate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                    checkoutDatePicker.date = checkoutdate
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



//MARK: Saerch Natinality
extension HotelSearchTVCell {
    
    @objc func searchTextBegin(_ textField:UITextField)  {
        if textField == nationalitylTF {
            nationalitylbl.text = ""
            nationalitylTF.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = MySingleton.shared.clist
            loadCountryNamesAndCode()
            ndropDown.show()
        }
        
    }
    
    
    @objc func searchTextChanged(_ textField:UITextField)  {
        if textField == nationalitylTF {
            searchText = textField.text ?? ""
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
        }
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.clist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        ndropDown.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            ndropDown.dataSource = countryNames
        }
    }
    
    func setupnationalityDropDown() {
        
        ndropDown.direction = .bottom
        ndropDown.cellHeight = 50
        ndropDown.backgroundColor = .WhiteColor
        ndropDown.anchorView = self.nationalitylTF
        ndropDown.bottomOffset = CGPoint(x: 0, y: nationalitylTF.frame.size.height + 10)
        ndropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(item)
            self?.nationalitylbl.text = self?.countryNames[index] ?? ""
            self?.countryCode = self?.isocountrycodeArray[index] ?? ""
            self?.nationalitylTF.text = ""
            self?.nationalitylTF.resignFirstResponder()
            defaults.set(self?.countryNames[index] ?? "", forKey: UserDefaultsKeys.hnationality)
            defaults.set(self?.isocountrycodeArray[index] ?? "", forKey: UserDefaultsKeys.hnationalitycode)
            self?.delegate?.didTapOnSelectCountryCodeList(cell: self!)
        }
    }
    
}



//MARK: select star
extension HotelSearchTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func setupCV() {
        
        
        let nib = UINib(nibName: "RatingCVCell", bundle: nil)
        ratingCV.register(nib, forCellWithReuseIdentifier: "cell")
        ratingCV.delegate = self
        ratingCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        ratingCV.collectionViewLayout = layout
        ratingCV.bounces = false
        ratingCV.isScrollEnabled = false
        ratingCV.allowsMultipleSelection = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starTitelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RatingCVCell {
            
            cell.titlelbl.text = starTitelArray[indexPath.row]
            
            
            if hotelfiltermodel.starRatingNew.contains(cell.titlelbl.text ?? "") {
                
                DispatchQueue.main.async {
                    cell.holderView.backgroundColor = UIColor.Buttoncolor
                    cell.titlelbl.textColor = .WhiteColor
                    cell.starimg.tintColor = .WhiteColor
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                }
                
            } else {
                
                DispatchQueue.main.async {
                    cell.holderView.backgroundColor = UIColor.WhiteColor
                    cell.titlelbl.textColor = .TitleColor
                    cell.starimg.tintColor = .black
                }
                
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RatingCVCell {
            cell.titlelbl.textColor = .WhiteColor
            cell.holderView.backgroundColor = .Buttoncolor
            cell.starimg.tintColor = .WhiteColor
            
            starRatingInputArray.append(cell.titlelbl.text ?? "")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RatingCVCell {
            cell.titlelbl.textColor = .TitleColor
            cell.holderView.backgroundColor = .WhiteColor
            cell.starimg.tintColor = .TitleColor
            
            if let index = starRatingInputArray.firstIndex(of: cell.titlelbl.text ?? "") {
                starRatingInputArray.remove(at: index)
            }
        }
    }
    
    
}
