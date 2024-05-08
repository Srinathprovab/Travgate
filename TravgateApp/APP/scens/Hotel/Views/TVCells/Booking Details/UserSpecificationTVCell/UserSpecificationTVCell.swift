//
//  UserSpecificationTVCell.swift
//  Travgate
//
//  Created by FCI on 19/03/24.
//

import UIKit

class UserSpecificationTVCell: TableViewCell {
    
    
    @IBOutlet weak var userSpecificationTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    
    var specificationArray = ["Please note early airrival","Please note late arrival","Please note late check out","If possible please provide adjoining rooms","If possible please provide adjoining rooms","Please note early airrival"]
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        updateHeight()
    }
    
    func updateHeight() {
        tvHeight.constant = CGFloat(MySingleton.shared.hotel_user_specification.count * 40)
        userSpecificationTV.reloadData()
    }
    
    
}


extension UserSpecificationTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupUI() {
        setupTV()
    }
    
    func setupTV() {
        userSpecificationTV.register(UINib(nibName: "AddUserSpecificationTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        userSpecificationTV.delegate = self
        userSpecificationTV.dataSource = self
        userSpecificationTV.tableFooterView = UIView()
        userSpecificationTV.showsHorizontalScrollIndicator = false
        userSpecificationTV.separatorStyle = .singleLine
        userSpecificationTV.isScrollEnabled = false
        userSpecificationTV.separatorStyle = .none
        userSpecificationTV.allowsMultipleSelection = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MySingleton.shared.hotel_user_specification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddUserSpecificationTVCell {
            
            cell.titlelbl.text = MySingleton.shared.hotel_user_specification[indexPath.row].specialrequests_name ?? ""
            
            c = cell
            
        }
        return c
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddUserSpecificationTVCell {
            cell.checkimg.image = UIImage(named: "check")
            selectedSpecificatonArray.append(cell.titlelbl.text ?? "")
            print(selectedSpecificatonArray.joined(separator: ","))
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddUserSpecificationTVCell {
            cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            
            if let index = selectedSpecificatonArray.firstIndex(of: cell.titlelbl.text ?? "") {
                selectedSpecificatonArray.remove(at: index)
                print(selectedSpecificatonArray.joined(separator: ","))
            }
        }
    }
    
}
