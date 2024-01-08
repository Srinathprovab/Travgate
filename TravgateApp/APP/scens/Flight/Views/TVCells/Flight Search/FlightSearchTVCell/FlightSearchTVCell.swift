//
//  FlightSearchTVCell.swift
//  TravgateApp
//
//  Created by FCI on 03/01/24.
//

import UIKit
import DropDown

protocol FlightSearchTVCellDelegate {
    func didTapOnAdvanceOption(cell:FlightSearchTVCell)
    func didTapOnClassBtnAction(cell:FlightSearchTVCell)
    func didTapOnSwipeCityBtnAction(cell: FlightSearchTVCell)
    func donedatePicker(cell:FlightSearchTVCell)
    func cancelDatePicker(cell:FlightSearchTVCell)
    func didTapOnHideReturnDateBtnAction(cell:FlightSearchTVCell)
    func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell)
    func didTapOnReturnDateBtnAction(cell:FlightSearchTVCell)
}

class FlightSearchTVCell: TableViewCell, SelectCityViewModelProtocal {
    
    
    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var advanceSearchlbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoCV: UICollectionView!
    
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var onewayclassView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var roundtripclasslbl: UILabel!
    @IBOutlet weak var roundtripclassView: UIView!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var returnDateView: BorderedView!
    @IBOutlet weak var retlbl: UILabel!
    @IBOutlet weak var retTF: UITextField!
    @IBOutlet weak var adultDecBtn: UIButton!
    @IBOutlet weak var adultCountlbl: UILabel!
    @IBOutlet weak var adultIncBtn: UIButton!
    @IBOutlet weak var childDecBtn: UIButton!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var childIncBtn: UIButton!
    @IBOutlet weak var infantDecBtn: UIButton!
    @IBOutlet weak var infantCountlbl: UILabel!
    @IBOutlet weak var infantIncBtn: UIButton!
    @IBOutlet weak var fromtv: UITableView!
    @IBOutlet weak var fromtvHeight: NSLayoutConstraint!
    @IBOutlet weak var totv: UITableView!
    @IBOutlet weak var totvHeight: NSLayoutConstraint!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var directFlightCheckImg: UIImageView!
    @IBOutlet weak var hideRoundTripBtn: UIButton!
    @IBOutlet weak var outwardTimeView: BorderedView!
    @IBOutlet weak var outwardTimelbl: UILabel!
    @IBOutlet weak var returnTimeView: BorderedView!
    @IBOutlet weak var returnTimelbl: UILabel!
    @IBOutlet weak var airlineView: BorderedView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineTF: UITextField!
    @IBOutlet weak var returnDateBtn: UIButton!
    @IBOutlet weak var additionalView: UIView!
    @IBOutlet weak var selectadditionallbl: UILabel!
    
    
    
    var timeArray = ["12:00 AM - 06:00 AM","06:00 AM - 12:00 PM","12:00 PM - 12:00 PM","06:00 PM - 12:00 AM"]
    var selectClassArray = ["Economy","Premium","First","Business"]
    var infoimgArray = ["in1","in2","in3","in4","in5","in6"]
    var infoArray = ["Add Baggage","Meal","Add Insurance","Add Special assistance","Add Seat","Add airport Transfers"]
    var delegate:FlightSearchTVCellDelegate?
    var infoViewbool = false
    let onewayclassDropdown = DropDown()
    let roundtripclassDropdown = DropDown()
    let outwardtimeDropdown = DropDown()
    let returntimeDropdown = DropDown()
    let airlinetimeDropdown = DropDown()
    
    var cityViewModel: SelectCityViewModel?
    var payload = [String:Any]()
    var cityList:[SelectCityModel] = []
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var txtbool = Bool()
    
    let depDatePicker = UIDatePicker()
    let retdepDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var isSearchBool = Bool()
    var searchText = String()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
        cityViewModel = SelectCityViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        setAttributedString(str1: "    Advanced search options")
        setAttributedString1(str1: "    Select Aditional options")
        setupinfoCV()
        
        fromTF.tag = 1
        fromTF.textColor = .TitleColor
        fromTF.font = .OpenSansMedium(size: 16)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(0)
        
        toTF.tag = 2
        toTF.textColor = .TitleColor
        toTF.font = .OpenSansMedium(size: 16)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTF.setLeftPaddingPoints(0)
        
        //        fromlbl.isHidden = true
        //        tolbl.isHidden = true
        
        adultIncBtn.addTarget(self, action: #selector(didTapOnAdultIncrementBtnAction(_:)), for: .touchUpInside)
        adultDecBtn.addTarget(self, action: #selector(didTapOnAdultDecrementBtnAction(_:)), for: .touchUpInside)
        childIncBtn.addTarget(self, action: #selector(didTapOnChildIncrementBtnAction(_:)), for: .touchUpInside)
        childDecBtn.addTarget(self, action: #selector(didTapOnChildDecrementBtnAction(_:)), for: .touchUpInside)
        infantIncBtn.addTarget(self, action: #selector(didTapOnInfantIncrementBtnAction(_:)), for: .touchUpInside)
        infantDecBtn.addTarget(self, action: #selector(didTapOnInfantDecrementBtnAction(_:)), for: .touchUpInside)
        
        
        setupOnewayClassDropDown()
        setupRoundTripClassDropDown()
        setupOutwardTimeDropDown()
        setupReturnTimeDropDown()
        setupAirlineDropDown()
        
        airlineTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        airlineTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
    }
    
    override func updateUI() {
        
        MySingleton.shared.getCountryList()
        
        setupTV()
        fromtvHeight.constant = 0
        totvHeight.constant = 0
        CallShowCityListAPI(str: "")
        
        adultCountlbl.text = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "0"
        childCountlbl.text = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        infantCountlbl.text = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        
        MySingleton.shared.adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") ?? 0
        MySingleton.shared.childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") ?? 0
        MySingleton.shared.infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") ?? 0
        
        
        
        if cellInfo?.key == "oneway" {
            hideRoundTripBtn.isUserInteractionEnabled = false
            roundtripclassView.isHidden = true
            classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
            
            fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
            tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
            
            self.depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
            returnDateView.alpha = 0.5
            retlbl.text = "Add Date"
            defaults.set("Add Date", forKey: UserDefaultsKeys.calRetDate)
            self.depTF.isHidden = false
            self.retTF.isHidden = true
            showdepDatePicker()
            
            returnDateBtn.isHidden = false
            
        }else {
            hideRoundTripBtn.isUserInteractionEnabled = true
            roundtripclassView.isHidden = false
            classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
            roundtripclasslbl.text = defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy"
            
            fromlbl.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
            tolbl.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
            
            self.depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
            self.retlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Add Date"
            returnDateView.alpha = 1
            self.depTF.isHidden = false
            self.retTF.isHidden = false
            showreturndepDatePicker()
            showretDatePicker()
            
            returnDateBtn.isHidden = true
        }
        

    }
    

    
    
    @IBAction func didTapOnOnewayClassBtnAction(_ sender: Any) {
        onewayclassDropdown.show()
    }
    
    @IBAction func didTapOnRoundTripClassBtnAction(_ sender: Any) {
        roundtripclassDropdown.show()
    }
    
    
    
    @IBAction func didTapOnDirectFlightCheckBtnAction(_ sender: Any) {
        MySingleton.shared.directFlightBool.toggle()
        if MySingleton.shared.directFlightBool {
            directFlightCheckImg.image = UIImage(named: "uncheck")
        }else {
            directFlightCheckImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
        }
    }
    
    
    @IBAction func didTaponSwapCitysBtnAction(_ sender: Any) {
        
        let a = fromlbl.text
        let b = tolbl.text
        
        fromlbl.text = b
        tolbl.text = a
        
        defaults.set(fromlbl.text, forKey: UserDefaultsKeys.fromcityname)
        defaults.set(tolbl.text, forKey: UserDefaultsKeys.tocityname)
        
    }
    
    @IBAction func didTapOnFlightSearchBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightSearchBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnHideReturnDateBtnAction(_ sender: Any) {
        delegate?.didTapOnHideReturnDateBtnAction(cell: self)
    }
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField == fromTF {
            txtbool = true
            if textField.text?.isEmpty == true {
                dropDown.hide()
            }else {
                self.fromlbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                dropDown.show()
            }
        }else {
            txtbool = false
            if textField.text?.isEmpty == true {
                dropDown1.hide()
            }else {
                self.tolbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                dropDown1.show()
            }
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTF {
            fromTF.placeholder = "Origin"
            self.fromlbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown.show()
            
        }else {
            toTF.placeholder = "Destination"
            self.tolbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown1.show()
            
        }
    }
    
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        print(cityList)
        if txtbool == true {
            fromtvHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromtv.reloadData()
            }
        }else {
            totvHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                totv.reloadData()
            }
        }
        
    }
    
    
    
    @IBAction func didTapOnOutwardTimeBtnAction(_ sender: Any) {
        outwardtimeDropdown.show()
    }
    
    @IBAction func didTapOnReturnTimeBtnAction(_ sender: Any) {
        returntimeDropdown.show()
    }
    
    @IBAction func didTapOnAirlineTimeBtnAction(_ sender: Any) {
        airlinetimeDropdown.show()
    }
    
    
    
    @IBAction func didTapOnReturnDateBtnAction(_ sender: Any) {
        delegate?.didTapOnReturnDateBtnAction(cell: self)
    }
    
    
}


extension FlightSearchTVCell {
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.InterMedium(size: 14),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        advanceSearchlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        advanceSearchlbl.addGestureRecognizer(tapGesture)
        advanceSearchlbl.isUserInteractionEnabled = true
        
        
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Advanced search options", in: advanceSearchlbl) {
            infoViewbool.toggle()
            if infoViewbool {
                infoView.isHidden = false
            }else {
                infoView.isHidden = true
            }
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }
    }
    
    
    
    func setAttributedString1(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.TitleColor,
                                                      NSAttributedString.Key.font:UIFont.InterMedium(size: 14),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        selectadditionallbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped1))
        selectadditionallbl.addGestureRecognizer(tapGesture)
        selectadditionallbl.isUserInteractionEnabled = true
        
        
    }
    
    @objc func labelTapped1(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Select Aditional options", in: selectadditionallbl) {
            infoViewbool.toggle()
            if infoViewbool {
                additionalView.isHidden = false
            }else {
                additionalView.isHidden = true
            }
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }
    }
    
    
}



extension FlightSearchTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func setupinfoCV() {
        
        let nib = UINib(nibName: "InfoCVCell", bundle: nil)
        infoCV.register(nib, forCellWithReuseIdentifier: "cell1")
        infoCV.delegate = self
        infoCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 50)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        infoCV.collectionViewLayout = layout
        infoCV.isScrollEnabled = false
        infoCV.allowsMultipleSelection = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? InfoCVCell {
            
            cell.titlelbl.text = infoArray[indexPath.row]
            cell.img.image = UIImage(named: infoimgArray[indexPath.row])
            //            cell.img.sd_setImage(with: URL(string:  offerlist[indexPath.row].topDealImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "check")
            MySingleton.shared.infoArray.append(cell.titlelbl.text ?? "")
            
            print(MySingleton.shared.infoArray.joined(separator: ","))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            
            if let index =  MySingleton.shared.infoArray.firstIndex(of: cell.titlelbl.text ?? "") {
                MySingleton.shared.infoArray.remove(at: index)
            }
            
            print(MySingleton.shared.infoArray.joined(separator: ","))
        }
    }
    
}


extension FlightSearchTVCell {
    
    func setupOnewayClassDropDown() {
        onewayclassDropdown.dataSource = selectClassArray
        onewayclassDropdown.direction = .bottom
        onewayclassDropdown.backgroundColor = .WhiteColor
        onewayclassDropdown.anchorView = self.onewayclassView
        onewayclassDropdown.bottomOffset = CGPoint(x: 0, y: onewayclassView.frame.size.height + 10)
        onewayclassDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.classlbl.text = item
            defaults.set(item, forKey: UserDefaultsKeys.selectClass)
            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    func setupRoundTripClassDropDown() {
        roundtripclassDropdown.dataSource = selectClassArray
        roundtripclassDropdown.direction = .bottom
        roundtripclassDropdown.backgroundColor = .WhiteColor
        roundtripclassDropdown.anchorView = self.roundtripclassView
        roundtripclassDropdown.bottomOffset = CGPoint(x: 0, y: roundtripclassView.frame.size.height + 10)
        roundtripclassDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.roundtripclasslbl.text = item
            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
}



extension FlightSearchTVCell:UITableViewDelegate, UITableViewDataSource {
    
    
    func setupTV() {
        fromtv.delegate = self
        fromtv.dataSource = self
        fromtv.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        totv.delegate = self
        totv.dataSource = self
        totv.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == fromtv {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            print(cell.id)
            print(cell.citycode)
            print(cell.cityname)
            
            if tableView == fromtv {
                fromlbl.text = "\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))"
                fromlbl.textColor = .TitleColor
                fromTF.text = ""
                fromTF.placeholder = ""
                fromTF.resignFirstResponder()
                if tolbl.text?.isEmpty == true {
                    toTF.placeholder = "Destination"
                }else {
                    toTF.placeholder = ""
                }
                
                //toTF.becomeFirstResponder()
                
                
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.fromCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                //         defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromcityname)
                
                defaults.set("\(cityList[indexPath.row].city ?? "")", forKey: UserDefaultsKeys.fcity)
                
                
                
                fromtvHeight.constant = 0
            }else {
                tolbl.text = "\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))"
                tolbl.textColor = .TitleColor
                toTF.text = ""
                toTF.placeholder = ""
                toTF.resignFirstResponder()
                
                
                defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.toCity)
                defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.tolocid)
                //     defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.tocityname)
                defaults.set("\(cityList[indexPath.row].city ?? "")", forKey: UserDefaultsKeys.tcity)
                
                
                totvHeight.constant = 0
            }
        }
    }
    
    
    
    
}





extension FlightSearchTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retlbl.text == "Select Date" {
                retdepDatePicker.date = calDepDate
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showreturndepDatePicker
    func showreturndepDatePicker(){
        //Formate Date
        retdepDatePicker.datePickerMode = .date
        retdepDatePicker.minimumDate = Date()
        retdepDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
            retdepDatePicker.date = rcalDepDate
            
            
            if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || self.retlbl.text == "Select Date" {
                retdepDatePicker.date = rcalDepDate
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = retdepDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depTF.isFirstResponder ? depDatePicker.date : retdepDatePicker.date
        retDatePicker.minimumDate = selectedDate
        
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if key == "hotel" {
            if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                retDatePicker.date = checkoutDate
            }
        }else {
            
            
            if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
                
                if self.retlbl.text == "Select Date" {
                    retDatePicker.date = calDepDate
                    
                }else {
                    if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "") {
                        retDatePicker.date = rcalRetDate
                    }
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
        
        self.retTF.inputAccessoryView = toolbar
        self.retTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}


extension FlightSearchTVCell {
    
    //MARK: - Adult
    @objc func didTapOnAdultIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.adultsCount += 1
            self.adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnAdultDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure child count doesn't go below 1
        if MySingleton.shared.adultsCount > 1 {
            MySingleton.shared.adultsCount -= 1
            adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
            
            MySingleton.shared.infantsCount = 0
            infantCountlbl.text = "0"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Child
    @objc func didTapOnChildIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults and children, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.childCount += 1
            self.childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnChildDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure adult count doesn't go below 1
        if MySingleton.shared.childCount >= 1 {
            MySingleton.shared.childCount -= 1
            childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Infant
    @objc func didTapOnInfantIncrementBtnAction(_ sender:UIButton) {
        
        // Increment infants based on the selected adult count, but don't exceed the selected adult count
        if MySingleton.shared.adultsCount > MySingleton.shared.infantsCount {
            MySingleton.shared.infantsCount += 1
            self.infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnInfantDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure infant count doesn't go below 1
        if MySingleton.shared.infantsCount >= 1 {
            MySingleton.shared.infantsCount -= 1
            infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    
    
    
    func updateTotalTravelerCount() {
        
        let totalTravelers = MySingleton.shared.adultsCount + MySingleton.shared.childCount + MySingleton.shared.infantsCount
        print("Total Count === \(totalTravelers)")
        
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
        defaults.set(MySingleton.shared.adultsCount, forKey: UserDefaultsKeys.adultCount)
        defaults.set(MySingleton.shared.childCount, forKey: UserDefaultsKeys.childCount)
        defaults.set(MySingleton.shared.infantsCount, forKey: UserDefaultsKeys.infantsCount)
        
    }
}



extension FlightSearchTVCell {
    
    
    func setupOutwardTimeDropDown() {
        outwardtimeDropdown.dataSource = timeArray
        outwardtimeDropdown.direction = .bottom
        outwardtimeDropdown.backgroundColor = .WhiteColor
        outwardtimeDropdown.anchorView = self.outwardTimeView
        outwardtimeDropdown.bottomOffset = CGPoint(x: 0, y: outwardTimeView.frame.size.height + 10)
        outwardtimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.outwardTimelbl.text = item
            //            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            //            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
    func setupReturnTimeDropDown() {
        returntimeDropdown.dataSource = timeArray
        returntimeDropdown.direction = .bottom
        returntimeDropdown.backgroundColor = .WhiteColor
        returntimeDropdown.anchorView = self.returnTimeView
        returntimeDropdown.bottomOffset = CGPoint(x: 0, y: returnTimeView.frame.size.height + 10)
        returntimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.returnTimelbl.text = item
            //            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            //            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
    func setupAirlineDropDown() {
        airlinetimeDropdown.dataSource = timeArray
        airlinetimeDropdown.direction = .bottom
        airlinetimeDropdown.backgroundColor = .WhiteColor
        airlinetimeDropdown.anchorView = self.airlineView
        airlinetimeDropdown.bottomOffset = CGPoint(x: 0, y: airlineView.frame.size.height + 10)
        airlinetimeDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.airlinelbl.text = item
            //            defaults.set(item, forKey: UserDefaultsKeys.rselectClass)
            //            self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
}


extension FlightSearchTVCell {
    
    @objc func searchTextBegin(textField: UITextField) {
        airlineTF.text = ""
        airlinelbl.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = MySingleton.shared.countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
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
            dropDown.dataSource = countryNames
        }
    }
}
