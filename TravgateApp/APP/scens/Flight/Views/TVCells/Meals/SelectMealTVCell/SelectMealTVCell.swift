//
//  SelectMealTVCell.swift
//  Travgate
//
//  Created by FCI on 18/04/24.
//

import UIKit
protocol SelectMealTVCellDelegate {
    func didTapOnCheckBoxBtnAction(cell:SelectMealTVCell)
}

class SelectMealTVCell: TableViewCell, AddMealToPassengerTVCellDelegate {
    
    
    @IBOutlet weak var mealTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var firstnameArray = [String]()
    var delegate:SelectMealTVCellDelegate?
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
        
        firstnameArray = travelerArray.compactMap({$0.firstName})
        updateHeight()
    }
    
    func updateHeight() {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType), journyType == "oneway" {
            tvHeight.constant = CGFloat((firstnameArray.count * 120))
        }else {
            tvHeight.constant = CGFloat((firstnameArray.count * 200))
        }
        mealTV.reloadData()
    }
    
    
    func didTapOnCheckBoxBtnAction(cell: AddMealToPassengerTVCell) {
        
        //        cell.checkBoxBool.toggle()
        //        delegate?.didTapOnCheckBoxBtnAction(cell: self)
        
    }
    
    func didTapOnShowMealDropDownListBtnAction(cell: AddMealToPassengerTVCell) {
        cell.dropDown.show()
    }
    
    
    func didTapOnShowMealDropDownListForCircleBtnAction(cell: AddMealToPassengerTVCell) {
        cell.dropDown1.show()
    }
    
    
}


extension SelectMealTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        mealTV.register(UINib(nibName: "AddMealToPassengerTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        mealTV.delegate = self
        mealTV.dataSource = self
        mealTV.tableFooterView = UIView()
        mealTV.showsHorizontalScrollIndicator = false
        mealTV.separatorStyle = .singleLine
        mealTV.isScrollEnabled = false
        mealTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstnameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddMealToPassengerTVCell {
            
            cell.selectionStyle = .none
            
            cell.delegate = self
            cell.travellerNamkelbl.text = firstnameArray[indexPath.row]
            
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType), journyType == "oneway" {
                cell.addMealView.isHidden = false
                cell.addMealView1.isHidden = true
                cell.fromcodelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromCode) ?? "")-\(defaults.string(forKey: UserDefaultsKeys.toCode) ?? "")"
            }else {
                cell.addMealView.isHidden = false
                cell.addMealView1.isHidden = false
                cell.fromcodelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromCode) ?? "")-\(defaults.string(forKey: UserDefaultsKeys.toCode) ?? "") (Departure)"
                cell.tocodelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.toCode) ?? "")-\(defaults.string(forKey: UserDefaultsKeys.fromCode) ?? "") (Return)"
            }
            
            c = cell
            
        }
        return c
    }
    
}
