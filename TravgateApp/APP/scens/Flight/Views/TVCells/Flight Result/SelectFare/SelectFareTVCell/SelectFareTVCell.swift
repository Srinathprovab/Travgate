//
//  SelectFareTVCell.swift
//  Travgate
//
//  Created by FCI on 22/04/24.
//

import UIKit

struct SelectFare {
    let fareName: String?
    let cabinClass: String?
    let RefundableType: String?
    let Baggage: String?
    let Price: String?
    let amount: Double?
    let selectedBool:Bool?
    let journyType:String?
}


protocol SelectFareTVCellDelegate {
    func didTapOnSelectFareBtnAction(cell:SelectFareInfoTVCell, at indexPath: IndexPath)
    func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell, at indexPath: IndexPath)
    func didTapOnDepartureBtnAction(cell:SelectFareTVCell)
}

class SelectFareTVCell: TableViewCell, SelectFareInfoTVCellDelegate {
    
    
    @IBOutlet weak var depBtn: UIButton!
    @IBOutlet weak var retBtn: UIButton!
    @IBOutlet weak var selectdeplbl: UILabel!
    @IBOutlet weak var selectFareTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
  
    var key = String()
    var selectedFareType: String = "departure"
    
    var showFareSelectedBool = false
    var delegate:SelectFareTVCellDelegate?
    var selectedDepartureIndex: IndexPath?
    var selectedReturnIndex: IndexPath?
    var depSelectedFares: [SelectFare] = []
    var retSelectedFares: [SelectFare] = []
    
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
        
        setupTV()
    }
    
    override func updateUI() {
        
        setupBtn(btn: depBtn, title1: "Kuwait-Cairo")
        setupBtn(btn: retBtn, title1: "Cairo-Kuwait")
        key = cellInfo?.title ?? ""
        
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            retBtn.isHidden = true
        }else {
            retBtn.isHidden = false
        }
        
        if key == "selected" {
            updateHeight(count: MySingleton.shared.selectedFares.count)
        }else {
           
            if btnTapString == "departure" {
                tapOnDep()
            }else {
                taponReturn()
            }
            
        }
        
        
    }
    
    
    
    
    
    func updateHeight(count:Int) {
        tvHeight.constant = CGFloat(180 * count)
        selectFareTV.reloadData()
    }
    
    
    func setupBtn(btn:UIButton,title1:String) {
        btn.setTitle(title1, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        tapOnDep()
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    func tapOnDep() {
        
        depBtn.backgroundColor = UIColor.Buttoncolor
        depBtn.setTitleColor(.WhiteColor, for: .normal)
        retBtn.backgroundColor = UIColor.WhiteColor
        retBtn.setTitleColor(.TitleColor, for: .normal)
        
        selectdeplbl.text = "Select Fare for departure"
        btnTapString = "return"
        updateHeight(count: MySingleton.shared.fareFlightlistArray.count)
        
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        taponReturn()
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    func taponReturn() {
        
        depBtn.backgroundColor = UIColor.WhiteColor
        depBtn.setTitleColor(.TitleColor, for: .normal)
        retBtn.backgroundColor = UIColor.Buttoncolor
        retBtn.setTitleColor(.WhiteColor, for: .normal)
        
        selectdeplbl.text = "Select Fare for Return"
        btnTapString = "departure"
        updateHeight(count: MySingleton.shared.fareReturnFlightlistArray.count)
        
    }
    
    
    
    func didTapOnCloseFareBtnAction(cell: SelectFareInfoTVCell) {
        delegate?.didTapOnCloseFareBtnAction(cell: cell, at: indexPath!)
    }
    
    
    
    // Delegate method called when select button is tapped
    func didTapOnSelectFareBtnAction(cell: SelectFareInfoTVCell) {
        guard let indexPath = selectFareTV.indexPath(for: cell) else { return }
        delegate?.didTapOnSelectFareBtnAction(cell: cell, at: indexPath)
    }
    
    
}



extension SelectFareTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        selectFareTV.register(UINib(nibName: "SelectFareInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        selectFareTV.register(UINib(nibName: "SelectFareInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        
        selectFareTV.delegate = self
        selectFareTV.dataSource = self
        selectFareTV.tableFooterView = UIView()
        selectFareTV.showsHorizontalScrollIndicator = false
        selectFareTV.separatorStyle = .singleLine
        selectFareTV.isScrollEnabled = false
        selectFareTV.separatorStyle = .none
        selectFareTV.allowsMultipleSelection = false
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if key == "selected" {
            return MySingleton.shared.selectedFares.count
        }else {
            
            if btnTapString == "departure" {
                return MySingleton.shared.fareFlightlistArray.count
            }else {
                return MySingleton.shared.fareReturnFlightlistArray.count
            }
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        
        if key == "selected" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectFareInfoTVCell {
                
                cell.selectionStyle = .none
                cell.delegate = self
                cell.journyType = btnTapString
                
                let data = MySingleton.shared.selectedFares[indexPath.row]
                cell.fareNamelbl.text = data.fareName
                cell.classlbl.text = data.cabinClass
                cell.refundTypelbl.text = data.RefundableType
                cell.baggagelbl.text = data.Baggage
                cell.pricelbl.text = data.Price
                cell.journyType = data.journyType ?? ""
                cell.fareamount = data.amount ?? 0.0
                cell.configure(selected: true)
                
                if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType),jtype == "circle"{
                    
                    if MySingleton.shared.selectedFares.count == 2 {
                        
                        self.depBtn.isUserInteractionEnabled = false
                        self.retBtn.isUserInteractionEnabled = false
                        
                        if tableView.isLast(for: indexPath) {
                            cell.journytypecloaselbl.text = "Return"
                        }
                    }else {
                        self.depBtn.isUserInteractionEnabled = true
                        self.retBtn.isUserInteractionEnabled = true
                    }
                    
                }
                
                c = cell
                
            }
            
        }else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? SelectFareInfoTVCell {
                
                cell.selectionStyle = .none
                cell.delegate = self
                cell.journyType = btnTapString
                cell.configure(selected: false)
                
                if btnTapString == "departure" {
                    
                    let data = MySingleton.shared.fareFlightlistArray[indexPath.row]
                    cell.fareNamelbl.text = "Extra"
                    cell.classlbl.text = data.productClass
                    cell.baggagelbl.text = "Carry-on (1-7kg) Checked in (30Kg)"
                    cell.pricelbl.text = "\(data.price?.api_currency ?? "") \(data.price?.api_total_display_fare ?? 0.0)"
                    cell.refundTypelbl.text = "Pay to Cancel upto 24 hours prior to departure"
                    cell.fareamount = data.price?.api_total_display_fare ?? 0.0
                    
                    
                    if selectedDepartureIndex == indexPath {
                        cell.selectBtn.isHidden = true
                        cell.closeView.isHidden = false
                        cell.holderView.borderColor = UIColor.Buttoncolor
                        cell.holderView.backgroundColor = .LayoverColor
                    }else {
                        cell.selectBtn.isHidden = false
                        cell.closeView.isHidden = true
                        cell.holderView.borderColor = UIColor.BorderColor
                        cell.holderView.backgroundColor = .WhiteColor
                    }
                    
                    
                }else {
                    let data = MySingleton.shared.fareReturnFlightlistArray[indexPath.row]
                    cell.fareNamelbl.text = "Extra"
                    cell.classlbl.text = data.productClass
                    cell.baggagelbl.text = "Carry-on (\(data.carryOnBaggage ?? "") Checked in (\(data.checkedBaggage ?? ""))"
                    cell.pricelbl.text = "\(data.price?.api_currency ?? "") \(data.price?.api_total_display_fare ?? 0.0)"
                    cell.refundTypelbl.text = "Pay to Cancel upto 24 hours prior to departure"
                    cell.fareamount = data.price?.api_total_display_fare ?? 0.0
                    
                    
                    if selectedReturnIndex == indexPath {
                        cell.selectBtn.isHidden = true
                        cell.closeView.isHidden = false
                        cell.holderView.borderColor = UIColor.Buttoncolor
                        cell.holderView.backgroundColor = .LayoverColor
                    }else {
                        cell.selectBtn.isHidden = false
                        cell.closeView.isHidden = true
                        cell.holderView.borderColor = UIColor.BorderColor
                        cell.holderView.backgroundColor = .WhiteColor
                    }
                    
                    
                }
                
                cell.selectBtn.isHidden = true
                cell.closeView.isHidden = true
                
                
                
                c = cell
                
            }
            
        }
        
        
        
        return c
    }
    
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SelectFareInfoTVCell else {
            return
        }
        
        
        // Clear the selected fares before appending the new selection
        
        
        
        // Create a SelectFare instance
        let fare = SelectFare(fareName: cell.fareNamelbl.text,
                              cabinClass: cell.classlbl.text,
                              RefundableType: cell.refundTypelbl.text,
                              Baggage: cell.baggagelbl.text,
                              Price: cell.pricelbl.text, 
                              amount: cell.fareamount,
                              selectedBool: true,
                              journyType: cell.journyType)
        
        
        MySingleton.shared.totalselectedfareprice = 0.0
        
        // Check which button was tapped
        if btnTapString == "departure" {
            // Ensure only one card is selected for departure
            if let previousDepartureIndex = selectedDepartureIndex {
                // Deselect the previously selected departure cell
                tableView.deselectRow(at: previousDepartureIndex, animated: true)
                
               
            }
            selectedDepartureIndex = indexPath
            
            MySingleton.shared.totalselectedDepfareprice = 0.0
            MySingleton.shared.totalselectedDepfareprice = cell.fareamount
            depSelectedFares.removeAll()
            depSelectedFares.append(fare)
            
            
        }
        
        if btnTapString == "return" {
            // Ensure only one card is selected for return
            if let previousReturnIndex = selectedReturnIndex {
                // Deselect the previously selected return cell
                tableView.deselectRow(at: previousReturnIndex, animated: true)
            }
            selectedReturnIndex = indexPath
            
            MySingleton.shared.totalselectedRetfareprice = 0.0
            MySingleton.shared.totalselectedRetfareprice = cell.fareamount
            
            retSelectedFares.removeAll()
            retSelectedFares.append(fare)
            
            
            
        }
        
        // Reload data to reflect the selection changes
        tableView.reloadData()
        
       
        
        if let jtype = defaults.string(forKey: UserDefaultsKeys.journeyType), jtype == "oneway" {
            
            MySingleton.shared.selectedFares.removeAll()
            MySingleton.shared.selectedFares.append(contentsOf: depSelectedFares)
            
            
            MySingleton.shared.totalselectedfareprice = MySingleton.shared.totalselectedDepfareprice 
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                delegate?.didTapOnSelectFareBtnAction(cell: cell, at: indexPath)
            }
            
        }else {
            // Check if both departure and return selections are made
            if let departureIndex = selectedDepartureIndex, let returnIndex = selectedReturnIndex {
                // Perform necessary actions with departureIndex and returnIndex
                print("Departure Index: \(departureIndex.row), Return Index: \(returnIndex.row)")
                // Call delegate method
                
                MySingleton.shared.selectedFares.removeAll()
                MySingleton.shared.selectedFares.append(contentsOf: depSelectedFares)
                MySingleton.shared.selectedFares.append(contentsOf: retSelectedFares)
                
                MySingleton.shared.totalselectedfareprice = MySingleton.shared.totalselectedDepfareprice + MySingleton.shared.totalselectedRetfareprice
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                    delegate?.didTapOnSelectFareBtnAction(cell: cell, at: indexPath)
                }
                
            }
        }
       
        
        
    }
    
}
