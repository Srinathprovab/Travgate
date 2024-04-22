//
//  SpecialAssistanceTVCell.swift
//  Travgate
//
//  Created by FCI on 19/04/24.
//

import UIKit

class SpecialAssistanceTVCell: TableViewCell, AddSpecialAssistanceTVCellDelegate {
    
    
    @IBOutlet weak var specialAssistanceTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var firstnameArray = [String]()
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
        tvHeight.constant = CGFloat(firstnameArray.count * 97)
        specialAssistanceTV.reloadData()
        
    }
    
    
    func didTapOnCheckBoxBtnAction(cell: AddSpecialAssistanceTVCell) {
       
    }
    
    func didTapOnShowSpecialAssistanceDropDownListBtnAction(cell: AddSpecialAssistanceTVCell) {
        cell.dropDown.show()
    }
    
    
    func didTapOnServiceBtnAction(cell:NewSpecialAssistanceTVCell) {
        cell.serviceDropDown.show()
    }
    
    
}


extension SpecialAssistanceTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        specialAssistanceTV.register(UINib(nibName: "AddSpecialAssistanceTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        specialAssistanceTV.delegate = self
        specialAssistanceTV.dataSource = self
        specialAssistanceTV.tableFooterView = UIView()
        specialAssistanceTV.showsHorizontalScrollIndicator = false
        specialAssistanceTV.separatorStyle = .singleLine
        specialAssistanceTV.isScrollEnabled = false
        specialAssistanceTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstnameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddSpecialAssistanceTVCell {
            
            cell.selectionStyle = .none
            
            cell.delegate = self
            cell.travellerNamkelbl.text = firstnameArray[indexPath.row]
            
            c = cell
            
        }
        return c
    }
    
}
